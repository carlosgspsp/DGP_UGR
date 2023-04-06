import 'package:agenda_ptval/models/material.dart';
import 'package:flutter/material.dart';


class ListTileMaterial extends StatefulWidget {

  final MaterialClase material;

  const ListTileMaterial({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<ListTileMaterial> createState() => _ListTileMaterialState();
}

class _ListTileMaterialState extends State<ListTileMaterial> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cantidadMatController = TextEditingController();

  Future<int?> editarCantidadMaterial() => showDialog<int?> (
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 35.0),
      title: Text('${widget.material.nombreMaterial}', style: const TextStyle(fontSize: 30.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _cantidadMatController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nueva cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Color(0xFF1BDAF1)),
                  ),
                  focusColor:Color(0xFF1BDAF1),
                  errorStyle: TextStyle(fontSize: 20.0),
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'Introduzca una cantidad correcta';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(int.parse(_cantidadMatController.text));
            }
          },
          child: const Text('Aceptar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      title: Text(widget.material.nombreMaterial, style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      tileColor: Colors.grey[300],
      trailing: Text('Cantidad: ${widget.material.cantidadMaterial}', style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      onTap: () {
        editarCantidadMaterial().then((value) {
          if (value != null) {
            setState(() {
              widget.material.cantidadMaterial = value;
            });
          }
        });
      },
    );
  }
}