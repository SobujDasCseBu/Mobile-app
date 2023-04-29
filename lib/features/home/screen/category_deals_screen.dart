import 'package:first_project/common/widgets/loader.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/features/product_details/screen/product_details_screen.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

import '../services/home_services.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = 'category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final HomeServices homeServices = HomeServices();
  List<Product>? productList;
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProduct(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shoping for ${widget.category}',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: productList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.4,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () => {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: product,
                            )
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 15, top: 5),
                                child: Text(
                                  product.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
