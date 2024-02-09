# Cookify

## Abstract
The goal of this project was to create a narrow-focus social media iOS app to share the cooking experience. We wanted to focus our design and creation of this app on what we see as healthy design patterns and avoid common pitfalls of social media apps that lead to isolating and addictive software. Social media can help build community and spread valuable information. However, many apps are addictive, and they can also further feelings of loneliness. Many of these negative effects are the product of "addictive software design" which includes the implementation of features like infinite scrolling. Meanwhile, food encourages authenticity and acts as a cultural unifier, allowing us to share new experiences. 

## Running Cookify
The Cookify folder in this repository is an Xcode project. To run / edit / view the code in this project, first ensure that Xcode is installed. Then, clone this repository, and open the Cookify/Cookify.xcodeproj file, which will open up the Xcode editor allowing you to navigate and view the project files. Most of the code files for the app are in the Cookify/Cookify/Code/Features folder, as either Swift or SwiftUI files.

The Xcode editor has options to both build the entire application or preview certain parts, either on a physical device or simulated device. Previewing the application is generally much faster than building the entire application and allows for updates to the code to be reflected live in the preview without have to re-build. Only SwiftUI files with a view can be previewed.

To build or preview the app the app, first select a runtime destination. This could be either a physical device connected via Bluetooth or a cable, or a simulated device running on Xcode’s iOS simulator. The preview screen will be available via the canvas pane in the editor. To build, click the start arrow in the top left of the editor.

## Using Cookify
To use the application, you must first create an account on the login / signup page. Once logged in, there are 3 screens, the feed, record, and account. The feed displays content from users you follow, record is where you record your cooking experience, and account is where you see your own posts. To record and post you cooking experience, navigate to the record page. Enter information such as the title, description, and servings. Start the prep timer once you start prepping the meal, and the cook timer once it starts cooking to record those times as well. Take some pictures on your phone, and then upload up to 6 to your post. Once you’re ready, click the serve button to post your post. 

## Acknowledgments
We would like to thank Professor Caplan for providing guidance on this project throughout the semester, as well as the rest of the F23 701 class for providing feedback.

## License
