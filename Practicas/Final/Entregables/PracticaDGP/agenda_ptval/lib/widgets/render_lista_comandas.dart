import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaComandas extends StatelessWidget {
  
  RenderListaComandas({
    required this.listaComandas,
    Key? key
  }) : super(key: key);

  List<TarjetaComanda> listaComandas;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listaComandas.length,
      itemBuilder: (BuildContext context, int index) {
        return listaComandas[index];
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
    );
  }
}