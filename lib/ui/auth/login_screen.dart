import 'package:elrizk_task/ui/about_app.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:elrizk_task/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  String _error = '';

  _login() async {
    if (_formKey.currentState.validate()) {
      try {
        await ApiProvider.internal()
            .loginWithEmailAndPass(_email.text, _pass.text);
      } catch (e) {
        if (e == 400)
          _error = 'Wrong E-mail or Password';
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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Login',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                          validator: Common.internal().emailValidator,
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
                          controller: _pass,
                          validator: Common.internal().passValidator,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
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
              if (_error != '') ...[
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                onTap: () async => await _login(),
                text: 'Login',
                backgroundColor: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AboutApp())),
                  child: Text(
                    'About The App',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
