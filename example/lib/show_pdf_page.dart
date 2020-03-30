import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fmpdfplugin/fmpdfplugin.dart';

class ShowPdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Pdf"),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final Uint8List _ = await Fmpdfplugin.showPdfWithNetwork(fileURL: "PDF_FILE_URL");
            },
          ),
        ),
      ),
    );
  }

  Future<String> getTempPath() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }
}
