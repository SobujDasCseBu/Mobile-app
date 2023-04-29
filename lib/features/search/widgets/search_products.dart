import 'package:first_project/common/widgets/stars.dart';
import 'package:first_project/models/product.dart';
import 'package:flutter/material.dart';

class SearchProducts extends StatelessWidget {
  final Product product;
  const SearchProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
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
                child: Stars(
                  rating: avgRating,
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
    );
  }
}
