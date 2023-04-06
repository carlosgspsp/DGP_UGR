import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/widgets/render_lista_alumnos_admin.dart';
import 'package:agenda_ptval/widgets/tarjeta_alumno.dart';
import 'package:agenda_ptval/widgets/tarjeta_alumno_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import '../enumerators/tipos_login';
import 'package:mysql1/mysql1.dart';

class ListaAlumnosAdmin extends StatefulWidget {
  const ListaAlumnosAdmin({Key? key}) : super(key: key);

  @override
  State<ListaAlumnosAdmin> createState() => _ListaAlumnosAdminState();
}

class _ListaAlumnosAdminState extends State<ListaAlumnosAdmin> {

  // Conexión para la base de datos
  final Controller _conn = Controller();
  late CarouselSliderController _sliderController;
  final List<List<TarjetaAlumnoAdmin>> _alumnosFinal = [];
  

  Future<void> _fetchAlumnos() async {
    _alumnosFinal.clear();
    
    late Alumno alumno;
    TarjetaAlumnoAdmin tarjetaAlumno;
    // Lista de alumnos
    List<TarjetaAlumnoAdmin> lista = [];
    
    int max = 4;
    int i = 0;
    
    Results results = await _conn.getAlumnos();

    for (var row in results) {
      alumno = Alumno(
        nombre: row['Nombre'],
        apellidos: row['Apellidos'],
        dni: row['DNI_alumno'],
        correo: row['Correo'],
        fotoPerfil: row['URL_foto'],
        tipoLogin: tiposLogin.TEXTO,
        password: row['Contrasennia'],
        autorizado: row['Autorizado'],
        
      );
      lista.add(tarjetaAlumno = TarjetaAlumnoAdmin(alumno: alumno));
      i++;
      if (i == max) {
        setState(() {
          _alumnosFinal.add(lista);
        });
        lista = [];
        i = 0;
      }
    }
    
    if (i < max && lista.isNotEmpty) {
      setState(() {
        _alumnosFinal.add(lista);
      });
    }
    
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Future.delayed(const Duration(seconds: 2));
      _fetchAlumnos();
    });
  }


  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
    _fetchAlumnos();
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
          "ALUMNOS",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: const Color(0xFF1BDAF1),
        onRefresh: _pullRefresh,
        child: ListView(
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
                    return RenderListaAlumnosAdmin(
                        listaAlumnos: _alumnosFinal[index]);
                  },
                  slideIndicator: CircularSlideIndicator(
                    padding: const EdgeInsets.only(bottom: 0),
                    indicatorBorderColor: Colors.black,
                  ),
                  itemCount: _alumnosFinal.length,
                  initialPage: 0,
                  enableAutoSlider: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Align(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 240, maxWidth: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.large(
                        heroTag: 'btn1',
                        backgroundColor: const Color(0xFF1BDAF1),
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
                        backgroundColor: const Color(0xFF1BDAF1),
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
      ),
    );
  }
}