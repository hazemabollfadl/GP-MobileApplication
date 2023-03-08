import 'package:flutter/material.dart';
import 'package:new_food_delivery/appColors/app_colors.dart';
import 'package:new_food_delivery/pages/login/login_page.dart';
import 'package:new_food_delivery/pages/signup/signup_page.dart';
import 'package:new_food_delivery/widgets/my_button.dart';

import '../../../route/routing_page.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: LoginPage(),
            );
          },
          text: "LOG IN",
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: SignupPage(),
            );
          },
          child: Text(
            "SIGNUP",
            style: TextStyle(
              color: AppColors.kgreyColor,
            ),
          ),
        )
      ],
    );
  }
}
