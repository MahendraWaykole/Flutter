import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/ui/ProductList.dart';
import 'package:flutter_application_1/ui/addnewproduct.dart';
import 'package:flutter_application_1/models/api.services.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/ui/reportpage.dart';
import 'package:flutter_application_1/ui/rdlcInvoicepage.dart';
import 'package:flutter_application_1/ui/rdlcreportpage.dart';
// import 'package:flutter_application_1/ui/excelPage.dart';
import 'package:flutter_application_1/models/MenuItem.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MainPage extends StatefulWidget {
  final void Function(BuildContext) openMenu;
  const MainPage({Key? key, required this.openMenu}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 16, top: 16),
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Text('ff')],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MainPageState extends State<MainPage> {
  List<Product> tableData = [];
  void _openMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: _viewMenuItems.map((item) {
        return PopupMenuItem(
          child: Text(item.title),
          onTap: () {
            item.onSelected(context);
          },
        );
      }).toList(),
    );
  }

  Future<void> fetchTableData() async {
    final apiService = APIServices();
    final fetchedData = await apiService.fetchtable();
    print('Fetched data: $fetchedData');
    setState(() {
      tableData = fetchedData;
    });
    print('Table data: $tableData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ProductManagementApp'),
            SizedBox(height: 4), // Adjust spacing between title and toolbar
            Row(
              children: [
                _buildToolbarButton('Main', _mainMenuItems),
                SizedBox(width: 10),
                _buildToolbarButton('Tools', _toolsMenuItems),
                SizedBox(width: 10),
                _buildToolbarButton('Reports', _reportsMenuItems),
                SizedBox(width: 10),
                _buildToolbarButton('View', _viewMenuItems),
                SizedBox(width: 10),
                _buildToolbarButton('Help', _helpMenuItems),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Para
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEWSFEED',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nearly 50% of customer orders from India’s fulfilment network now come with reduced packaging',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 3, // Adjust elevation as needed
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOP STORIES',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '25 new products coming here this February.',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 3, // Adjust elevation as needed
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RETAIL',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '15 smart tech gadgets under ₹5,000 to simplify your life.',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildElevatedButton('Show DataTable', fetchTableData),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewRdlcReportPage2(tableData: tableData),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.report),
                          Text('View Rdlc Report',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewExcelPage(tableData: tableData),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.report),
                          Text('Export to Excel',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_product');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Add Product',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/view_products');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.list),
                          Text('View Products',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildDataTable(),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolbarButton(String label, List<MenuItem> menuItems) {
    return PopupMenuButton<MenuItem>(
      itemBuilder: (BuildContext context) => menuItems
          .map((item) => PopupMenuItem<MenuItem>(
                value: item,
                child: SizedBox(
                  width: 50, // Adjust the width as needed
                  child: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 10), // Adjust the font size as needed
                  ),
                ),
              ))
          .toList(),
      onSelected: (MenuItem menuItem) {
        // Handle menu item selection
        menuItem.onSelected(context);
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  List<MenuItem> _toolsMenuItems = [
    MenuItem(
        title: 'Option 1',
        onSelected: (BuildContext context) => print('Option 1 clicked')),
    MenuItem(
        title: 'Option 2',
        onSelected: (BuildContext context) => print('Option 2 clicked')),
  ];

  List<MenuItem> _reportsMenuItems = [
    MenuItem(
        title: 'Generate Report',
        onSelected: (BuildContext context) => print('Generate Report clicked')),
    MenuItem(
        title: 'View Report',
        onSelected: (BuildContext context) => print('View Report clicked')),
  ];

  List<MenuItem> _mainMenuItems = [
    MenuItem(
        title: 'Option 1',
        onSelected: (BuildContext context) => print('Option 1 clicked')),
    MenuItem(
        title: 'Option 2',
        onSelected: (BuildContext context) => print('Option 2 clickedd')),
  ];

  Widget _buildElevatedButton(String label, Function onPressed) {
    return SizedBox(
      width: label.length * 11.0,
      child: ElevatedButton(
        onPressed: () async {
          await onPressed();
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 20.0,
            columns: <DataColumn>[
              DataColumn(label: Text('Sr. No')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Product Cost'), numeric: true),
              DataColumn(label: Text('Product Description')),
            ],
            rows: tableData.isEmpty
                ? [
                    DataRow(cells: [
                      DataCell(Text('',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                      DataCell(Text('No data available',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                      DataCell(Text('',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                      DataCell(Text('',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                    ])
                  ]
                : tableData
                    .asMap()
                    .entries
                    .map(
                      (entry) => DataRow(
                        cells: [
                          DataCell(Text((entry.key + 1).toString())),
                          DataCell(Text(entry.value.productName)),
                          DataCell(Text(entry.value.productCost.toString())),
                          DataCell(Text(entry.value.productDesc)),
                        ],
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}

class AddNewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Center(
        child: AddNewProduct(),
      ),
    );
  }
}

class ViewExcelPage extends StatelessWidget {
  final List<Product> tableData;
  const ViewExcelPage({Key? key, required this.tableData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Excel'),
      ),
      // body: Center(
      //   child: ExcelPage(data: tableData),
      // ),
    );
  }
}

class ViewReportPage extends StatelessWidget {
  final List<Product> tableData;
  const ViewReportPage({Key? key, required this.tableData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Report'),
      ),
      body: Center(
        child: reportPage(data: tableData),
      ),
    );
  }
}

class FormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your name'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implement form submission logic here
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ViewRdlcReportPage extends StatelessWidget {
  final List<Product> tableData;
  const ViewRdlcReportPage({Key? key, required this.tableData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PdfViewerPage(),
      ),
    );
  }
}

class FormOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your question'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implement form submission logic here
              Navigator.pop(context); // Close the overlay
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ViewRdlcReportPage2 extends StatelessWidget {
  final List<Product> tableData;
  const ViewRdlcReportPage2({Key? key, required this.tableData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReportViewerPage(data: tableData),
      ),
    );
  }
}

class ViewProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Products'),
      ),
      body: Center(
        child: ProductList(),
      ),
    );
  }
}

List<MenuItem> _helpMenuItems = [
  MenuItem(
    title: 'FAQs',
    onSelected: (BuildContext context) =>
        _handleHelpMenuItemSelected(context, 0),
  ),
  MenuItem(
      title: 'Contact Us',
      onSelected: (BuildContext context) => print('Contact Us clicked')),
];
List<MenuItem> _viewMenuItems = [
  MenuItem(
    title: 'Screens 1',
    onSelected: (BuildContext context) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return CustomBottomSheet();
        },
      );
    },
  ),
  MenuItem(
    title: 'Screen 2',
    onSelected: (BuildContext context) {
      _openBasicForm(context);
    },
  ),
];

class _BasicFormBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 15, top: 0),
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0), // Add padding to the text
                  child: Text('Originator Setup 14'),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.minimize),
                      onPressed: () {
                        // Minimize functionality
                        print('Minimize button clicked');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.fullscreen),
                      onPressed: () {
                        // Full screen functionality
                        print('Full screen button clicked');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class BasicFormBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 15, top: 0),
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0), // Add padding to the text
                  child: Text('Originator Setup 14'),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.minimize),
                      onPressed: () {
                        // Minimize functionality
                        print('Minimize button clicked');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.fullscreen),
                      onPressed: () {
                        // Full screen functionality
                        print('Full screen button clicked');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10, // Adjust top position as needed
          left: 0,
          right: 0,
          child: SizedBox(height: 16), // Add SizedBox below the header
        ),
        Positioned(
          top: 50, // Adjust top position as needed
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1, // Make the first partition smaller
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text('Small Partition'),
                  ),
                ),
              ),
              Expanded(
                flex: 3, // Make the second partition larger
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text('Large Partition'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _handleHelpMenuItemSelected(BuildContext context, int index) {
  // _helpMenuItems[index].onSelected(context);
  if (index == 0) {
    // Open FAQ form overlay when FAQ menu item is selected
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return FormOverlay();
      },
    );
  } else {
    _helpMenuItems[index].onSelected(context);
  }
}

