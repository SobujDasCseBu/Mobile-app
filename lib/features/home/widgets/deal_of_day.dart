import 'package:first_project/common/widgets/loader.dart';
import 'package:first_project/features/home/services/home_services.dart';
import 'package:first_project/features/product_details/screen/product_details_screen.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailsPage() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsPage,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 5),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$${product!.price}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          left: 15, top: 5, right: 40, bottom: 5),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      child: const Text(
                        'See all deals',
                        style: TextStyle(color: Colors.teal),
                      ),
                    )
                  ],
                ),
              );
  }
}
