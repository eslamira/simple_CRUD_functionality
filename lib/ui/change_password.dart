import 'dart:async';
import 'dart:convert';

import 'package:elrizk_task/models/user_model.dart';
import 'package:elrizk_task/ui/auth/login_screen.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class ChangePassword extends StatefulWidget {
  final FirebaseUser user;

  ChangePassword(this.user);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _passKey = GlobalKey<FormFieldState>();

  final TextEditingController _oldPass = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  String _error;

  _changePass(BuildContext context) async {
    _error = null;
    if (_formKey.currentState.validate()) {
      try {
        TinyLoadingPopUp().tinyLoading(context);
        if (await ApiProvider.internal()
                .loginWithEmailAndPass(widget.user.email, _oldPass.text) !=
            null) {
          await ApiProvider.internal()
              .updateUserPass(widget.user.token, _pass.text);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (route) => false);
        } else {
          _error = 'Wrong Password';
          if (mounted) setState(() {});
          Navigator.of(context).pop();
        }
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
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop()),
                        Padding(padding: EdgeInsets.only(left: 24.0)),
                        Text(
                          'Change Password',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: 28),
                        ),
                      ],
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
                            Icons.security,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: _oldPass,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Current Password',
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
                            Icons.security,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            key: _passKey,
                            controller: _pass,
                            validator: TinyValidators.internal().passValidator,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'New Password',
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
                            Icons.security,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            validator: (v) => v == _passKey.currentState.value
                                ? null
                                : "Password doesn't match",
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Verify New Password',
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
                  onTap: () async => await _changePass(context),
                  text: 'Change Password',
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
