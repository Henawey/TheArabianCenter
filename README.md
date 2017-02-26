# The Arabian Center
## Dependency manager is [CocoaPods](https://cocoapods.org/)
## Architecture
 following [Clean Swift](http://clean-swift.com/) based on Uncle bob [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)

 The Main Life Cycle based on 3 letters
 **VIP**
 ![VIP](http://clean-swift.com/wp-content/uploads/2015/08/VIP-Cycle.png)

**Relation between components**
 1. The view controller’s output connects to the interactor’s input.
 2. The interactor’s output connects to the presenter’s input.
 3. The presenter’s output connects to the view controller’s input.

We’ll create special objects to pass data through the boundaries between the components. This allows us to decouple the underlying data models from the components. These special objects consists of only primitive types such as Int, Double, and String. We can create structs, classes, or enums to represent the data but there should only be primitive types inside these containing entities.

 **A typical scenario goes like.**
 1. The user taps a button in the app’s user interface.
 2. The tap gesture comes in through the IBActions in the view controller.
 3. The view controller constructs a request object and sends it to the interactor.
 4. The interactor takes the request object and performs some work. It then puts the results in a response object and sends it to the presenter.
 5. The presenter takes the response object and formats the results. It then puts the formatted result in a view model object and sends it back to the view controller.
 6. Finally, the view controller displays the results to the user.


 **Responsibility for each component**
 1. **View Controller**
 Handle user interface that the user can interact with, also collects the user inputs.
 2. **Interactor**
 Contains the app’s business logic.
 3. **Worker**
 Handle data that may be stored in Core Data or over the network. (Long time or background process).
 4. **Presenter**
 Prepare the data to be view in simplest way or in primitive data type (String,UIImage,...etc).
 *For Example:* Localization, formatting (Date,Currency,Time,...etc)
 5. **Router**
 prepare the data to be transferred to new view controller by deliver it from the interactor (view controller output) in current view controller to the interactor (view controller output) for new view controller.


## Error Handling
### Asynchronous error handling for Workers (Result pattern)
```swift
func downloadImage(imageRequest:Image.Download.Request,compilation:@escaping (Result<Image.Download.Response,Image.Download.Error>)->()) {

        ImageDownloader.default.downloadImage(with: imageRequest.url, completionHandler: { (image, error, cachType, url) in

            guard let image :UIImage = image else{
                compilation(.failure(Image.Download.Error.failDuringDownload))
                return
            }

            let respose = Image.Download.Response(image: image)
            compilation(.success(respose))
        })
```

We have a enum with 2 cases on for success and the type of the result, and one for failure and the error type

And can be used as following
```swift
let syncWorker = SyncWorker()

       syncWorker.downloadImage(imageRequest: Image.Download.Request(url: imageURL), compilation: { (result) in
           switch result{
           case let .success(response):
               self.output.presentRetrieveImageSucceed(response:response)
           case let .failure(error):
               self.output.presentRetrieveImageError(error: UI.Image.Download.Error.failure(error: error))
           }
       })
```
Using a switch statement allows powerful pattern matching, and ensures all possible results are covered

## Libraries

### [RxSwift](https://github.com/ReactiveX/RxSwift)
RxSwift is a Swift version of [Rx](https://github.com/Reactive-Extensions/Rx.NET), It is a combination of the Observer pattern, the Iterator pattern, and functional programming.

It is to enable easy composition of asynchronous operations and event/data streams, KVO observing, async operations and streams are all unified under abstraction of sequence. This is the reason why Rx is so simple, elegant and powerful.

for more info: [ReactiveX](http://reactivex.io/)

### [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa/iOS)
RxSwift extensions for UI, NSURLSession, KVO ...

### [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
It is an iOS drop-in class that displays a translucent HUD with an indicator and/or labels while work is being done in a background thread.

### [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
It is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON.

### [Result](https://github.com/antitypical/Result)
`Result<Value, Error>` values are either successful (wrapping `Value`) or failed (wrapping `Error`). This is similar to Swift’s native `Optional` type: `success` is like `some`, and `failure` is like `none` except with an associated `Error` value. The addition of an associated `Error` allows errors to be passed along for logging or displaying to the user.

### [PermissionScope](https://github.com/nickoneill/PermissionScope)
It is a Swift framework for intelligently requesting permissions from users. It contains not only a simple UI to request permissions but also a unified permissions API that can tell you the status of any given system permission or easily request them.

### [URLNavigator](https://github.com/devxoul/URLNavigator)
It provides an elegant way to navigate through view controllers by URLs.

### [Kingfisher](https://github.com/onevcat/Kingfisher)
It is a lightweight, pure-Swift library for downloading and caching images from the web.


## Development and Release notes
1. **Localization:** Apple recommend to restart the iOS app, but this is not what developers and business team prefer so I make something to load the localization of the app in runtime without restarting.
To make every thing in the app localized perfectly you should restarting the app.(UIImagePickerController, Permissions Popup)

2. **Deep Linking** [[Ref][Ref]] I’m working with URI scheme for Deeplinking not Associated Domains(iOS 9+)
 because I don’t have iOS Apple Developer membership

3. In order to use a URI scheme, I have to manually handle the case of the app not being installed. The typical process was to attempt to open up the app in Javascript by setting window.location to the URI path that you wanted. (Twitter Only)

4. Unit Tests and 1 UI test cases added as samples

[Ref]: https://developer.apple.com/support/app-capabilities/ "Ref"
