import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/models/api.services.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final APIServices apiServices = APIServices();
   final TextEditingController _productidController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCostController = TextEditingController();
 final TextEditingController _productDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productidController.text=widget.product.productId.toString();
    _productNameController.text = widget.product.productName;
    _productCostController.text = widget.product.productCost.toString();
    _productDescController.text=widget.product.productDesc;
  }

  Future<void> updateProducts() async {
    int productID=int.tryParse(_productidController.text)?? 0;
    String productName = _productNameController.text;
    double productCost = double.tryParse(_productCostController.text) ?? 0.0;
    String productDesc =_productDescController.text;

    if (productID>0 && productName.isNotEmpty && productCost > 0) {
      Product newProduct = Product(productId: productID, productName: productName, productCost: productCost,
      productDesc: productDesc,isActive: true);
      bool success = await apiServices.editProduct(newProduct,productID);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product updated successfully'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
        ));
       setState(() {
       _productNameController.clear();
        _productCostController.clear();
        _productDescController.clear();
      });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update product'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            TextField(
              controller: _productCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Product Cost',
              ),
            ),
             TextField(
              controller: _productDescController,
              decoration: InputDecoration(
                labelText: 'Product Description',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateProducts,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
