import 'package:flutter/material.dart';

class GenTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType inputType;

  const GenTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.inputType
  }) : super(key: key);

  // No sé si vamos a trabajar con email o con nombre de usuario
  validateEmail(String email) {
    final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailReg.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controller,
        validator: (value) { 
          if (value!.isEmpty) {
            return 'Por favor, introduzca $hintText';
          }

          if (inputType == TextInputType.emailAddress && !validateEmail(value)) {
            return 'Por favor, introduzca un email válido';
          }

          return null;
        },
        onSaved: (value) => controller.text = value!,
        keyboardType: inputType,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 40.0),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            // borderSide: BorderSide(color: Color(0xFF1BDAF1)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 25.0),
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFEEEEEE),
          prefixIcon: Icon(icon, size: 40.0,),
        )
      )
    );
  }
}