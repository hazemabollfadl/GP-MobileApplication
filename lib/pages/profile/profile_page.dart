import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_food_delivery/appColors/app_colors.dart';
import 'package:new_food_delivery/pages/home/home_page.dart';
import 'package:new_food_delivery/route/routing_page.dart';
import 'package:new_food_delivery/widgets/my_button.dart';

class ProfilePage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(ProfilePage.pattern.toString());

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;

  TextEditingController fullName =
      TextEditingController(text: userModel.fullName);
  TextEditingController emailAddress =
      TextEditingController(text: userModel.emailAddress);
  TextEditingController userLocation =
      TextEditingController(text: userModel.userLocation);
  TextEditingController phoneNum =
      TextEditingController(text: userModel.phoneNum);

  Widget textFromField({required String hintText}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
    );
  }

  void profilevalidation({
    required TextEditingController? emailAdress,
    required TextEditingController? fullName,
    required TextEditingController? userLocation,
    required TextEditingController? phoneNum,
    required BuildContext context,
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Full name is empty"),
        ),
      );
      return;
    } else if (emailAdress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email address is empty"),
        ),
      );
      return;
    } else if (!widget.regExp.hasMatch(emailAdress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid email address"),
        ),
      );
    } else if (userLocation!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User Location is empty"),
        ),
      );
    } else if (phoneNum!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone Number is empty"),
        ),
      );
      return;
    } else {
      buildUpdateProfile();
    }
  }

  Widget nonEditTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/non_profile.jpg"),
              radius: 50,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.fullName),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.emailAddress),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.userLocation),
        SizedBox(
          height: 10,
        ),
        textFromField(hintText: userModel.phoneNum),
      ],
    );
  }

  Widget editTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/non_profile.jpg"),
              radius: 50,
            ),
          ],
        ),
        TextFormField(
          controller: fullName,
          decoration: InputDecoration(
            hintText: "fullName",
          ),
        ),
        TextFormField(
          controller: emailAddress,
          decoration: InputDecoration(
            hintText: "emailAddres",
          ),
        ),
        TextFormField(
          controller: userLocation,
          decoration: InputDecoration(
            hintText: "userLocation",
          ),
        ),
        TextFormField(
          controller: phoneNum,
          decoration: InputDecoration(
            hintText: "phoneNum",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyButton(
          onPressed: () {
            profilevalidation(
              context: context,
              emailAdress: emailAddress,
              fullName: fullName,
              userLocation: userLocation,
              phoneNum: phoneNum,
            );
          },
          text: "Up date",
        )
      ],
    );
  }

  Future buildUpdateProfile() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "fullname": fullName.text,
        "emailAdress": emailAddress.text,
        "userLocation": userLocation.text,
        "phoneNum": phoneNum.text,
      },
    ).then(
      (value) => RoutingPage.goTonext(
        context: context,
        navigateTo: HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kgradientk1,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(Icons.close),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: isEdit ? editTextField() : nonEditTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
