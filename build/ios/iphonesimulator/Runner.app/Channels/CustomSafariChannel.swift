import Foundation

class CustomSafariChannel {

    static let instance = CustomSafariChannel()

    private static let CHANNEL = "com.example.safari.safari_webview_spike/safari"

    // TO native actions.
    private static let ACTION_TO_LAUNCH = "ACTION_TO_LAUNCH"

    private init() {}

    func setupMethodChannel(
        navigationController: UINavigationController,
        flutterViewController: FlutterViewController
    ) {
        let methodChannel = FlutterMethodChannel(
            name: CustomSafariChannel.CHANNEL,
            binaryMessenger: flutterViewController.binaryMessenger
        )

        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        
            if call.method == CustomSafariChannel.ACTION_TO_LAUNCH {
                let safariView = CustomSafariView()
                
                navigationController.pushViewController(
                    safariView,
                    animated: true
                )
                result(1)
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
        })
    }

}
