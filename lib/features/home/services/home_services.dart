import 'dart:convert';
import 'dart:developer';

import 'package:first_project/models/product.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProduct(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    //admin/get-products
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      //inspect("Response data : ${res.body}");
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
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      category: '',
      quantity: 0,
      images: [],
    );
    //admin/get-products
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'x-auth-token': userProvider.user.token,
      });

      //inspect("Response data : ${res.body}");
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // inspect('Product : vfd');
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    //inspect('Product : $product');
    return product;
  }
}
