import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/invoicepage.dart';
import 'package:flutter_application_1/models/products.dart';

class reportPage extends StatefulWidget {
  final List<Product> data;
  const reportPage({Key? key, required this.data}) : super(key: key);
  @override
  State<reportPage> createState() => _reportPageState();
}

class _reportPageState extends State<reportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.00),
            child: Column(
              children: [
                Text("Product Details Report",
                    style: TextStyle(
                        fontSize: 25.00, fontWeight: FontWeight.bold)
                        ),
                SizedBox(height: 10.00),
                Divider(),
                Align(
                  alignment: Alignment.topRight,
                  // child: ImageBuilder(
                  //   imagePath: "assets/Images/image.png",
                  //   imgWidth: 250,
                  //   imgheight: 250,
                  // ),
                ),
                InvoiceBuilder(data: widget.data),
                SizedBox(height: 15.00),
                Text(
                  "Thanks for choosing our service!",
                  style: TextStyle(color: Colors.grey, fontSize: 15.00),
                ),
                SizedBox(height: 5.00),
                Text(
                  "Contact the branch for any clarifications.",
                  style: TextStyle(color: Colors.grey, fontSize: 15.00),
                ),
                SizedBox(height: 15.00),
                // SaveBtnBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
