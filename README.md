## Build tools & versions used
* Xcode 13.4.1
* SPM

## Steps to run the app
### App
* Open employee-directory.xcodeproj and run the project
* Kingfisher is a dependency and was added via SPM
  * It should be installed by Xcode automatically

### Tests
* Run the testing target to run the suite of XCTests

## What areas of the app did you focus on?
* Testability - I focused on ensuring all portions of the app were de-coupled enough (mostly by using Protocols) to be tested singularly without being forced into creating pseudo "integration" tests.
* Reactive programming - I've been very interested in playing around with different "reactive" type of app architectures for different projects. I attempted to adapt (read: dumb-down) a version of the [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) which would suit an app that leverages UIKit and a Coordinator pattern.
* State management & App Architecture - I wanted to implement a scalable solution that provided a single entry and exit point for updating state. The idea is to have a single reducer function which handles all manipulations to state and have that published with Combine. Leveraging MVVM, each View has a ViewModel that is bound/subscribed to the State publisher. This helps drive real-time updates in a somewhat uni-directional dataflow.
  * In addition, each action also produces a "CoordinatorEffect" to tell the coordinator to present or push a new screen. This also helps to test all navigation-related side effects in a single place.

## What was the reason for your focus? What problems were you trying to solve?
* I'm super passionate about learning and implementing the best architectures for different apps. My current implementation is far from perfect, but I thought it'd be a fun attempt and challenge to build something from scratch brining together some different technologies, particularly UIKit and Combine. I wanted to solve this problem to see how "reactive" UIKit could get outside of some of the older tools iOS developers have (i.e. KVO, Delegation, etc).


## How long did you spend on this project?
6 hours

## Did you make any trade-offs for this project? What would you have done differently with more time?
* I did not focus a ton on UI (to be honest, it is not my forte as I spend a lot of time looking up Swift APIs to format things just right).
* I instead chose to focus on getting a basic UI up as fast as possible in order to begin interating on the meat and potatoes of the app, those being the state architecture and testability.
* If afforded more time, I would try to remove some of the boilerplate code I created, particularly in the ViewModels. Each ViewController has to bind to a ViewModel which is then bound to the store/state. I'd like to develop some kind of convenience APIs to address that.
* The networking layer is pretty rudimentary. I usually aim to include things like having custom JSON decoders, query param and header logic, etc. Since we have provided links, I chose not to focus on building that portion out.

## What do you think is the weakest part of your project?
* UI - Firstly, I lack any design nous, anyone who has seeen me draw or decorate for a birthday party can attest to that. Secondly, because I wanted to focus on other parts of the app, it left me even less time to tweak the UI.
* Boilerplate - I more or less tried to make this architecture up on the fly. There is a lot of room to make this app more DRY and potentially less convoluted.

## Did you copy any code or dependencies? Please make sure to attribute them here!
Yes! I used Kingfisher as an image retrieval and caching solution (I have experience working with caching and storing files to disk, but Kingfisher just fit this use-case too well).
I also have some snippets of code (mostly helper functions and some testing utilities) that I carry around with me to most projects. Anything that was retrieved from or inspired by the internet has a comment at the top of the file beginning with `// source:`

## Is there any other information you’d like us to know?
n/a