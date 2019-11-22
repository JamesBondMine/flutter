import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
               let documentPath = documentPaths.first ?? ""
               //方法二
               let documentPath2 = NSHomeDirectory() + "/Documents"
               print(documentPath2)// /Users/kehaoran/Library/Developer/CoreSimulator/Devices/62FD8F53-9E45-4714-A7A1-890E85E184CE/data/Containers/Data/Application/A28238F8-2935-4032-9189-C7DDFFD9FDEB/Documents
               print(documentPath)// /Users/kehaoran/
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
