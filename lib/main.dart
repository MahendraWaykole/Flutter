import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
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

void editButtonClicked(String id, String name) async {
  final apiService = APIServices();
  if (id == '-1') {
    print('Add new button clicked');
    String productName = name;
    double productCost = 100;
    String productDesc = name;
    if (productName.isNotEmpty && productCost > 0) {
      Product newProduct = Product(
          productDesc: productDesc,
          productName: productName,
          productCost: productCost,
          isActive: true);
      bool success = await apiService.addProduct(newProduct);
      if (success) {
        print('Product added successfully');
      } else {
        print('Failed to add product');
      }
    } else {
      print('Please enter valid product details');
    }
  } else {
    print('Edit button clicked');

    int productID = int.tryParse(id) ?? 0;
    String productName = name;
    double productCost = double.tryParse(id) ?? 0.0;
    String productDesc = name;
    if (productID > 0 && productName.isNotEmpty && productCost > 0) {
      Product newProduct = Product(
          productId: productID,
          productName: productName,
          productCost: productCost,
          productDesc: productDesc,
          isActive: true);
      bool success = await apiService.editProduct(newProduct, productID);
      if (success) {
        print('Product updated successfully');
      } else {
        print('Failed to update product');
      }
    } else {
      print('Please enter valid product details');
    }
  }
}

class FormOverlay extends StatefulWidget {
  @override
  _FormOverlayState createState() => _FormOverlayState();
}

