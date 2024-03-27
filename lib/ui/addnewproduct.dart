import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/models/api.services.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddNewProduct> {
  final APIServices apiServices = APIServices();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCostController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();

  Future<void> addnewProducts() async {
    String productName = _productNameController.text;
    double productCost = double.tryParse(_productCostController.text) ?? 0.0;
    String productDesc = _productDescController.text;
    if (productName.isNotEmpty && productCost > 0) {
      Product newProduct = Product(
          productDesc: productDesc,
          productName: productName,
          productCost: productCost,
          isActive: true);
      bool success = await apiServices.addProduct(newProduct);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product added successfully'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
        ));
        _productNameController.clear();
        _productCostController.clear();
        _productDescController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add product'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter valid product details'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Product Name:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _productNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter product name',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Product Cost:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _productCostController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter product cost',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Product Description:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _productDescController,
                    decoration: InputDecoration(
                      hintText: 'Enter product Description',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: addnewProducts,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
