import 'package:elrizk_task/models/user_model.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Hi ${_userModel.name}',
                      textScaleFactor: 1.0,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  if (_error != null) ...[
                    Text(
                      _error,
                      textScaleFactor: 1.0,
                      style: Theme.of(context).inputDecorationTheme.errorStyle,
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