class _FormOverlayState extends State<FormOverlay> {
  List<Product> tableData = [];
  bool showAlphabets = false;
  int selectedNumber = -1;
  bool isEditableName = false;
  bool isEditableID = false;
  bool showNumbers = true;
  String dropdownValue = 'All';
  String? selectedAlphabet;
  int selectedProductId = -1;
  String? selectedProductName;
  bool areButtonsVisible = true;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerID = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch data for 'All' option when the widget initializes
    _fetchTableData(dropdownValue);
  }

  Widget _buildProductNamesContainer(
      List<Product> products, int selectedNumber, String? alphabates) {
    List<String> productNames = [];
    if (selectedNumber != -1) {
      List<Product> filteredProducts = products
          .where((product) =>
              product.productName.contains(selectedNumber.toString()))
          .toList();
      productNames =
          filteredProducts.map((product) => product.productName).toList();
      print('slectednumber:$productNames');
    } else if (alphabates != null) {
      List<Product> filteredProducts = filterProductsByAlphabet(alphabates);
      productNames =
          filteredProducts.map((product) => product.productName).toList();
      print(filteredProducts);
    } else {
      productNames = tableData.map((entry) => entry.productName).toList();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set background color to white
        border: Border.all(
          color: Colors.black, // Set border color to black
          width: 1.0, // Set border width
        ),
      ),
      constraints: BoxConstraints(
          maxHeight: 435), // Example: Set a maximum height for the container
      child: ListView.builder(
        itemCount: productNames.length,
        itemBuilder: (BuildContext context, int index) {
          String productName = productNames[index];
          // Product product = filteredProducts[index];
          Product product = products.firstWhere(
            (product) => product.productName == productName,
            orElse: () => Product(
              productId: -1,
              productName: '', // Provide a default empty string for productName
              productCost: 0, // Provide a default value for productCost
              productDesc: '', // Provide a default empty string for productDesc
              isActive: false,
            ), // Default product if not found
          );
          return InkWell(
            onTap: () {
              print(
                  'Index out of bounds or products not synced with productNamessss.');
              if (index >= 0 &&
                  index < products.length &&
                  index < productNames.length) {
                print(products.length);
                print(index);
                print(productNames.length);
                setState(() {
                  selectedProductName = null;
                  selectedProductId = -1;
                  selectedProductId = product.productId;
                  _controllerID.text = selectedProductId.toString();

                  selectedProductName = productName;
                  print(selectedProductName);
                  print('id:$selectedProductId');
                  _controllerName.text = selectedProductName ?? '';
                  print(_controllerName.text);
                });
              } else {
                print(
                    'Index out of bounds or products not synced with productNames.');
              }
            },
            child: Container(
              color: selectedProductName == productName ? Colors.blue : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  productName,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5.0),
      color: Colors.lightBlue.shade50,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 1.0), // Add padding to the text
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
          SizedBox(height: 5.0), // Add space below the top bar
          // Small and Large Partitions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 500.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlue.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top part with Name and ID fields
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status:',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width:
                                    80, // Adjust the width of the dropdown button
                                height:
                                    25, // Adjust the height of the dropdown button
                                child: DropdownButtonFormField<String>(
                                  value: dropdownValue,
                                  iconSize: 20,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue ?? 'All';
                                      print(dropdownValue);
                                      print(newValue);

                                      _fetchTableData(
                                          dropdownValue); // Call fetchData() when "Option 1" is selected
                                    });
                                  },
                                  // itemHeight: 20,
                                  items: <String>['All', 'Active', 'InActive']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width:
                                              40, // Adjust the width of the dropdown options
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontSize:
                                                    9), // Adjust the font size
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  decoration: InputDecoration(
                                    hintText: 'Select an option',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width:
                                              1.0), // Customize focused border color and width
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                        // Divider
                        Divider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                        // Remaining parts split into two vertically
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onLongPress: () {
                                      showRightClickMenu(context);
                                      print("right click");
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  showAlphabets = true;
                                                  showNumbers = false;
                                                });
                                                print('A-Z button clicked');
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.5,
                                                  vertical: 0.5,
                                                ),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                ),
                                              ).copyWith(
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              child: Text('A-Z'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  showAlphabets = false;
                                                  showNumbers = true;
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.5,
                                                  vertical: 0.5,
                                                ),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                ),
                                              ).copyWith(
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                  TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              child: Text('123'),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Text('Show Numbers: $showNumbers'),
                                            // Text('Show Alphabets: $showAlphabets'),
                                          ],
                                        ),
                                        Visibility(
                                          visible: showAlphabets,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: _buildAlphabetButtons(),
                                          ),
                                        ),
                                        Visibility(
                                          visible: showNumbers,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: _buildNumberButtons(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: _buildProductNamesContainer(
                                        tableData,
                                        selectedNumber,
                                        selectedAlphabet),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                  width: 10.0), // Add space between small and large partitions
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 500.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlue.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0), // Adjust horizontal padding
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: areButtonsVisible,
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          areButtonsVisible = false;
                                          _controllerID.text = '-1';
                                          isEditableName = true;
                                          isEditableID = false;
                                          _controllerName.text = '';
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Add'),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditableName = true;
                                          isEditableID = true;
                                          areButtonsVisible = false;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Edit'),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    !areButtonsVisible, // Show Ok/Cancel buttons
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        editButtonClicked(_controllerID.text,
                                            _controllerName.text);
                                        print('object1$_controllerID');
                                        setState(() {
                                          areButtonsVisible = true;
                                          isEditableID = false;
                                          isEditableName = false;
                                          // _fetchTableData(dropdownValue);
                                          // _buildProductNamesContainer(tableData,
                                          //     selectedNumber, selectedAlphabet);
                                          _controllerID.text = '';
                                          _controllerName.text = '';
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Save'),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        // Cancel button functionality
                                        setState(() {
                                          areButtonsVisible = true;
                                          isEditableID = false;
                                          isEditableName = false;
                                          _controllerID.text = '';
                                          _controllerName.text = '';
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Cancel'),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(), // Add space between Add/Edit and Duplicate/History/Export
                              Visibility(
                                visible: areButtonsVisible,
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Button 1 functionality
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Duplicate'),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        // Button 1 functionality
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('History'),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        // Button 1 functionality
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.0,
                                          vertical: 2.0,
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.0),
                                        ),
                                      ).copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Text('Export'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.lightBlue.shade100,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: 16.0),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(
                                            'ID:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              height: 25.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: Stack(
                                                children: [
                                                  TextFormField(
                                                    enabled: isEditableID,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    controller: _controllerID,
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter ID',
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0,
                                                              vertical: 12.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Name:',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Container(
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    TextFormField(
                                                      enabled: isEditableName,
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                      controller:
                                                          _controllerName,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Enter Name',
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical:
                                                                        12.0),
                                                      ),
                                                      onChanged: (value) {
                                                        // Log the value whenever it changes
                                                        print(
                                                            "Value changed: $value");
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _fetchTableData(String status) async {
    final apiService = APIServices();
    final fetchedData = await apiService.fetchtableName(status);
    print('Fetched data Drop: $fetchedData');
    setState(() {
      tableData = fetchedData;
    });
    print('Table data Drop: $tableData');
  }

  void onNumberButtonPressed(int number) {
    setState(() {
      selectedNumber = number;
      selectedAlphabet = null;
    });
  }

  void onalphaButtonPressed(String value) {
    setState(() {
      selectedAlphabet = value;
      selectedNumber = -1;
    });
  }

  List<String> filterProductNames(List<Product> products, int selectedNumber) {
    List<String> filteredNames = products
        .where((product) =>
            product.productName.contains(selectedNumber.toString()))
        .map((product) => product.productName)
        .toList();
    if (filteredNames.isEmpty) {
      return ['No data found'];
    }
    return filteredNames;
  }

  List<Product> filterProductsByAlphabet(String alphabet) {
    return tableData
        .where((product) => product.productName.startsWith(alphabet))
        .toList();
  }

  List<Widget> _buildNumberButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i <= 9; i++) {
      buttons.add(
        Column(
          children: [
            SizedBox(height: 2),
            ElevatedButton(
              onPressed: () {
                onNumberButtonPressed(i);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.5,
                  vertical: 0.5,
                ),
                backgroundColor: selectedNumber == i
                    ? Colors.lightBlueAccent.shade200
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ).copyWith(
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.black),
                ),
              ),
              child: Text('$i'),
            ),
            SizedBox(height: 5), // Add space between rows
          ],
        ),
      );
      //return buttons;
    }

    print('1234 button clicked');
    return [
      Padding(
        padding: EdgeInsets.only(top: 8.0, left: 15, right: 15),
        child: Column(
          children: buttons,
        ),
      ),
    ];
  }

  List<Widget> _buildAlphabetButtons() {
    print('abcd button clicked');
    List<Widget> buttons = [];

    // Function to generate buttons for a specific range of characters
    Widget generateButton(int start, int end) {
      List<Widget> buttonRow = [];
      for (int i = start; i <= end; i++) {
        String alphabet = String.fromCharCode('A'.codeUnitAt(0) + i);
        buttonRow.add(
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onalphaButtonPressed(alphabet);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 5,
                ),
                minimumSize: Size(32, 32),
                backgroundColor: selectedAlphabet == alphabet
                    ? Colors.lightBlueAccent.shade200
                    : Colors.white,
                // backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
              ).copyWith(
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.black),
                ),
              ),
              child: Text(String.fromCharCode('A'.codeUnitAt(0) + i)),
            ),
          ),
        );
      }
      return Row(children: buttonRow);
    }

    // Generating buttons for 'A' to 'Q'
    for (int i = 0; i < 11; i++) {
      String alphabet = String.fromCharCode('A'.codeUnitAt(0) + i * 2);
      buttons.add(
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 10, right: 10), // Add space between rows
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Add space between buttons
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    onalphaButtonPressed(
                        String.fromCharCode('A'.codeUnitAt(0) + i * 2));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 5,
                    ),
                    minimumSize: Size(32, 32),
                    backgroundColor: selectedAlphabet == alphabet
                        ? Colors.lightBlueAccent.shade200
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                  ).copyWith(
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.black),
                    ),
                  ),
                  child: Text(String.fromCharCode('A'.codeUnitAt(0) + i * 2)),
                ),
              ),
              SizedBox(width: 10), // Add some spacing between buttons
              Expanded(
                //  String alphabet = String.fromCharCode('A'.codeUnitAt(0) + i *2);
                child: i * 2 + 1 < 26
                    ? ElevatedButton(
                        onPressed: () {
                          onalphaButtonPressed(String.fromCharCode(
                              'A'.codeUnitAt(0) + i * 2 + 1));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 5,
                          ),
                          minimumSize: Size(32, 32),
                          backgroundColor: selectedAlphabet ==
                                  String.fromCharCode(
                                      'A'.codeUnitAt(0) + i * 2 + 1)
                              ? Colors.lightBlueAccent.shade200
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                        ).copyWith(
                          textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.black),
                          ),
                        ),
                        child: Text(
                            String.fromCharCode('A'.codeUnitAt(0) + i * 2 + 1)),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      );
    }

    buttons.add(
      Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 10, right: 10), // Add space between rows
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Add space between buttons

          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  onalphaButtonPressed('WXYZ');
                  // Do something when alphabet button is pressed
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 5,
                  ),
                  minimumSize: Size(32, 32),
                  backgroundColor: selectedAlphabet == 'WXYZ'
                      ? Colors.lightBlueAccent.shade200
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                ).copyWith(
                  textStyle: MaterialStateProperty.all(
                    TextStyle(color: Colors.black),
                  ),
                ),
                child: Text('WXYZ'), // Make characters uppercase
              ),
            ),
          ],
        ),
      ),
    );

    return buttons;
  }
}

void showRightClickMenu(BuildContext context) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu(
    context: context,
    position: RelativeRect.fromRect(
      Offset.zero & overlay.size,
      Offset.zero & overlay.size,
    ),
    items: [
      PopupMenuItem(
        child: GestureDetector(
          onTap: () {
            // Implement clear filter functionality here
            Navigator.pop(context);
          },
          child: Text('Clear Filter'),
        ),
      ),
    ],
  );
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
  print('Help menu item selected with index: $index');
  if (index == 0) {
    print('Opening FAQ form overlay');
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              // width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: FormOverlay(),
              ),
            );
          },
        );
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
