import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaClases extends StatelessWidget {
  RenderListaClases({required this.listaClases, Key? key}) : super(key: key);

  List<TarjetaClase> listaClases;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listaClases.length,
      itemBuilder: (BuildContext context, int index) {
        return listaClases[index];
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20),
    );
  }
}
