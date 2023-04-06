import 'package:agenda_ptval/widgets/render_lista_alumnos.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/screens/screens.dart';
import '../models/alumno.dart';
import '../enumerators/ventanas_origen';
import '../enumerators/tipos_login';

class ListaAlumnosScreen extends StatefulWidget {
  late String nombreClase;
  final Enum ventanaOrigen;
  late List<List<TarjetaAlumno>> listaAlumnos =
      []; 

  final int numeroAlumnosPorPantalla = 8;

  ListaAlumnosScreen(
      {required this.ventanaOrigen,
      required this.nombreClase,
      required this.listaAlumnos,
      Key? key})
      : super(key: key);

  @override
  State<ListaAlumnosScreen> createState() => _ListaAlumnosScreenState();
}

class _ListaAlumnosScreenState extends State<ListaAlumnosScreen> {
  late CarouselSliderController _sliderController;
  Controller controlador = new Controller();

  @override
  void initState() {
    super.initState();
    //rellenarListaAlumnos();
    _sliderController = CarouselSliderController();
  }
  @override
  Widget build(BuildContext context) {
    //rellenarListaAlumnos();
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
          "LISTA DE ALUMNOS",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 900,
              // width: 200,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  return RenderListaAlumnos(
                      listaAlumnos: widget.listaAlumnos[index]);
                },
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 0),
                  indicatorBorderColor: Colors.black,
                ),
                itemCount: widget.listaAlumnos.length,
                initialPage: 0,
                enableAutoSlider: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 240, maxWidth: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.large(
                      heroTag: 'btn1',
                      backgroundColor: const Color(0xFFA8EC77),
                      elevation: 0,
                      onPressed: () {
                        _sliderController
                            .previousPage(Duration(milliseconds: 600));
                      },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 500),
                    FloatingActionButton.large(
                      heroTag: 'btn2',
                      backgroundColor: const Color(0xFFA8EC77),
                      elevation: 0,
                      onPressed: () {
                        _sliderController.nextPage(Duration(milliseconds: 600));
                        ;
                      },
                      child: const Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.black,
                      ),
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
