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
              String path = await getTempPath();
              path = path + "/sample.pdf";
              File file = await File(path).create(recursive: true);
              ByteData pdfData = await rootBundle.load("assets/sample.pdf");
              final writtenFile = await file.writeAsBytes(pdfData.buffer.asUint8List(), flush: true);
              final Uint8List fileData = await Fmpdfplugin.showPdfFromLocal(file: writtenFile);
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
