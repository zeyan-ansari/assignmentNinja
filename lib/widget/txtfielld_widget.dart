import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.textEditingController, required this.text, required this.iconName,
  });

  final TextEditingController textEditingController;
  final String text;
  final IconData iconName;
  @override
  Widget build(BuildContext context) {
    return Container(height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.3))),
      margin: const EdgeInsets.all(15),
      child: TextFormField(
        controller: textEditingController,
        autofocus: false,
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
        decoration:  InputDecoration(
          border: InputBorder.none,
          hintText: text,
          prefixIcon: Icon(
            iconName,
            color: Colors.blue,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(top: 5),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
