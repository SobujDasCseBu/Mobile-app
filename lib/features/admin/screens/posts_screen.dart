import 'package:first_project/common/widgets/loader.dart';
import 'package:first_project/features/account/widgets/single_product.dart';
import 'package:first_project/features/admin/screens/add_product_screen.dart';
import 'package:first_project/features/admin/services/admin_services.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Scaffold(
              body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: productData.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  productData.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    color: Color.fromARGB(255, 41, 194, 214),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  deleteProduct(productData, index),
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: navigateToAddProduct,
                tooltip: 'Add a product',
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
  }
}
