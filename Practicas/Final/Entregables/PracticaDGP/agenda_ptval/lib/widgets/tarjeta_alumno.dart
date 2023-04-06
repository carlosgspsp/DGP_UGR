import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:mysql1/mysql1.dart';
import '../models/alumno.dart';
import '../enumerators/ventanas_origen';
import '../enumerators/tipos_login';
import 'dart:convert';
import 'dart:typed_data';

class TarjetaAlumno extends StatelessWidget {
  final Alumno alumno;
  final Enum ventanaOrigen;
  late Blob blob;
  Controller controlador = Controller();
  TarjetaAlumno({required this.alumno, required this.ventanaOrigen, Key? key})
      : super(key: key);

  /*Future<void> pruebaimagenes() async {
    print("hola");
    blob = Blob.fromString(alumno.fotoPerfil);

    String query =
        "INSERT into `testImagenes` (idtestImagenes, imagentest) values (?,?)";
    List<String> valores = ['0', alumno.fotoPerfil];

    var resultadoQuery = await controlador.queryBD(query, valores);

    return resultadoQuery;
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 85,
              backgroundImage: NetworkImage(alumno.fotoPerfil),
            ),
            const SizedBox(width: 20),
            Container(
              height: 140,
              width: 500,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFA8EC77)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(width: 2.0),
                    ),
                  ),
                ),
                onPressed: () {
                  switch (ventanaOrigen) {
                    case ventanasOrigen.LOGIN:
                      switch (alumno.tipoLogin) {
                        case tiposLogin.IMAGENES:
                          //pruebaimagenes();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginAlumnoImagenes(alumno: alumno)));
                          break;
                        case tiposLogin.PATRON:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginAlumnoPatron(alumno: alumno)));
                          break;
                        case tiposLogin.TEXTO:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginAlumnoTexto(alumno: alumno)));
                          break;
                      }

                      break;
                    case ventanasOrigen.CREAR_EDITAR:
                      var nav = Navigator.of(context);
                      nav.pop(alumno);
                      nav.pop(alumno);
                      break;
                    case ventanasOrigen.MENU_COMIDA:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeleccionMenuScreen(
                                    nombreAlumno: 'Nombre Alumno',
                                    urlImagenPerfilAlumno:
                                        'assets/images/student.png',
                                  )));
                      break;
                  }
                },
                child: Text("${alumno.nombre} ${alumno.apellidos}",
                    style: const TextStyle(fontSize: 50, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
