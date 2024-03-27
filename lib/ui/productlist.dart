import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/models/api.services.dart';
import 'package:flutter_application_1/ui/edit_product_page.dart';
import 'package:flutter_application_1/ui/producdetailsPage.dart';

class ProductList extends StatefulWidget {
const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}
class _ProductListState extends State<ProductList> {
   APIServices apiServices = APIServices(); 
 late List<Product> products=[];
  @override
  void initState() {
    super.initState();
    getProduct();
  }
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  getProduct(); 
}
   Future<List<Product>> getProduct() async{
    products = await apiServices.fetchproducts(); 
    return products;
  }
  @override
 Widget build(BuildContext context) {
  return FutureBuilder(
    future: getProduct(), 
    builder: (context, snapshot) {
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      'Product Name: ${products[index].productName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Cost: ${products[index].productCost.toString()} Rs',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 4),
                              Text('Edit'),
                            ],
                          ),
                          onPressed: () {
                            editProduct(products[index]);
                          },
                        ),
                        IconButton(
                          icon: Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 4), 
                              Text('Delete'),
                            ],
                          ),
                          onPressed: () {
                            deleteProduct(products[index]);
                          },
                        ),
                         IconButton(
                          icon: Row(
                            children: [
                              Icon(Icons.details),
                              SizedBox(width: 4), 
                              Text('details'),
                            ],
                          ),
                          onPressed: () {
                            detailsProduct(products[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              
            );
          },
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

void editProduct(Product product) async{
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditProductPage(product: product)),
  );
  if (result != null && result) {
 getProduct();
  }
 setState(() {
       getProduct();
      });
}
void detailsProduct(Product product) async{
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
  );
  if (result != null && result) {
 getProduct();
  }
 setState(() {
       getProduct();
      });
}

void deleteProduct(Product product) async {
  bool confirmed = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete this product?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete'),
        ),
      ],
    ),
  );

  if (confirmed) {

    bool success = await apiServices.deleteProd(product.productId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product deleted successfully'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));

      setState(() {
        products.remove(product);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete product'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }
}
}