void _openBasicForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return Center(
        // Wrap the bottom sheet content with Center
        child: BasicFormBottomSheet(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Make it non-dismissible when tapping outside
      builder: (BuildContext context) {
        return CustomBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(openMenu: _openMenu),
        '/add_product': (context) => AddNewProductPage(),
        '/view_products': (context) => ViewProductsPage(),
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_application_1/ui/ProductList.dart';
// import 'package:flutter_application_1/ui/addnewproduct.dart';
// import 'package:flutter_application_1/models/api.services.dart';
// import 'package:flutter_application_1/models/products.dart';
// import 'package:flutter_application_1/ui/reportpage.dart';
// import 'package:flutter_application_1/ui/rdlcInvoicepage.dart';
// import 'package:flutter_application_1/ui/rdlcreportpage.dart';
// // import 'package:flutter_application_1/ui/excelPage.dart';
// import 'package:flutter_application_1/models/MenuItem.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MainPage extends StatefulWidget {
//   final void Function(BuildContext) openMenu;
//   const MainPage({Key? key, required this.openMenu}) : super(key: key);
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class CustomBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.only(right: 16, top: 16),
//             alignment: Alignment.topRight,
//             child: IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 Navigator.pop(context); // Close the bottom sheet
//               },
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(16.0),
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [Text('ff')],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _MainPageState extends State<MainPage> {
//   List<Product> tableData = [];
//   void _openMenu(BuildContext context) {
//     showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(100, 100, 0, 0),
//       items: _viewMenuItems.map((item) {
//         return PopupMenuItem(
//           child: Text(item.title),
//           onTap: () {
//             item.onSelected(context);
//           },
//         );
//       }).toList(),
//     );
//   }

//   Future<void> fetchTableData() async {
//     final apiService = APIServices();
//     final fetchedData = await apiService.fetchtable();
//     print('Fetched data: $fetchedData');
//     setState(() {
//       tableData = fetchedData;
//     });
//     print('Table data: $tableData');
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Main Page'),
//   //     ),
//   //     body: Center(
//   //       child: ElevatedButton(
//   //         onPressed: () {
//   //           // Call openMenu to open the menu
//   //           _openMenu(context);
//   //         },
//   //         child: Text('Open Menu'),
//   //       ),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ProductManagementApp'),
//             SizedBox(height: 4), // Adjust spacing between title and toolbar
//             Row(
//               children: [
//                 _buildToolbarButton('Main', _mainMenuItems),
//                 SizedBox(width: 10),
//                 _buildToolbarButton('Tools', _toolsMenuItems),
//                 SizedBox(width: 10),
//                 _buildToolbarButton('Reports', _reportsMenuItems),
//                 SizedBox(width: 10),
//                 _buildToolbarButton('View', _viewMenuItems),
//                 SizedBox(width: 10),
//                 _buildToolbarButton('Help', _helpMenuItems),
//                 SizedBox(width: 10),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // First Para
//                 Card(
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'NEWSFEED',
//                           style: TextStyle(fontSize: 20.0),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           'Nearly 50% of customer orders from India’s fulfilment network now come with reduced packaging',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Card(
//                         elevation: 3, // Adjust elevation as needed
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'TOP STORIES',
//                                 style: TextStyle(fontSize: 16.0),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 '25 new products coming here this February.',
//                                 style: TextStyle(fontSize: 14.0),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       flex: 2,
//                       child: Card(
//                         elevation: 3, // Adjust elevation as needed
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'RETAIL',
//                                 style: TextStyle(fontSize: 16.0),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 '15 smart tech gadgets under ₹5,000 to simplify your life.',
//                                 style: TextStyle(fontSize: 14.0),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildElevatedButton('Show DataTable', fetchTableData),
//                     // SizedBox(width: 10),
//                     // TextButton(
//                     //   onPressed: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (context) =>
//                     //             ViewReportPage(tableData: tableData),
//                     //       ),
//                     //     );
//                     //   },
//                     //   child: Row(
//                     //     children: [
//                     //       Icon(Icons.report),
//                     //       Text('View Report',
//                     //           style: TextStyle(color: Colors.black)),
//                     //     ],
//                     //   ),
//                     // ),

//                     //  SizedBox(width: 10),
//                     //   TextButton(
//                     //     onPressed: () {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) =>
//                     //               ViewRdlcReportPage(tableData: tableData),
//                     //         ),
//                     //       );
//                     //     },
//                     //     child: Row(
//                     //       children: [
//                     //         Icon(Icons.report),
//                     //         Text('View Rdlc Report',
//                     //             style: TextStyle(color: Colors.black)),
//                     //       ],
//                     //     ),
//                     //   ),
//                     SizedBox(width: 10),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ViewRdlcReportPage2(tableData: tableData),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.report),
//                           Text('View Rdlc Report',
//                               style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ViewExcelPage(tableData: tableData),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.report),
//                           Text('Export to Excel',
//                               style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/add_product');
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.add),
//                           Text('Add Product',
//                               style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/view_products');
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.list),
//                           Text('View Products',
//                               style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 _buildDataTable(),
//                 SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildToolbarButton(String label, List<MenuItem> menuItems) {
//     return PopupMenuButton<MenuItem>(
//       itemBuilder: (BuildContext context) => menuItems
//           .map((item) => PopupMenuItem<MenuItem>(
//                 value: item,
//                 child: SizedBox(
//                   width: 50, // Adjust the width as needed
//                   child: Text(
//                     item.title,
//                     style: TextStyle(
//                         fontSize: 10), // Adjust the font size as needed
//                   ),
//                 ),
//               ))
//           .toList(),
//       onSelected: (MenuItem menuItem) {
//         // Handle menu item selection
//         menuItem.onSelected(context);
//       },
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 12,
//         ),
//       ),
//     );
//   }

//   List<MenuItem> _toolsMenuItems = [
//     MenuItem(
//         title: 'Option 1',
//         onSelected: (BuildContext context) => print('Option 1 clicked')),
//     MenuItem(
//         title: 'Option 2',
//         onSelected: (BuildContext context) => print('Option 2 clicked')),
//   ];

//   List<MenuItem> _reportsMenuItems = [
//     MenuItem(
//         title: 'Generate Report',
//         onSelected: (BuildContext context) => print('Generate Report clicked')),
//     MenuItem(
//         title: 'View Report',
//         onSelected: (BuildContext context) => print('View Report clicked')),
//   ];

//   List<MenuItem> _mainMenuItems = [
//     MenuItem(
//         title: 'Option 1',
//         onSelected: (BuildContext context) => print('Option 1 clicked')),
//     MenuItem(
//         title: 'Option 2',
//         onSelected: (BuildContext context) => print('Option 2 clickedd')),
//   ];

//   Widget _buildElevatedButton(String label, Function onPressed) {
//     return SizedBox(
//       width: label.length * 11.0,
//       child: ElevatedButton(
//         onPressed: () async {
//           await onPressed();
//         },
//         child: Text(label),
//       ),
//     );
//   }

//   Widget _buildDataTable() {
//     return Expanded(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           child: DataTable(
//             columnSpacing: 20.0,
//             columns: <DataColumn>[
//               DataColumn(label: Text('Sr. No')),
//               DataColumn(label: Text('Product Name')),
//               DataColumn(label: Text('Product Cost'), numeric: true),
//               DataColumn(label: Text('Product Description')),
//             ],
//             rows: tableData.isEmpty
//                 ? [
//                     DataRow(cells: [
//                       DataCell(Text('',
//                           style: TextStyle(fontStyle: FontStyle.italic))),
//                       DataCell(Text('No data available',
//                           style: TextStyle(fontStyle: FontStyle.italic))),
//                       DataCell(Text('',
//                           style: TextStyle(fontStyle: FontStyle.italic))),
//                       DataCell(Text('',
//                           style: TextStyle(fontStyle: FontStyle.italic))),
//                     ])
//                   ]
//                 : tableData
//                     .asMap()
//                     .entries
//                     .map(
//                       (entry) => DataRow(
//                         cells: [
//                           DataCell(Text((entry.key + 1).toString())),
//                           DataCell(Text(entry.value.productName)),
//                           DataCell(Text(entry.value.productCost.toString())),
//                           DataCell(Text(entry.value.productDesc)),
//                         ],
//                       ),
//                     )
//                     .toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddNewProductPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Product'),
//       ),
//       body: Center(
//         child: AddNewProduct(),
//       ),
//     );
//   }
// }

// class ViewExcelPage extends StatelessWidget {
//   final List<Product> tableData;
//   const ViewExcelPage({Key? key, required this.tableData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Excel'),
//       ),
//       // body: Center(
//       //   child: ExcelPage(data: tableData),
//       // ),
//     );
//   }
// }

// class ViewReportPage extends StatelessWidget {
//   final List<Product> tableData;
//   const ViewReportPage({Key? key, required this.tableData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Report'),
//       ),
//       body: Center(
//         child: reportPage(data: tableData),
//       ),
//     );
//   }
// }

// class FormScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Enter your name'),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               // Implement form submission logic here
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ViewRdlcReportPage extends StatelessWidget {
//   final List<Product> tableData;
//   const ViewRdlcReportPage({Key? key, required this.tableData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //  return MaterialApp(
//     //     title: 'Flutter Report Viewer',
//     //     theme: ThemeData(
//     //       primarySwatch: Colors.blue,
//     //     ),
//     //     home: PdfViewerPage(),
//     //   );
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('View rdlc Report'),
//       // ),
//       body: Center(
//         child: PdfViewerPage(),
//       ),
//     );
//   }
// }

// class ViewRdlcReportPage2 extends StatelessWidget {
//   final List<Product> tableData;
//   const ViewRdlcReportPage2({Key? key, required this.tableData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //  return MaterialApp(
//     //     title: 'Flutter Report Viewer',
//     //     theme: ThemeData(
//     //       primarySwatch: Colors.blue,
//     //     ),
//     //     home: PdfViewerPage(),
//     //   );
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('View rdlc Report'),
//       // ),
//       body: Center(
//         child: ReportViewerPage(data: tableData),
//       ),
//     );
//   }
// }

// class ViewProductsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Products'),
//       ),
//       body: Center(
//         child: ProductList(),
//       ),
//     );
//   }
// }
//  List<MenuItem> _helpMenuItems = [
//     MenuItem(
//         title: 'FAQs',
//         onSelected: (BuildContext context) => print('FAQs clicked')),
//     MenuItem(
//         title: 'Contact Us',
//         onSelected: (BuildContext context) => print('Contact Us clicked')),
//   ];
// List<MenuItem> _viewMenuItems = [
//   MenuItem(
//     title: 'Screens 1',
//     onSelected: (BuildContext context) {
//       showModalBottomSheet(
//         context: context,
//         isDismissible: false,
//         builder: (BuildContext context) {
//           return CustomBottomSheet();
//           //   height: 200,
//           //   color: Colors.white,
//           //   child: Column(
//           //    mainAxisAlignment: MainAxisAlignment.center,
//           // children: [
//           //   ElevatedButton(
//           //     onPressed: () {
//           //       Navigator.pop(context); // Close the menu
//           //     },
//           //     child: Text('Cancel'),
//           //   ),
//           //   SizedBox(height: 20),
//           //   // Add other menu items here
//           // ],
//           //   ),
//           // );
//         },
//       );
//     },
//   ),
//   MenuItem(
//     title: 'Screen 2',
//     onSelected: (BuildContext context) {
//       _openBasicForm(context);
//     },
//   ),
// ];

// class _BasicFormBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.only(right: 15, top: 0),
//             alignment: Alignment.topRight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16.0), // Add padding to the text
//                   child: Text('Originator Setup 14'),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.minimize),
//                       onPressed: () {
//                         // Minimize functionality
//                         print('Minimize button clicked');
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.fullscreen),
//                       onPressed: () {
//                         // Full screen functionality
//                         print('Full screen button clicked');
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.pop(context); // Close the bottom sheet
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 16),
//         // Column(
//         //   crossAxisAlignment: CrossAxisAlignment.stretch,
//         //   children: [
//         //     Expanded(
//         //       child: SingleChildScrollView(
//         //         child: Container(
//         //        //   padding: EdgeInsets.fromLTRB(16.0, 30.0, 100.0, 16.0),
//         //           child: Column(
//         //             children: [
//         //               Container(
//         //                 decoration: BoxDecoration(
//         //                   border: Border.all(color: Colors.black),
//         //                 ),
//         //                 // child: Column(
//         //                 //   crossAxisAlignment: CrossAxisAlignment.stretch,
//         //                 //   children: [
//         //                 //     TextField(
//         //                 //       decoration: InputDecoration(
//         //                 //         hintText: 'Sear,mlmkch',
//         //                 //         border: InputBorder.none,
//         //                 //         contentPadding: EdgeInsets.all(10),
//         //                 //       ),
//         //                 //     ),
//         //                 //   ],
//         //                 // ),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   }
// }

// class BasicFormBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.only(right: 15, top: 0),
//             alignment: Alignment.topRight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16.0), // Add padding to the text
//                   child: Text('Originator Setup 14'),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.minimize),
//                       onPressed: () {
//                         // Minimize functionality
//                         print('Minimize button clicked');
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.fullscreen),
//                       onPressed: () {
//                         // Full screen functionality
//                         print('Full screen button clicked');
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.pop(context); // Close the bottom sheet
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 10, // Adjust top position as needed
//           left: 0,
//           right: 0,
//           child: SizedBox(height: 16), // Add SizedBox below the header
//         ),
//         Positioned(
//           top: 50, // Adjust top position as needed
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 flex: 1, // Make the first partition smaller
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Center(
//                     child: Text('Small Partition'),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 3, // Make the second partition larger
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: Center(
//                     child: Text('Large Partition'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
// void _handleHelpMenuItemSelected(BuildContext context, int index) {
//     _helpMenuItems[index].onSelected(context);
//   }

// void _openBasicForm(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isDismissible: false,
//     builder: (BuildContext context) {
//       return Center( // Wrap the bottom sheet content with Center
//         child: BasicFormBottomSheet(),
//       );
//     },
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   void _openMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false, // Make it non-dismissible when tapping outside
//       builder: (BuildContext context) {
//         return CustomBottomSheet();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Navigation Demo',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => MainPage(openMenu: _openMenu),
//         '/add_product': (context) => AddNewProductPage(),
//         '/view_products': (context) => ViewProductsPage(),
//       },
//     );
//   }
// }