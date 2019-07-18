import 'package:elrizk_task/models/user_model.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final FirebaseUser user;
  final UserModel userModel;

  EditProfile(this.user, this.userModel);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
