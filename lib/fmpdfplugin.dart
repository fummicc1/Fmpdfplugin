import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class Fmpdfplugin {
  static const MethodChannel _channel =
      const MethodChannel('fmpdfplugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future showPdfWithLocalFile({File file}) async {
    final result = await _channel.invokeMethod("show_pdf", {
      "file_path": file.path
    });
    return result;
  }

  static Future showPdfWithData({Uint8List pdfData}) async {
    final result = await _channel.invokeMethod("show_pdf_with_data", {
      "data": pdfData
    });
    return result;
  }
}
