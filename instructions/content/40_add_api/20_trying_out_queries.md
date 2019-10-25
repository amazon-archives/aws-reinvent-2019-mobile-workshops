+++
title = "Trying out some queries"
chapter = false
weight = 20
+++


**Open the AWS Console** and **click into the amplifyiosworkshop-dev API**. Now we can start poking around with the API.

{{% tabs %}}
{{% tab "us-west-2" "North America" %}}
Link to [AWS AppSync web console in Oregon](https://console.aws.amazon.com/appsync/home?region=us-east-1#/apis)
{{% /tab %}}

{{% tab  "eu-central-1"  "Europe" %}}
Link to [AWS AppSync web console in Frankfurt](https://console.aws.amazon.com/appsync/home?region=eu-west-1#/apis)
{{% /tab %}}
{{% /tabs %}}

**Click Queries** in the sidebar on the left.

![appsync queries](/images/40-20-appsync-1.png)

This area is AWS AppSync's interactive query explorer. We can write queries and mutations here, execute them, and see the results. It's a great way to test things out to make sure our resolvers are working the way we expect.

### Authenticating to AppSync

{{% notice warning %}}
Before we can issue queries, we'll need to authenticate (because our AppSync API is configured to authenticate users via the Amazon Cognito User Pool we set up when we configured the authentication for our app.
{{% /notice %}}

1. **Click the Login with User Pools button** at the top of the query editor.

1. Look up the value for the **ClientId** field
    1.  Click on the link to open the Cognito console in your Region: [Northern America](https://eu-west-1.console.aws.amazon.com/cognito/users/?region=us-east-1#/) or [Europe](https://eu-west-1.console.aws.amazon.com/cognito/users/?region=eu-central-1#/)
    2.  Select the User Pool named **amplifyiosworkshopxxxxx_userpool_xxxx-dev** (the xxx is generated randomly and will vary)
    3. Click **App Client** on the left menu and click **Show Details** to reveal both the App client id and the App client secret.  Copy the **App client id** for the app that has (no secret key)

    ![app client id](/images/40-20-appsync-2.png)

1. Go back to the **AppSync console**, in the **Query** section Paste the value into the **ClientId** field

1. **Enter your credentials** for the user you created when we added authentication

1. **Click Login**

![appsync authentication](/images/40-20-appsync-3.png)

### Trying out some queries

You should now be able to try out the following mutations and queries. Press the orange 'play' button to execute queries and mutations.

**Add a new Landmark** by copy/pasting the following and running the query:

```graphql
mutation CreateLandmark($input: CreateLandmarkInput!) {
    createLandmark(input: $input) {
        id
    }
}
```

Open the **Query Variables** section on the bottom and copy / paste the following data:

```json
{ "input" : 
    {
        "name": "Lake Umbagog",
        "category": "Lakes",
        "city": "Errol",
        "state": "New Hampshire",
        "id": 9999,
        "isFeatured": true,
        "isFavorite": false,
        "park": "Umbagog National Wildlife Refuge",
        "coordinates": {
            "longitude": -71.056816,
            "latitude": 44.747408
        },
        "imageName": "umbagog"
    }  
}
```

Click the orange Play button (<i class="far fa-caret-square-right" aria-hidden="true" style="background: orange; color: white;"></i>) to execute the query.


**Get the Landmark**  we just created by running this query:

```graphql
query GetLandmark {
    getLandmark(id: 9999) {
        id
        name
        category
        city
        state
        isFeatured
        isFavorite
        park
        coordinates {
            longitude
            latitude
        }
        imageName
    }
}
```   

Click the orange Play button (<i class="far fa-caret-square-right" aria-hidden="true" style="background: orange; color: white;"></i>) to execute the query.

**List all the landmarks** with this query :

```graphql
query ListLandmarks {
    listLandmarks {
        items {
            id
            name
            category
            city
            state
            isFeatured
            isFavorite
            park
            coordinates {
                longitude
                latitude
            }
            imageName
        }
        nextToken
    }
}
```

Click the orange Play button (<i class="far fa-caret-square-right" aria-hidden="true" style="background: orange; color: white;"></i>) to execute the query.

Finally, **delete the landmark** we created with this query:

```graphql
mutation DeleteLandmark {
  deleteLandmark(input: { id: 9999 }) {
    id
    name
    category
    city
    state
    isFeatured
    isFavorite
    park
    coordinates {
      longitude
      latitude
    }
    imageName
  }
}
```

Click the orange Play button (<i class="far fa-caret-square-right" aria-hidden="true" style="background: orange; color: white;"></i>) to execute the query.


As you can see, we're able to read and write data through GraphQL queries and mutations and AppSync takes care of reading and persisting data (in this case, to DynamoDB).