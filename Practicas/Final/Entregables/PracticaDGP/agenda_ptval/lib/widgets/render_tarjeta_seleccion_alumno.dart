import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderTarjetaSeleccionAlumno extends StatelessWidget {

  final List<Alumno> listaAlumnos;

  const RenderTarjetaSeleccionAlumno({
    Key? key,
    required this.listaAlumnos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(listaAlumnos.length, (index) {
        return TarjetaSeleccionAlumno(alumno: listaAlumnos[index]);
      }),
    );
  }
}