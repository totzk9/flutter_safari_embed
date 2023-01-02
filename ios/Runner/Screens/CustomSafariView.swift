import SwiftUI
import UIKit
import Flutter
import SafariServices

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
//        _view.backgroundColor = UIColor.blue
//        let childView = UIHostingController(rootView: ContentView())
//        childView.view.frame = frame

//        _view.addSubview(childView.view)
        
        
//        _view.addConstraint(NSLayoutConstraint)
        
//        _view.addConstrained(subview: childView.view)
//        childView.didMove(toParent: _view.inputViewController)
        
        let childView = UIHostingController(rootView: MyViewController().)
        _view.addSubview(MyViewController().embed(UIViewController, inView: <#T##UIView#>))
    }

    func view() -> UIView {
        return _view
    }

}

class MyViewController: UIViewController, SFSafariViewControllerDelegate {

  // And implement the delmegate func

     func safariViewControllerDidFinish(safariViewControllerDidFinish: SFSafariViewController) {
         safariViewControllerDidFinish.dismiss(animated: true)
     }

     @IBAction func openWithSafariVC(sender: AnyObject) {
         let safariVc = SFSafariViewController(url:  URL(string: "https://www.google.com")!)
         safariVc.delegate = self
         self.present(safariVc, animated: true, completion: nil)
     }

}

//struct ContentView: View {
//
//    var body: some View {
//        VStack {
//            SFSafariViewWrapper(url: URL(string: "https://www.google.com")!)
//        }
//
//
//    }
//}
//
//struct SFSafariViewWrapper: UIViewControllerRepresentable {
//    let url: URL
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
//        return SFSafariViewController(url: url)
//    }
//
//    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
//        return
//    }
//}

extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}


extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
