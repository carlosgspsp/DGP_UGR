import 'package:agenda_ptval/widgets/tarjeta_alumno_admin.dart';
import 'package:agenda_ptval/widgets/tarjeta_tarea_alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaAlumnosAdmin extends StatelessWidget {

  List<TarjetaAlumnoAdmin> listaAlumnos;

  RenderListaAlumnosAdmin({
    required this.listaAlumnos,
    Key? key
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listaAlumnos.length,
      itemBuilder: (BuildContext context, int index) {
        return listaAlumnos[index];
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(),
    );
  }
}