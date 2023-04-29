import 'dart:convert';

import 'package:first_project/constants/error_handling.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/constants/utils.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    //admin/get-products
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
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
}
