import 'package:first_project/common/widgets/loader.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/features/home/widgets/address_box.dart';
import 'package:first_project/features/product_details/screen/product_details_screen.dart';
import 'package:first_project/features/search/services/search_services.dart';
import 'package:first_project/features/search/widgets/search_products.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQueary;
  const SearchScreen({super.key, required this.searchQueary});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchProduct(
        context: context, searchQuery: widget.searchQueary);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
            title: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 15),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            hintText: 'Search in Found it - networks',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 42,
                    color: Colors.transparent,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProductDetailsScreen.routeName,
                                        arguments: products![index]);
                                  },
                                  child: SearchProducts(
                                      product: products![index])));
                        }),
                  ),
                ],
              ));
  }
}
