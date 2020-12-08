import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool hideText;
  final Color bgColor;
  CustomTextField(
      {@required this.placeholder,
      @required this.controller,
      this.hideText,
      this.bgColor});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: (widget.bgColor != null) ? widget.bgColor : Colors.tealAccent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextFormField(
          style: TextStyle(
              color: (widget.bgColor != null) ? Colors.white : Colors.blueGrey),
          controller: widget.controller,
          obscureText: widget.hideText,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                fontSize: 17,
                color:
                    (widget.bgColor != null) ? Colors.white : Colors.blueGrey),
            hintText: widget.placeholder,
            border: InputBorder.none,
            // suffixIcon: IconButton(
            //   icon: Icon(Icons.remove_red_eye),
            //   onPressed: () => setState(() {
            //     _obscure = true;
            //   }),
            //),
            contentPadding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }
}
