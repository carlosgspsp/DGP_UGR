import 'package:agenda_ptval/screens/login_texto_alumno.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/models/alumno.dart';

class TarjetaSeleccionAlumno extends StatelessWidget {
  
  // Cada tarjeta representa a un alumno
  final Alumno alumno;

  const TarjetaSeleccionAlumno({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(alumno.fotoPerfil),
              width: 350.0,
              height: 350.0,
              fit: BoxFit.cover,
            ),
    
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text("${alumno.nombre} ${alumno.apellidos}".toUpperCase(),
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ),
      onTap: () {
        // Navegar a la pantalla de login correspondiente dependiendo del tipo de login del alumno
        if (alumno.tipoLogin == "texto") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAlumnoTexto(alumno: alumno)));
        }
        else if (alumno.tipoLogin == "imagen"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAlumnoImagenes(alumno: alumno)));
        }
        else if (alumno.tipoLogin == "patron"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginAlumnoPatron(alumno: alumno)));
        }
        
      }
    );
  }
}