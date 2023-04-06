import 'package:flutter/material.dart';

class Admin {
  String nombre;
  String apellidos;
  String dni;
  String fotoPerfil;
  String correo;
  String password;

  Admin({
    required this.nombre,
    required this.apellidos,
    required this.fotoPerfil,
    required this.dni,
    required this.correo,
    required this.password,
  });
}
