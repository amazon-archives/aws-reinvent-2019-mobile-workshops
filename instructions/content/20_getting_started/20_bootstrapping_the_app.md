+++
title = "Bootstrapping the App"
chapter = false
weight = 20
+++

The starting point for the workshop is the [Apple Swift UI tutorial](https://developer.apple.com/tutorials/swiftui/tutorials) at the "Handling User Input" step.

1. Download the {{% button href="/20_getting_started/20_bootstrapping_the_app.files/HandlingUserInput.zip" icon="fas fa-download" %}}project zip file{{% /button %}}

1. Unzip the file, it creates the following directory structure
![Directory Structure](/images/20-10-directory-structure.png)

1. This workshop will start from the *Complete* version of the tutorial project.  
In the remaining part of this workshop, `$PROJECT_DIRECTORY` will refer to `HandlingUserInput/Complete/Landmarks`.  
Open the XCode project:
```bash
cd ~/Downloads
mkdir amplify-ios-workshop 
cd amplify-ios-workshop
unzip ../HandlingUserInput.zip

PROJECT_DIRECTORY=~/Downloads/amplify-ios-workshop/Complete/Landmarks
cd $PROJECT_DIRECTORY

open HandlingUserInput.xcodeproj
```

**Choose** the iOS Simulator you want to use (I am using iPhone 11) and click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;B**.
![First build](/images/20-10-xcode.png)

After a few seconds, you should see the application running in the iOS simulator.
![First run](/images/20-10-app-start.png)

In the following steps, we will guide you through step by step instructions to modify this app to add user authentication and a data-driven API.

{{% notice warning %}}
If the example application in not starting or not working as described above, do not proceed to the next section. The instructions will fail at some point.</a>
{{% /notice %}}

{{%attachments title="Project files" pattern=".*.zip"/%}}