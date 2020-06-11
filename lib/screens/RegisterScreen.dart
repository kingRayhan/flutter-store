import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_store/Consts.dart';
import 'package:flutter_store/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_store/validators/FormValidator.dart';
import 'package:flutter_store/widgets/AppTextInput.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = new GlobalKey<FormState>();
  final _scafoldKey = new GlobalKey<ScaffoldState>();

  Map credentials = {"username": null, "email": null, "password": null};
  bool _isSubmitting = false;

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
                label: Text("Register"),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Text("Already have an account? login"))
            ]),
          );
  }

  void _redirectAfterSuccess() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  void _handleSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() => _isSubmitting = true); // make the button loading

      // Make api call
      http.Response response = await http.post(
        "${Consts.API_URL}/auth/local/register",
        body: credentials,
      );
      setState(() => _isSubmitting = false); // stop the button loading
      var apiRes = json.decode(response.body);

      if (response.statusCode == 200) {
        Helper.console(apiRes);
        _formKey.currentState.reset();
        Helper.SuccessSnakbar(
            "${credentials['username']} successfully registered", _scafoldKey);
        _redirectAfterSuccess();
      } else {
        Helper.ErrorSnakbar(
            apiRes["message"][0]["messages"][0]["message"], _scafoldKey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scafoldKey,
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
                      key: _formKey,
                      child: Column(
                        children: [
                          _userNameField(),
                          _emailField(),
                          _passwordField(),
                          _submitButton()
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
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
