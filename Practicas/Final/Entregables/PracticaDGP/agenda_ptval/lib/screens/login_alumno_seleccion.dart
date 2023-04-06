import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class ListaAlumnosLogin extends StatefulWidget {

  // Debe recibir una lista de alumnos de la clase seleccionada
  // almacenada en la base de datos.

  List<List<Alumno>> listaAlumnos;

  ListaAlumnosLogin({
    Key? key,
    required this.listaAlumnos,
  }) : super(key: key);

  @override
  State<ListaAlumnosLogin> createState() => _ListaAlumnosLoginState();
}

class _ListaAlumnosLoginState extends State<ListaAlumnosLogin> {

  late final CarouselSliderController _sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Text(
          "CLASE",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 1200,
              // width: 200,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  return RenderTarjetaSeleccionAlumno(
                      listaAlumnos: widget.listaAlumnos[index]);
                },
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 32),
                  indicatorBorderColor: Colors.black,
                ),
                itemCount: widget.listaAlumnos.length,
                initialPage: 0,
                enableAutoSlider: false,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Align(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 240, maxWidth: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.large(
                      heroTag: 'btn1',
                      elevation: 0.0,
                      backgroundColor: const Color(0xFFA8EC77),
                      onPressed: (() => _sliderController.previousPage()),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.black,),
                    ),

                    FloatingActionButton.large(
                      heroTag: 'btn2',
                      elevation: 0.0,
                      backgroundColor: const Color(0xFFA8EC77),
                      onPressed: (() => _sliderController.nextPage()),
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.black,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}