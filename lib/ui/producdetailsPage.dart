import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart'; // Import your product model

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name: ${product.productName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Product Cost: ${product.productCost} Rs',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            Text('Description: ${product.productDesc}',
                style: TextStyle(fontSize: 12)),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
