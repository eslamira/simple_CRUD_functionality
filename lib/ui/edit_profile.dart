import 'dart:async';
import 'dart:convert';

import 'package:elrizk_task/models/user_model.dart';
import 'package:elrizk_task/ui/auth/login_screen.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class EditProfile extends StatefulWidget {
  final FirebaseUser user;
  final UserModel userModel;

  EditProfile(this.user, this.userModel);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _error;

  _editProf(BuildContext context) async {
    _error = null;
    if (_formKey.currentState.validate()) {
      try {
        TinyLoadingPopUp().tinyLoading(context);
        _formKey.currentState.save();
        await ApiProvider.internal()
            .updateUserEmail(widget.user.token, widget.user.email);
        await ApiProvider.internal()
            .updateUserData(widget.user, widget.userModel.toJson());
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } catch (e) {
        Map m = json.decode(e.toString());
        if (m['error']['message'] == 'TOKEN_EXPIRED') {
          _error = 'Session expired log in again';
          Timer(
              Duration(seconds: 3),
              () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  (route) => false));
        } else
          _error = '${m['error']['message']}';
        if (mounted) setState(() {});
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 36.0, bottom: 24.0, left: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop()),
                          Text(
                            'Edit Profile',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.0,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(fontSize: 28),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Text(
                              widget.userModel.userType == UserType.Company
                                  ? 'Company'
                                  : 'Client',
                              textScaleFactor: 1.0,
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepPurple,
                          blurRadius: 1.0,
                          spreadRadius: 1.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            initialValue: widget.userModel.name,
                            onSaved: (v) => widget.userModel.name = v,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.deepPurpleAccent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepPurple,
                          blurRadius: 1.0,
                          spreadRadius: 1.5)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            initialValue: widget.user.email,
                            onSaved: (v) => widget.user.email = v,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: Colors.deepPurpleAccent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.userModel.userType == UserType.User) ...[
                  SizedBox(height: 24.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 1.0,
                            spreadRadius: 1.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              initialValue: widget.userModel.phoneNum,
                              onSaved: (v) => widget.userModel.phoneNum = v,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.deepPurpleAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (widget.userModel.userType == UserType.Company) ...[
                  SizedBox(height: 24.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 1.0,
                            spreadRadius: 1.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              initialValue: widget.userModel.logoURL,
                              onSaved: (v) => widget.userModel.logoURL = v,
                              decoration: InputDecoration(
                                labelText: 'Logo URL',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.deepPurpleAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 1.0,
                            spreadRadius: 1.5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              initialValue: widget.userModel.locationURL,
                              onSaved: (v) => widget.userModel.locationURL = v,
                              decoration: InputDecoration(
                                labelText: 'Location URL',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.deepPurpleAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (_error != null) ...[
                  SizedBox(height: 32.0),
                  Text(
                    '$_error',
                    style: Theme.of(context)
                        .inputDecorationTheme
                        .errorStyle
                        .copyWith(fontSize: 18.0),
                    textScaleFactor: 1.0,
                  ),
                ],
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TinyContainer(
                  maxWidth: MediaQuery.of(context).size.width * 0.35,
                  onTap: () async => await _editProf(context),
                  text: 'Update Profile',
                  backgroundColor: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          )),
    );
  }
}
