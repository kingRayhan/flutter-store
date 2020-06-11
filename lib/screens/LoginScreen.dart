import 'dart:convert';

import 'package:flutter_store/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_store/validators/FormValidator.dart';
import 'package:flutter_store/widgets/AppTextInput.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _scafoldKey = new GlobalKey<ScaffoldState>();
  bool _isSubmitting = false;

  Map credentials = {"identifier": null, "password": null};

  Widget _identifierField() => AppTextInput(
        placeholder: "Username or Email",
        label: "Your Username or Email",
        icon: Icons.account_circle,
        validator: (String input) {
          return input.length == 0 ? "Required" : null;
        },
        onSave: (String value) {
          credentials["identifier"] = value;
        },
      );

  Widget _passwordField() => AppTextInput(
        isPasswordField: true,
        placeholder: "Password",
        label: "Your password",
        icon: Icons.lock,
        validator: FormValidator.passwordValidator,
        onSave: (String value) {
          credentials["password"] = value;
        },
      );

  void _redirectAfterSuccess() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/register");
    });
  }

  void _handleSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() => _isSubmitting = true); // make the button loading

      // Make api call
      http.Response response = await http.post(
        "http://172.17.10.34:1337/auth/local",
        body: credentials,
      );
      setState(() => _isSubmitting = false); // stop the button loading
      var apiRes = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Helper.console(apiRes);
        _formKey.currentState.reset();
        Helper.SuccessSnakbar("You have successfully logged in", _scafoldKey);
        _redirectAfterSuccess();
      } else {
        Helper.ErrorSnakbar("Invalid credentials", _scafoldKey);
        // Helper.ErrorSnakbar(
        //     apiRes["message"][0]["messages"][0]["message"], _scafoldKey);
      }
    }
  }

  Widget _submitButton() {
    return _isSubmitting
        ? CircularProgressIndicator()
        : Align(
            alignment: Alignment.center,
            child: Column(children: [
              RaisedButton.icon(
                onPressed: () {
                  _handleSubmit();
                },
                icon: Icon(Icons.lock_open),
                label: Text("Login"),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Text("Already have an account? login"))
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login".toUpperCase(),
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _identifierField(),
                          _passwordField(),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    _submitButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
