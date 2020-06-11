import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_store/validators/FormValidator.dart';
import 'package:flutter_store/widgets/AppTextInput.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = new GlobalKey<FormState>();

  Map credentials = {"username": null, "email": null, "password": null};

  Widget _userNameField() => AppTextInput(
        placeholder: "Username",
        label: "Your username",
        icon: Icons.people,
        validator: FormValidator.usernameValidator,
        onSave: (String value) {
          credentials["username"] = value.trim();
        },
      );

  Widget _emailField() => AppTextInput(
        placeholder: "Email",
        label: "Your email address",
        icon: Icons.email,
        validator: FormValidator.emailValidator,
        onSave: (String value) {
          credentials["email"] = value.trim();
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

  void _handleSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      try {
        http.Response response = await http.post(
          "http://172.17.10.34:1337/auth/local/register",
          body: {
            "username": "john",
            "email": "example@gmail.com",
            "password": "rayhan123"
          },
        );

        var apiRes = json.decode(response.body);
        print(apiRes);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register".toUpperCase(),
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _userNameField(),
                          _emailField(),
                          _passwordField(),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.center,
                      child: Column(children: [
                        RaisedButton.icon(
                          onPressed: () {
                            _handleSubmit();
                          },
                          icon: Icon(Icons.lock_open),
                          label: Text("Register"),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, "/login");
                            },
                            child: Text("Already have an account? login"))
                      ]),
                    )
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
