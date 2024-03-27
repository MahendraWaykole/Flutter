import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';

class InvoiceBuilder extends StatelessWidget {
  final List<Product> data;
  const InvoiceBuilder({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header(),
        SizedBox(height: 10.00),
        tableHeader(),
         for (var product in data) buildTableData(product),
        buildTotal(),
      ],
    );
  }

  // Widget header() => Row(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: const [
  //         Icon(
  //           Icons.file_open,
  //           color: Colors.indigo,
  //           size: 35.00,
  //         ),
  //         SizedBox(width: 5.5),
  //         Text(
  //           "Invoice",
  //           style: TextStyle(fontSize: 23.00, fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     );

  Widget tableHeader() => Container(
       // color: const Color.fromARGB(255, 189, 255, 191),
        width: double.infinity,
        height: 36.00,
        child: const Center(
          child: Text(
            "Products",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 107, 4),
                fontSize: 20.00,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget buildTableData(Product product) => Container(
        color: data.indexOf(product) % 2 != 0
            ? const Color.fromARGB(255, 236, 236, 236)
            : const Color.fromARGB(255, 255, 251, 251),
        width: double.infinity,
        height: 36.00,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.productName, 
                style: const TextStyle(
                    fontSize: 18.00, fontWeight: FontWeight.bold),
              ),
              Text(
                " ${product.productCost.toStringAsFixed(2)} Rs", 
                style: const TextStyle(
                    fontSize: 18.00, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      );

  Widget buildTotal() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          color: const Color.fromARGB(255, 255, 251, 251),
          width: double.infinity,
          height: 36.00,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              Text(
                "\$ ${calculateTotal().toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22.00,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 107, 4),
                ),
              ),
            ],
          ),
        ),
      );
       double calculateTotal() {
    double total = 0;
    for (var product in data) {
      total += product.productCost;
    }
    return total;
  }
}
