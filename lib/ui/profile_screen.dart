import 'package:elrizk_task/models/user_model.dart';
import 'package:elrizk_task/ui/auth/login_screen.dart';
import 'package:elrizk_task/ui/change_password.dart';
import 'package:elrizk_task/ui/edit_profile.dart';
import 'package:elrizk_task/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:tiny_widgets/tiny_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseUser user;
  final UserModel userModel;

  ProfileScreen(this.user, this.userModel);

  _launchMaps(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 5),
      ));
    }
  }

  _deleteAccount(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Delete Account',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete your account ?',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Nope'),
              ),
              FlatButton(
                onPressed: () async {
                  TinyLoadingPopUp().tinyLoading(context);
                  await ApiProvider.internal().deleteUser(user.token);
                  await ApiProvider.internal().deleteUserData(user.uid);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (route) => false);
                },
                child: Text('Yup'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(top: 32.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
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
                      'My Profile',
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
                        userModel.userType == UserType.Company
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
            SizedBox(height: 40),
            if (userModel.userType == UserType.Company) ...[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('${userModel.logoURL}')),
                  ),
                ),
              ),
            ],
            SizedBox(height: 24),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                      flex: 5,
                      child: Text(
                        'Name : ${userModel.name}',
                        textScaleFactor: 1.0,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                      flex: 5,
                      child: Text(
                        'Phone : ${userModel.phoneNum}',
                        textScaleFactor: 1.0,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
                      flex: 5,
                      child: Text(
                        'E-mail : ${user.email}',
                        textScaleFactor: 1.0,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            if (userModel.userType == UserType.Company) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TinyContainer(
                  text: 'My Location',
                  textColor: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                  onTap: () => _launchMaps("${userModel.locationURL}"),
                ),
              ),
            ],
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            InkWell(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditProfile(user, userModel),
                    ),
                  ),
              child: Container(
                child: Text(
                  'I want to edit my profile',
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 28.0),
            InkWell(
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChangePassword(user),
                    ),
                  ),
              child: Container(
                child: Text(
                  'I want to change my password',
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 28.0),
            InkWell(
              onTap: () => _deleteAccount(context),
              child: Container(
                child: Text(
                  'I want to delete my account',
                  textScaleFactor: 1.0,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
