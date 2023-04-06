import 'package:flutter/material.dart';

class Alumno {
  String nombre;
  String apellidos;
  String dni;
  String correo;
  String fotoPerfil;
  Enum tipoLogin;
  String password;
  int autorizado;

  Alumno({
    required this.nombre,
    required this.apellidos,
    required this.dni,
    required this.correo,
    required this.fotoPerfil,
    required this.tipoLogin,
    required this.password,
    required this.autorizado,
  });
}
