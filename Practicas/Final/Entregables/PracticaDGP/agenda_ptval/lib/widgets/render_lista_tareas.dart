import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RenderListaTareas extends StatelessWidget {
  RenderListaTareas({
    required this.listaTareas,
    Key? key
  }) : super(key: key);

  List<TarjetaTarea> listaTareas;

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