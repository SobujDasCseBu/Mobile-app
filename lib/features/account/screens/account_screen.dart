import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/features/account/widgets/below_app_bar.dart';
import 'package:first_project/features/account/widgets/order.dart';
import 'package:first_project/features/account/widgets/top_button.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Found it – Networks'),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Row(children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search)
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButton(),
          SizedBox(
            height: 10,
          ),
          Order(),
        ],
      ),
    );
  }
}
