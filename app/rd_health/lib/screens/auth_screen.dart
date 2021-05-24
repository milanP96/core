import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rd_health/providers/auth.dart';
import 'package:rd_health/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/test_screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  Future<void> _submit() async {
    // setState(() {
    //   _isLoading = true;
    // });
    print(_email.text);
    print(_password.text);
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _email.text,
        _password.text,
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName, (Route<dynamic> route) => false);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      // _showErrorDialog(errorMessage);
    } catch (error) {
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      // _showErrorDialog(errorMessage);
    }

    // setState(() {
    //   _isLoading = false;
    // });

    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     BrowseScreen.routeName, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Ovo je neki logo")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextField(_email, false, "Email", false),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextField(_password, false, "Password", true),
          ),
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {
                _submit();
                // Navigator.pushReplacementNamed(
                //     context, AuthScreen.routeName);
              },
              child: Text("LOGIN",
                  style: TextStyle(
                      fontFamily: 'ProjectFont',
                      fontWeight: FontWeight.w100,
                      fontSize: 13)),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomTextField extends StatelessWidget {
  TextEditingController _c;
  bool numeric = false;
  String hint;
  bool pwd;

  CustomTextField(this._c, this.numeric, this.hint, this.pwd);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      obscureText: pwd,
      inputFormatters: numeric
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : <TextInputFormatter>[],
      controller: _c,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 16, // This is not so important
      ),
      decoration: new InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: 10, right: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.black12, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.black12, width: 1.0),
        ),
      ),
    );
  }
}
