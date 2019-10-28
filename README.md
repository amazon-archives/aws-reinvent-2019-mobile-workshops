This is the source code for [https://amplify-ios-workshop.go-aws.com/](https://amplify-ios-workshop.go-aws.com/)

## Status

**Oct 27**
First draft of workshop instruction released

**Oct 23**
Workshop web site is scaffolded and deployment pipeline ready.

**Oct 22**
Final application is working and demo-able.  Some tweaks and improvements can be done, but I have a basis to start to write the core of the workshop now.

### TODO

- [X] scaffold the workshop web site
- [X] host the project on github + amplify console for hosting and CI/CD.  Use the shared evangelist account.
- [X] write the workshop instructions
- [X] add instructions for identity federation (section 6)
- [X] add instruction to use a custom GUI screen (section 7)
- [ ] refactor code to download images asynchronously 
- [X] cache downloaded images
- [ ] eliminate the TODO in the code
- [X] Fix landmark details page 
- [ ] use Hugo page resource to load images
- [ ] test and dry run

### Dir Structure

```text
x (you are here)
|
|-- code
      |-- Complete       <== this is the final result of the workshop
      |-- StartingPoint  <== this is the starting point of the app
|
|-- instructions         <== this is the static web site
```

### Deploy

The instruction web site is generated with [Hugo](https://gohugo.io) and the [Learn theme](https://learn.netlify.com/en/).
To build the web site :
```
cd instructions
hugo
```

This site is automatically deployed to https://amplify-ios-workshop.go-aws.com
