// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/products.dart';
// import 'package:http/http.dart' as http;
// import 'package:excel/excel.dart';
// import 'dart:io'; 
// import 'package:path_provider/path_provider.dart';
// class ExcelPage extends StatefulWidget {
//   final List<Product> data;
  
//   const ExcelPage({Key? key, required this.data}) : super(key: key);
  
//   @override
//   _ExcelPageState createState() => _ExcelPageState();
// }
// class _ExcelPageState extends State<ExcelPage> {
//   String _excelData = '';
//     bool _isLoading = true;
// @override
//   void initState() {
//     super.initState();
    
//     fetchExcelData(widget.data);
//   }
//   Future<void> fetchExcelData(List<Product> data) async {
//     try {
    
//       final response = await http.post(Uri.parse('https://localhost:7041/api/products/generateExcelReport'),
//       body: data.toString(), 
//       );

//       if (response.statusCode == 200) {
       
//         final appDocDir = await getApplicationDocumentsDirectory();
//         final excelFile = '${appDocDir.path}/ProductReport.xlsx';
//         final file = await File(excelFile).writeAsBytes(response.bodyBytes);

//          final bytes = await File(excelFile).readAsBytes();
//         final excel = Excel.decodeBytes(bytes);

//         final sheet = excel.tables.keys.first;
//         final table = excel.tables[sheet]!;
        
//         setState(() {
//           _excelData = table.rows.toString();

//           _isLoading = false;

//         });
//       } else {
//         throw Exception('Failed to load Excel data');
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _isLoading = false;
//         _excelData = 'Error: Failed to load Excel data';
//       });
//     }
//   }
// @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Excel Data'),
//       ),
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : _excelData.isEmpty
//             ?Text('No data available')
//             : SingleChildScrollView(
//                 child: Text(_excelData),
//               ),
//       ),
//     );
//   }
// }