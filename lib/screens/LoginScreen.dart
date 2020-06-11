import 'package:flutter/material.dart';
import 'package:flutter_store/screens/LoginScreen.dart';
import 'package:flutter_store/validators/FormValidator.dart';
import 'package:flutter_store/widgets/AppTextInput.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();

  Map credentials = {"email": null, "password": null};

  Widget _emailField() => AppTextInput(
        placeholder: "Email",
        label: "Your email address",
        icon: Icons.email,
        validator: FormValidator.emailValidator,
        onSave: (String value) {
          credentials["email"] = value;
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

  void _handleSubmit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                      key: formKey,
                      child: Column(
                        children: [
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
                          label: Text("Login"),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/register");
                            },
                            child: Text("Dont't have an account? Register"))
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
