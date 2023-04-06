import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/widgets/render_lista_tareas_alumno.dart';
import 'package:agenda_ptval/widgets/tarjeta_tarea_alumno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

import '../widgets/widgets.dart';

class ListaTareasAlumno extends StatefulWidget {

  Alumno alumno;
  List<List<TarjetaTareaAlumno>> listaTareasAlumno = [];

  ListaTareasAlumno({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  State<ListaTareasAlumno> createState() => _ListaTareasAlumnoState();
}

class _ListaTareasAlumnoState extends State<ListaTareasAlumno> {

  // Conexión a la base de datos
  final Controller _conn = Controller();

  late CarouselSliderController _sliderController;
  // Almacenar los pasos asociados a la tarea
      List<CustomCardImage> _pasosTarea= [];


  Future<void> _fetchTareasAlumno() async {
      widget.listaTareasAlumno.clear();

    // Obtener todas las tareas asociadas al alumno que ha iniciado sesión
    _conn.getTareasAlumno(widget.alumno.dni).then((value) {
      // Almacenar las tareas del alumno
      List<List<TarjetaTareaAlumno>> listaTareasAlumnoAux = [];
      List<TarjetaTareaAlumno> lista = [];
      TarjetaTareaAlumno tarjetaTarea;
      Tarea tarea;
      int max = 4;
      int i = 0;

      for (var row in value) {

        _fetchPasosTarea(row['ID_tarea']);

        tarea = Tarea(
          idTarea: row['ID_tarea'],
          nombreAlumno: widget.alumno.nombre,
          titulo: row['Titulo'],
          descripcion: row['Descripcion'],
          fechaIni: row['Fecha_ini'].toString(),
          fechaFin: row['Fecha_fin'].toString(),
          horaIni: row['Hora_ini'].toString(),
          horaFin: row['Hora_fin'].toString(),
          urlImagenPerfil: row['URL_foto'],
          realizada: row['Realizada'],
          feedback: row['Tiene_feedback'],
          urlComprobante: row['URL_foto_completada'].toString(),
          urlFeedback: row['URL_foto_feedback'].toString(),
          pasos: _pasosTarea,
        );

        print('LOS PASOS DE MI TAREA SON: ${tarea.pasos.length}');

        tarjetaTarea = TarjetaTareaAlumno(alumno: widget.alumno, tarea: tarea);
        lista.add(tarjetaTarea);
        i++;
        if (i == max) {
          listaTareasAlumnoAux.add(lista);
          lista = [];
          i = 0;
        }
      }

      if (i < max && lista.isNotEmpty) {
        listaTareasAlumnoAux.add(lista);
      }

      setState(() {
        widget.listaTareasAlumno = listaTareasAlumnoAux;
      });
    });
  }

  Future<void> _fetchPasosTarea(String idTarea) async {
    // Obtener todos los pasos asociados a la tarea
    
    _conn.getPasosTarea(idTarea).then((value) {
      // Almacenar los pasos asociados a la tarea
      CustomCardImage paso;
      for (var row in value) {
        paso = CustomCardImage(
          imageUrl: row['URL_imagen'],
          cardName: row['Titulo'],
          idPaso: row['ID_paso'],
        );
        _pasosTarea.add(paso);
        print(idTarea);
        print(paso.cardName);
      }
      print('La tarea tiene ${_pasosTarea.length} pasos');
    });
  }

  @override
  void initState() {
    super.initState();

    _sliderController = CarouselSliderController();
    _fetchTareasAlumno();
    
  }

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
          "MIS TAREAS",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 900,
              // width: 200,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  return RenderListaTareasAlumno(
                    listaTareas: widget.listaTareasAlumno[index]
                  );
                },
                // slideTransform: null,
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 32),
                  indicatorBorderColor: Colors.black,
                ),
                itemCount: widget.listaTareasAlumno.length,
                initialPage: 0,
                enableAutoSlider: false,
              ),
            ),
          ),
          // Flechas de navegación entre las tareas del alumno
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