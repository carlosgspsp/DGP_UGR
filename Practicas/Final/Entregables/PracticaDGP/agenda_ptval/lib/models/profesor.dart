import 'package:flutter/material.dart';

class Profesor {
  String nombre;
  String apellidos;
  String dni;
  String fotoPerfil;
  String correo;
  String password;

  Profesor({
    required this.nombre,
    required this.apellidos,
    required this.fotoPerfil,
    required this.dni,
    required this.correo,
    required this.password,
  });
}