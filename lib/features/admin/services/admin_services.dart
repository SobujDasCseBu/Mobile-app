import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:first_project/constants/error_handling.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/constants/utils.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //inspect('Hi form admin service');
      final cloudinary = CloudinaryPublic('dzpzs1gdp', 'ok5j2qut');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      //inspect('Hi form admin service 2');
      Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imageUrls);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'x-auth-token': userProvider.user.token,
        },
        //inspect('Hi form admin service 2');
        body: product.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//fetch all products

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    //admin/get-products
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      inspect("Response data : ${res.body}");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      inspect('Hi form admin service  fetch data ${e.toString()} ');
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // delete product

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
