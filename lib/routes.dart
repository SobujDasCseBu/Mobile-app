// ignore_for_file: non_constant_identifier_names

import 'package:first_project/common/widgets/bottom_bar.dart';
import 'package:first_project/features/address/screen/address_screen.dart';
import 'package:first_project/features/admin/screens/add_product_screen.dart';
import 'package:first_project/features/auth/screens/auth_screen.dart';
import 'package:first_project/features/home/screen/category_deals_screen.dart';
import 'package:first_project/features/home/screen/home_screen.dart';
import 'package:first_project/features/product_details/screen/product_details_screen.dart';
import 'package:first_project/features/search/screen/search_screen.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

// ignore: avoid_types_as_parameter_names
Route<dynamic> generateRoute(RouteSettings, routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BackButton());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQueary = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQueary: searchQueary,
              ));
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddressScreen());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(child: Text('Screen does not exist ')),
              ));
  }
}
