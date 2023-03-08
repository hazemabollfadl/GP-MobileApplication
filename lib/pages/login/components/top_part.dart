import 'package:flutter/material.dart';
import 'package:new_food_delivery/appColors/app_colors.dart';

class TopPart extends StatelessWidget {
  const TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "images/newlogo.png",
                scale: 7,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              "login",
              style: TextStyle(
                color: AppColors.kblackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
