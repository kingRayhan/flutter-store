import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  final Function validator;
  final Function onSave;
  final String placeholder;
  final String label;
  final IconData icon;
  final bool isPasswordField;

  const AppTextInput({
    @required this.placeholder,
    @required this.label,
    @required this.onSave,
    this.icon,
    this.isPasswordField = false,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => new _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  bool _isObSecure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: widget.isPasswordField && _isObSecure,
        validator: widget.validator,
        onSaved: widget.onSave,
        decoration: InputDecoration(
          labelText: widget.placeholder,
          border: OutlineInputBorder(),
          hintText: widget.label,
          icon: widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObSecure = !_isObSecure;
                    });
                  },
                  child: Icon(
                      _isObSecure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
        ),
      ),
    );
  }
}
