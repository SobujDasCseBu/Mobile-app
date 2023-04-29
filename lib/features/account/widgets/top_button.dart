import 'package:first_project/features/account/services/account_services.dart';
import 'package:first_project/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: 'Your orders',
            ),
            AccountButton(
              onTap: () {},
              text: 'Turn Seller',
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              onTap: () => AccountServices().logOut(context),
              text: 'Log out',
            ),
            AccountButton(
              onTap: () {},
              text: 'Your wish list',
            ),
          ],
        )
      ],
    );
  }
}
