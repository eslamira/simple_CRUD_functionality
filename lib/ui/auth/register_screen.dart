import 'dart:convert';

import 'package:elrizk_task/models/user_model.dart';
import 'package:elrizk_task/ui/home_screen.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passKey = GlobalKey<FormFieldState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _logo = TextEditingController();
  final TextEditingController _location = TextEditingController();
  FirebaseUser _user;
  String _error = '';
  int _radioValue = 2;
  UserType _userType;

  _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _userType = UserType.Company;
          break;
        case 1:
          _userType = UserType.User;
          break;
      }
    });
  }

  _reg() async {
    if (_formKey.currentState.validate()) {
      try {
        TinyLoadingPopUp().tinyLoading(context);
        _user = await ApiProvider.internal()
            .registerWithEmailAndPass(_email.text, _pass.text);
        if (_user != null) {
          _userType == UserType.Company
              ? await ApiProvider.internal().putUserData(
                  _user.uid,
                  json.encode({
                    "name": "${_name.text}",
                    "logo": "${_logo.text}",
                    "location": "${_location.text}",
                    "userType": "$_userType",
                  }))
              : await ApiProvider.internal().putUserData(
                  _user.uid,
                  json.encode({
                    "name": "${_name.text}",
                    "phone": "${_phone.text}",
                    "userType": "$_userType",
                  }));
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(_user)),
            (route) => false);
      } catch (e) {
        Navigator.of(context).pop();
        print(e.toString());
        if (e == 400)
          _error = 'E-mail Already Exist';
        else if (e == 401)
          _error = 'Permisson to data Denied';
        else
          _error = 'Something went Wrong please try again later';
      } finally {
        if (mounted) setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Register As',
                  textScaleFactor: 1.0,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: 0,
                      groupValue: _radioValue,
                      title: Text(
                        'Company',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: _radioValue == 0
                              ? Theme.of(context).accentColor
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: 1,
                      groupValue: _radioValue,
                      title: Text(
                        'User',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: _radioValue == 1
                              ? Theme.of(context).accentColor
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ],
              ),
              if (_userType != null) ...[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
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
                                  controller: _name,
                                  validator:
                                      TinyValidators.internal().nameValidator,
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.deepPurpleAccent))),
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
                                  controller: _email,
                                  validator:
                                      TinyValidators.internal().emailValidator,
                                  decoration: InputDecoration(
                                      labelText: 'E-mail',
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.deepPurpleAccent))),
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
                                  validator:
                                      TinyValidators.internal().passValidator,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
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
                                  Icons.security,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  validator: (v) =>
                                      v == _passKey.currentState.value
                                          ? null
                                          : "Password doesn't match",
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Verify Password',
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
                      if (_userType == UserType.User) ...[
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
                                    controller: _phone,
                                    validator: TinyValidators.internal()
                                        .phoneValidator,
                                    decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color:
                                                    Colors.deepPurpleAccent))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (_userType == UserType.Company) ...[
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
                                    Icons.link,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller: _logo,
                                    validator:
                                        TinyValidators.internal().urlValidator,
                                    decoration: InputDecoration(
                                        labelText: 'Logo URL',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color:
                                                    Colors.deepPurpleAccent))),
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
                                    Icons.link,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller: _location,
                                    validator:
                                        TinyValidators.internal().urlValidator,
                                    decoration: InputDecoration(
                                        labelText: 'Location Link',
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color:
                                                    Colors.deepPurpleAccent))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      if (_error != '') ...[
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Text(
                          '$_error',
                          style: Theme.of(context)
                              .inputDecorationTheme
                              .errorStyle
                              .copyWith(fontSize: 18.0),
                          textScaleFactor: 1.0,
                        ),
                      ],
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      TinyContainer(
                        onTap: () async => await _reg(),
                        text: 'Register',
                        backgroundColor: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
