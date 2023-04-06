import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaAlumnos extends StatelessWidget {

  List<TarjetaAlumno> listaAlumnos;

  RenderListaAlumnos({
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
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
    );
  }
}