import 'package:elrizk_task/models/user_model.dart';
import 'package:elrizk_task/ui/auth/login_screen.dart';
import 'package:elrizk_task/ui/profile_screen.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel _userModel;
  bool _isLoading = true;
  String _error;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    try {
      _userModel = await ApiProvider.internal().getUserData(widget.user);
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? TinyLoading()
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProfileScreen(widget.user, _userModel),
                                  ),
                                ),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Text(
                                _userModel.userType == UserType.Company
                                    ? 'Company'
                                    : 'Client',
                                textScaleFactor: 1.0,
                                style: Theme.of(context).textTheme.display3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_userModel.userType == UserType.Company) ...[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  spreadRadius: 2.0,
                                  blurRadius: 2.0)
                            ],
                            image: DecorationImage(
                                image: NetworkImage('${_userModel.logoURL}')),
                          ),
                        ),
                      ),
                    ],
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          'Hi, \nWelcome ${_userModel.name}'
                          '\n\n\nYou can view and edit your profile by clicking on you account type Above.',
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TinyContainer(
                        maxWidth: MediaQuery.of(context).size.width * 0.35,
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            (route) => false),
                        text: 'LogOut',
                        backgroundColor: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_error != null) ...[
                      Expanded(
                        flex: 1,
                        child: Text(
                          _error,
                          textScaleFactor: 1.0,
                          style:
                              Theme.of(context).inputDecorationTheme.errorStyle,
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
