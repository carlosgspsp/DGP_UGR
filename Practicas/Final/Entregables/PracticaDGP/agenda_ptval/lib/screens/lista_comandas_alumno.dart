import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/models/comanda_material.dart';
import 'package:agenda_ptval/widgets/render_lista_comandas_alumno.dart';
import 'package:agenda_ptval/widgets/tarjeta_comanda_alumno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

import '../widgets/widgets.dart';

class ListaComandasAlumno extends StatefulWidget {

  Alumno alumno;
  List<List<TarjetaComandaAlumno>> listaComandasAlumno = [];

  ListaComandasAlumno({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  State<ListaComandasAlumno> createState() => _ListaComandasAlumnoState();
}

class _ListaComandasAlumnoState extends State<ListaComandasAlumno> {

  // Conexión a la base de datos
  final Controller _conn = Controller();

  late CarouselSliderController _sliderController;

  Future<void> _fetchComandasAlumno() async {
      widget.listaComandasAlumno.clear();

    // Obtener todas las comandas asociadas al alumno que ha iniciado sesión
    _conn.getComandasMaterialAlumno(widget.alumno.dni).then((value) {
      // Almacenar las comandas del alumno
      List<List<TarjetaComandaAlumno>> listaComandasAlumnoAux = [];
      List<TarjetaComandaAlumno> lista = [];
      TarjetaComandaAlumno tarjetaComandaMaterial;
      ComandaMaterial comandaMat;
      int max = 4;
      int i = 0;

      for (var row in value) {

        comandaMat = ComandaMaterial(
          nombreAlumno: widget.alumno.nombre,
          idComandaMaterial: row['id_com_mat'],
          nombreComandaMaterial: row['nombre'],
          descripcionComandaMaterial: row['descripcion'],
          urlImagenComandaMaterial: row['url_imagen'],
          urlComprobanteComandaMaterial: row['url_comprobante'].toString(),
        );

        tarjetaComandaMaterial = TarjetaComandaAlumno(alumno: widget.alumno, comandaMat: comandaMat);
        lista.add(tarjetaComandaMaterial);
        i++;
        if (i == max) {
          listaComandasAlumnoAux.add(lista);
          lista = [];
          i = 0;
        }
      }

      if (i < max && lista.isNotEmpty) {
        listaComandasAlumnoAux.add(lista);
      }

      setState(() {
        widget.listaComandasAlumno = listaComandasAlumnoAux;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _sliderController = CarouselSliderController();
    _fetchComandasAlumno();
    
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
          "MIS COMANDAS",
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
                  return RenderListaComandasAlumno(
                    listaComandas: widget.listaComandasAlumno[index]
                  );
                },
                // slideTransform: null,
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 32),
                  indicatorBorderColor: Colors.black,
                ),
                itemCount: widget.listaComandasAlumno.length,
                initialPage: 0,
                enableAutoSlider: false,
              ),
            ),
          ),
          // Flechas de navegación entre las comandas del alumno
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
                      backgroundColor: const Color(0xFFA8EC77),
                      elevation: 0,
                      onPressed: () {
                        _sliderController
                            .previousPage(const Duration(milliseconds: 600));
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
                        _sliderController.nextPage(const Duration(milliseconds: 600));
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