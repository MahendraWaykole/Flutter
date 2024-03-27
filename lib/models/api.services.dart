import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_application_1/models/products.dart';

class APIServices {
  final String baseurl = "https://localhost:7041/api/products";
  final logger = Logger();

  Future<List<Product>> fetchproducts() async {
    List<Product> products = [];
    final uri = Uri.parse('$baseurl/GetAllProducts');
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
      );
      logger.i('API Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        // if(response.statusCode>=200 && response.statusCode<=299){
        final List<dynamic> jsondata = json.decode(response.body.toString());
        products = jsondata.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return products;
    }
    return products;
  }

  Future<List<Product>> fetchtable() async {
    List<Product> tableData = [];
    final uri = Uri.parse('$baseurl/GetAllProducts');
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
      );
      logger.i('API Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        // if(response.statusCode>=200 && response.statusCode<=299){
        final List<dynamic> jsondata = json.decode(response.body.toString());
        tableData = jsondata.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return tableData;
    }
    return tableData;
  }

 Future<List<Product>> fetchtableName(String status) async {
    List<Product> tableData = [];
    final uri = Uri.parse('$baseurl/GetAllProductsName?status=$status');
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
      );
      logger.i('API Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        // if(response.statusCode>=200 && response.statusCode<=299){
        final List<dynamic> jsondata = json.decode(response.body.toString());
        tableData = jsondata.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return tableData;
    }
    return tableData;
  }

  Future<bool> addProduct(Product product) async {
    final uri = Uri.parse('$baseurl/create-product');
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(product.toJson()),
      );
      logger.i('API Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      } else {
        logger.e('Failed to add product: ${response.body}');
        return false;
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return false;
    }
  }

  Future<bool> deleteProd(int productId) async {
    final uri = Uri.parse('$baseurl/delete-product?productID=$productId');

    try {
      final response = await http.delete(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
      );
      logger.i('API Status Code: ${response.statusCode}');
      logger.i('API Status Code: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        logger.e('Failed to delete product: ${response.body}');
        return false;
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return false;
    }
  }

  Future<bool> editProduct(Product product, int productId) async {
    final uri = Uri.parse('$baseurl/update-product/$productId');
    try {
      final response = await http.put(
        uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(product.toJson()),
      );
      logger.i(
          'API Status Code: ${response.statusCode},product: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        logger.e('Failed to edit product: ${response.body}');
        return false;
      }
    } catch (e) {
      logger.e('Error in API call: $e');
      return false;
    }
  }
}
