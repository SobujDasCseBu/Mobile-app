// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:first_project/common/widgets/custom_textfield.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pineCodeController = TextEditingController();
  final TextEditingController townCityController = TextEditingController();
  final _addresFromKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];
  final gpay = 'lib/assets/images/mobiles.jpeg';
  @override
  void dispose() {
    super.dispose();
    townCityController.dispose();
    pineCodeController.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
  }

  void onGooglePayResult(res) {}

  @override
  Widget build(BuildContext context) {
    //var address = context.watch<UserProvider>().user.address;
    var address = 'Barishal Sador, Barishal';
    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              Form(
                key: _addresFromKey,
                child: Column(
                  children: [
                    CutsomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CutsomTextField(
                      controller: areaController,
                      hintText: 'Area State',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CutsomTextField(
                      controller: pineCodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CutsomTextField(
                      controller: townCityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GooglePayButton(
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    'lib/assets/dgpcs.json'),
                paymentItems: _paymentItems,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
