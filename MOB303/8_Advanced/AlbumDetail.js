import React, { useEffect, useState, useReducer } from 'react';
import { Button, Card, Header, Icon, Image, Input, Loader, Message, /* Modal */ Segment } from 'semantic-ui-react';
import { API, Storage, graphqlOperation } from 'aws-amplify';
import { S3Image /*, PhotoPicker */ } from 'aws-amplify-react';
import awsconfig from './aws-exports';
import uuid from 'uuid/v4';

import useAmplifyAuth from './useAmplifyAuth';
import MLPhotoPickerModal from './MLPhotoPickerModal';

import { getAlbum as getAlbumQuery } from './graphql/queries';
import { createPhoto as createPhotoMutation } from './graphql/mutations';
import { updateAlbum as updateAlbumMutation } from './graphql/mutations';

function PhotoCard(props) {
  const [src, setSrc] = useState('');
  const { createdAt, gps, fullsize, thumbnail } = props.photo;

  return (
    <Card>
      <S3Image hidden level='protected'
            identityId={ props.owner || null }
            imgKey={ thumbnail ? thumbnail.key : fullsize.key }
            onLoad={ url => setSrc(url) } />
      <Image src={ src } />
      <Card.Content extra>
        <p><Icon name='calendar' /> { createdAt }</p>
        { gps &&
            <p><Icon name='globe' /> { gps.latitude } { gps.longitude } </p>
        }
      </Card.Content>
    </Card>
  )
};

function PhotoGrid(props) {
  return (
    <Card.Group itemsPerRow={3}>
      {
        props.photos.map((photo, i) => (
          <PhotoCard key={ i } photo={ photo } owner={ props.owner } />
        ))
      }
    </Card.Group>
  );
}

function AlbumDetail(props) {
  const {
    aws_user_files_s3_bucket_region: region,
    aws_user_files_s3_bucket: bucket
  } = awsconfig;
  
  const initalState = {
    album: {},
    photos: [],
    currentUser: null,
    // user interface
    isLoading: false,
    message: '',
    error: null
  };

  const [openModal, showModal] = useState(false);
  const [state, dispatch] = useReducer(reducer, initalState);
  const { state: { user } } = useAmplifyAuth();

  useEffect(() => {
    dispatch({ type: 'init' });
    getAlbum(props.albumId, dispatch);
  }, [props.albumId]);

  useEffect(() => {
    if (!user) { return; }
    const { username } = user;
    dispatch({ type: 'user', username });
  }, [user]);
  
  function reducer(state, action) {
    switch(action.type) {
      case 'init':
        return { ...state, isLoading: true };
      case 'set':
        return { 
          ...state,
          isLoading: false,
          album: action.album,
          photos: action.album.photos.items ? action.album.photos.items : []
        };
      case 'user':
        return { ...state, currentUser: action.username }
      case 'message':
        return { ...state, message: action.message };
      case 'error':
        return { ...state, error: true };
      default:
        new Error();
    }
  }
  
  async function getAlbum(albumId, dispatch) {
    try {
      const albumData = await API.graphql(graphqlOperation(getAlbumQuery, { id: albumId }));
      dispatch({ type: 'set', album: albumData.data.getAlbum });
    } catch (error) {
      dispatch({ type: 'error' });
      console.error('[ERROR - getAlbum] ', error);
    } 
  }
  
  async function createPhoto(data, state, dispatch) {
    if (data && data.file) {
      const { file, type: mimeType } = data;
      const extension = file.name.substr((file.name.lastIndexOf('.') + 1));
      const photoId = uuid();
      const key = `images/${photoId}.${extension}`;
  
      const inputData = {
        id: photoId,
        photoAlbumId: state.album.id,
        contentType: mimeType,
        fullsize: {
          key: key,
          region: region,
          bucket: bucket
        }
      };
  
      try {
        await Storage.put(key, file, { level: 'protected', contentType: mimeType, metadata: { albumId: state.album.id, photoId } });
        await API.graphql(graphqlOperation(createPhotoMutation, { input: inputData }));
        dispatch({ type: 'message', message: 'New photo created successfully' });
        console.log(`Successfully created photo - ${photoId}`);
        showModal(false);
      } catch(error) {
        console.error('[ERROR - createPhoto] ', error);
      }
    }
  }

  return state.isLoading ? (
    <p>loading...</p>
  ) : (
    <div>
      <MLPhotoPickerModal
          open={openModal}
          onClose={() => { showModal(false) }}
          trigger={ <Button primary floated='right' onClick={() => { showModal(true) }}>Add Photo</Button> }
          onPick={ (data) => createPhoto(data, state, dispatch) }/>
    
      <Header as='h1'>{ state.album.name }</Header>
      { state.message &&
        <Message><p>{ state.message }</p></Message> }
      <PhotoGrid photos={ state.photos } owner={ state.album.ownerId } />

      { state.currentUser === state.album.owner &&
        <AlbumSharing album={ state.album } />}
    </div>
  );
}

function AlbumSharing(props) {
  const [newUser, setNewUser] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  async function addMember() {
    setIsLoading(true);
    const inputData = {
      id: props.album.id,
      viewers: [ ...props.album.viewers || [], newUser ]
    };

    const result = await API.graphql(graphqlOperation(updateAlbumMutation, { input: inputData }));
    console.log(`${newUser} is now a viewer of album ${result.data.updateAlbum.id}`);
    setNewUser('');
    setIsLoading(false);
  };

  return (
    <Segment size='small'>
      <Header as='h4'>Album shared with...</Header>
      <p>
      { props.album.viewers ? props.album.viewers.join(', ') : 'No one' }
      </p>

      <Input placeholder='add viewer'
        size='small'
        disabled={isLoading}
        action={{ icon: 'user add', onClick: addMember }}
        onChange={ e => setNewUser(e.target.value) }
        value={ newUser } />
      <span style={{ 'paddingLeft': '1rem' }}>
        <Loader active={isLoading} inline size='small'/>
      </span>
    </Segment>
  );
}

export default AlbumDetail;
