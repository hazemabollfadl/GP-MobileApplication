import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String emailAddress;
  final String password;
  final String userUid;
  final String userLocation;
  final String phoneNum;
  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.userUid,
    required this.userLocation,
    required this.phoneNum,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      fullName: doc['fullname'],
      emailAddress: doc['emailAdress'],
      password: doc['password'],
      userUid: doc['userUid'],
      userLocation: doc['userLocation'],
      phoneNum: doc['phoneNum'],
    );
  }
}
