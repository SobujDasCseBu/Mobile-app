import 'dart:convert';

import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/constants/utils.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/models/user.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //inspect('Hi form admin service 2');

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'x-auth-token': userProvider.user.token,
        },
        //inspect('Hi form admin service 2');
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModer(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Rate the products

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      //inspect('Hi form admin service 2');

      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json',
          'Charset': 'utf-8',
          'x-auth-token': userProvider.user.token,
        },
        //inspect('Hi form admin service 2');
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
