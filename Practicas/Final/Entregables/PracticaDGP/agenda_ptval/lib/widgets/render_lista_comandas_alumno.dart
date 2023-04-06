import 'package:agenda_ptval/widgets/tarjeta_comanda_alumno.dart';
import 'package:agenda_ptval/widgets/tarjeta_tarea_alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaComandasAlumno extends StatelessWidget {

  List<TarjetaComandaAlumno> listaComandas;

  RenderListaComandasAlumno({
    required this.listaComandas,
    Key? key
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listaComandas.length,
      itemBuilder: (BuildContext context, int index) {
        return listaComandas[index];
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(),
    );
  }
}