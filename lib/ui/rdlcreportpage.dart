import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_application_1/models/products.dart';

class ReportViewerPage extends StatefulWidget {
  final List<Product> data;
  const ReportViewerPage({Key? key, required this.data}) : super(key: key);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<ReportViewerPage> {
  PDFDocument? document;
  //WebViewController _controller;
  bool _isLoading = true;
  String? localPath;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    loadDocument(widget.data);
  }

  Future<void> loadDocument(List<Product> data) async {
    // Replace 'YOUR_API_URL' with the actual URL of your PDF document from the web API
    final String baseurl = "https://localhost:7041/api/products";

    final uri = Uri.parse('$baseurl?reportName=productDetails&reportType=pdf');
    final jsonString = '''

 ${jsonEncode(data.map((product) => product.toJson()).toList())}

''';
    try {
      // Fetch PDF document from the web API
      final response = await http.post(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
        body: jsonString,
      );

      print('jsonString: $jsonString');
      print('body1: ${response.bodyBytes}');
      print('body2: ${response.body}');
      print('data4: ${widget.data}');
      print('data3: $data');
      print('statusCode: ${response.statusCode}');
      // Check if the request was successful
      if (response.statusCode == 200) {
        // Save the PDF file locally
        final String dir = (await getApplicationDocumentsDirectory()).path;
        final File file = File('$dir/productDetails.pdf');
        print('dir: $dir');
        await file.writeAsBytes(response.bodyBytes);
        print('bodyBytes: ${response.bodyBytes}');
        if (await file.exists()) {
          print('fileExist: $file');
          // document = await PDFDocument.memory(response.bodyBytes);
          //print('document: $document');
          setState(() {
            localPath = file.path;
            print('localPath: $localPath');
            _isLoading = false;
          });
        } else {
          throw Exception('File not found at ${file.path}');
        }
        // Load the saved PDF file using advance_pdf_viewer
      } else {
        // Handle errors
        throw Exception('Failed to load PDF document');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show loading indicator while loading document
            : localPath != null
                ? SfPdfViewer.file(
                    File(localPath!),
                  )
                : Text('not loaded'),
      ),
    );
  }
}
