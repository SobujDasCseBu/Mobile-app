import 'package:first_project/features/cart/services/cart_services.dart';
//import 'package:first_project/features/product_details/screen/product_details_screen.dart';
import 'package:first_project/features/product_details/services/product_details_services.dart';
import 'package:first_project/models/product.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productcart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productcart['product']);
    final quantity = productcart['quantity'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$ ${product.price}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: const Text(
                      'Eligible for free shiping',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(216, 0, 0, 0),
                      ),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In stock',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreseQuantity(product),
                        child: Container(
                          height: 32,
                          width: 35,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                            height: 32,
                            width: 35,
                            alignment: Alignment.center,
                            child: Text(
                              quantity.toString(),
                            )),
                      ),
                      InkWell(
                        onTap: () => increseQuantity(product),
                        child: Container(
                          height: 32,
                          width: 35,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
