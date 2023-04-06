import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import '../enumerators/ventanas_origen';

import '../datab_controller/controller.dart';

class ListaClasesScreen extends StatefulWidget {
  Enum ventanaOrigen;
  final int numeroClasesPorPantalla = 8;
  late List<List<TarjetaClase>> listaClases =
      [];

  ListaClasesScreen({required this.ventanaOrigen, Key? key}) : super(key: key);

  @override
  State<ListaClasesScreen> createState() => _ListaClasesScreenState();
}

class _ListaClasesScreenState extends State<ListaClasesScreen> {
  late CarouselSliderController _sliderController;
  Controller controlador = Controller();

  @override
  void initState() {
    super.initState();
    rellenarListaClases();
    _sliderController = CarouselSliderController();
  }

  Future<void> rellenarListaClases() async {
    String query = "SELECT * FROM `clase`";
    var resultado_query = await controlador.queryBD(query, []);

    //var resultado_query = await controlador.getAllTareas();
    print('aqui');
    List<TarjetaClase> listaTodasClases = [];
    List<TarjetaClase> listaAux = [];

    print(resultado_query);

    for (var row in resultado_query) {
      print(row['Nombre_clase']);
    }

    for (var row in resultado_query) {
      listaTodasClases.add(TarjetaClase(
          nombreClase: row['Nombre_clase'],
          ventanaOrigen: widget.ventanaOrigen));
    }

    print("listatodasClases: ${listaTodasClases}");

    int contador = 0;

    for (int i = 0; i < listaTodasClases.length; i++) {
      if (contador == widget.numeroClasesPorPantalla - 1) {
        contador = 0;
        if (!mounted) return;
        setState(() {
          (widget.listaClases)!.add(listaAux);
        });

        listaAux.clear();
      }

      listaAux.add(listaTodasClases[i]);
      contador += 1;
    }
    if (listaAux.isNotEmpty) {
      setState(() {
        if (!mounted) return;
        (widget.listaClases)!.add(listaAux);
      });
    }

    print("RellenarClases: ${widget.listaClases}");
  }


  Future<void> _pullRefresh() async {
    setState(() {
      Future.delayed(const Duration(seconds: 2));
      rellenarListaClases();
    });
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
          "LISTA DE CLASES",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      // body: ListView.separated(
      //   padding: const EdgeInsets.all(8),
      //   itemCount: widget.listaClases.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return widget.listaClases[index];
      //   },
      //   separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
      // ),
      body: RefreshIndicator(
        onRefresh: () async { _pullRefresh(); },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 1000,
                // width: 200,
                child: CarouselSlider.builder(
                  unlimitedMode: true,
                  controller: _sliderController,
                  slideBuilder: (index) {
                    return RenderListaClases(
                        listaClases: widget.listaClases[index]);
                  },
                  // slideTransform: null,
                  slideIndicator: CircularSlideIndicator(
                    padding: const EdgeInsets.only(bottom: 32),
                    indicatorBorderColor: Colors.black,
                  ),
                  itemCount: widget.listaClases.length,
                  initialPage: 0,
                  enableAutoSlider: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Align(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 240, maxWidth: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 48,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          _sliderController.previousPage();
                        },
                      ),
                      IconButton(
                        iconSize: 48,
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          _sliderController.nextPage();
                        },
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
