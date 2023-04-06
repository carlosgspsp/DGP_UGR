import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';

class TarjetaImagenLoginAlumno extends StatefulWidget {

  final String imagen;
  final int idImagen;
  static List<String> imagenesSeleccionadas = [];

  const TarjetaImagenLoginAlumno({
    Key? key,
    required this.imagen,
    required this.idImagen,
  }) : super(key: key);

  @override
  State<TarjetaImagenLoginAlumno> createState() => _TarjetaImagenLoginAlumnoState();
}

class _TarjetaImagenLoginAlumnoState extends State<TarjetaImagenLoginAlumno> {

  Color _actualColor = Colors.black;
  double _actualWidth = 2.0;
  final int _maxSelected = 2;
  bool _isSelected = false;

  changeContainerStyle() {
    setState(() {
    
      if (!_isSelected && LoginAlumnoImagenes.selected < _maxSelected) {
        LoginAlumnoImagenes.selected++;
        _isSelected = true;
        _actualColor = const Color(0xFFA8EC77);
        _actualWidth = 4.0;
        TarjetaImagenLoginAlumno.imagenesSeleccionadas.add(widget.idImagen.toString());
      } else if (_isSelected) {
        if (LoginAlumnoImagenes.selected > 0) {
          LoginAlumnoImagenes.selected--;
        }
        _isSelected = false;
        _actualColor = Colors.black;
        _actualWidth = 2.0;
        if (TarjetaImagenLoginAlumno.imagenesSeleccionadas.isNotEmpty) {
          TarjetaImagenLoginAlumno.imagenesSeleccionadas.remove(widget.idImagen.toString());
        }
      } 
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: _actualColor,
            width: _actualWidth,
          ),
        ),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/loading.gif'),
          image: NetworkImage(widget.imagen),
          fit: BoxFit.cover,
        ),
      ),
      onTap: () => changeContainerStyle(),
    );
  }
}