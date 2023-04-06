import 'package:agenda_ptval/widgets/tarjeta_tarea_alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaTareasAlumno extends StatelessWidget {

  List<TarjetaTareaAlumno> listaTareas;

  RenderListaTareasAlumno({
    required this.listaTareas,
    Key? key
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listaTareas.length,
      itemBuilder: (BuildContext context, int index) {
        return listaTareas[index];
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(),
    );
  }
}