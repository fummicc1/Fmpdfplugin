import Flutter
import UIKit
import PDFKit

extension FlutterError {
    static let noArgument: FlutterError = .init(code: "noArgument", message: nil, details: nil)
    static let unexpectedArgument: FlutterError = .init(code: "unexpectedArgument", message: nil, details: nil)
    static let noRootViewController: FlutterError = .init(code: "noRootViewController", message: nil, details: nil)
    static let failedToDecodePdfData: FlutterError = .init(code: "failedToDecodePdfData", message: nil, details: nil)
}

public class SwiftFmpdfpluginPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fmpdfplugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFmpdfpluginPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments = call.arguments as? [String: Any] else {
        result(FlutterError.noArgument)
        return
    }
    guard let viewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
        result(FlutterError.noRootViewController)
        return
    }
    let pdfView = PDFView()
    pdfView.autoScales = true
    pdfView.frame = viewController.view.bounds
    if call.method == "show_pdf" {
        guard let filePath = arguments["file_path"] as? String, let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            result(FlutterError.unexpectedArgument)
            return
        }
        guard let document = PDFDocument(data: fileData) else {
            result(FlutterError.failedToDecodePdfData)
            return
        }
        pdfView.document = document
        viewController.view.addSubview(pdfView)
        result(fileData)
    } else if call.method == "show_pdf_with_data" {
        guard let data = arguments["data"] as? Data else {
            result(FlutterError.unexpectedArgument)
            return
        }
        guard let document = PDFDocument(data: data) else {
            result(FlutterError.failedToDecodePdfData)
            return
        }
        pdfView.document = document
        viewController.view.addSubview(pdfView)
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
