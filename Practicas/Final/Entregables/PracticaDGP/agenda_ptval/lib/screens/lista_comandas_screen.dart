import 'dart:math';

import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:agenda_ptval/screens/crear_comanda_screen.dart';
import 'package:agenda_ptval/widgets/render_lista_comandas.dart';
import 'package:agenda_ptval/widgets/render_lista_tareas.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class ListaComandasScreen extends StatefulWidget {
  List<List<TarjetaComanda>> listaComandas = [];

  ListaComandasScreen({Key? key}): super(key: key);

  @override
  State<ListaComandasScreen> createState() => _ListaComandasScreenState();
}

class _ListaComandasScreenState extends State<ListaComandasScreen> {
  late CarouselSliderController _sliderController;

  // Conexión con la base de datos
  final Controller _conn = Controller();

  Future<void> _fetchComandas() async {
     widget.listaComandas.clear();

    // Obtener todas las comandas de la base de datos
    _conn.getComandas().then((value) {
      // Almacenar las comandas
      List<List<TarjetaComanda>> listaComandasAux = [];
      List<TarjetaComanda> lista = [];
      TarjetaComanda comanda;
      int max = 4;
      int i = 0;
      
      for (var row in value) {
        comanda = TarjetaComanda(
          idComanda: row['id_com_mat'],
          nombreAlumno: 'Juan',
          titulo: row['nombre'],
          descripcion: row['descripcion'],
          urlImagenPerfil: row['url_imagen'],
          tipoComanda: 'Material'
        );

        // Añadir la comanda a la lista de comandas
        lista.add(comanda);
        i++;
        if (i == max) {
          // Añadir la lista de comandas a la lista de listas de comandas
          listaComandasAux.add(lista);
          lista = [];
          i = 0;
        }
      }

      if (i < max && lista.isNotEmpty) {
        listaComandasAux.add(lista);
      }

      setState(() {
        // Añadir la lista de comandas a la lista de listas de comandas
        widget.listaComandas = listaComandasAux;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
    _fetchComandas();
   
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Future.delayed(const Duration(seconds: 2));
      _fetchComandas();
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
          "LISTA DE COMANDAS",
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
                    return RenderListaComandas(
                      listaComandas: widget.listaComandas[index]
                    );
                  },
                  // slideTransform: null,
                  slideIndicator: CircularSlideIndicator(
                    padding: const EdgeInsets.only(bottom: 32),
                    indicatorBorderColor: Colors.black,
                  ),
                  itemCount: widget.listaComandas.length,
                  initialPage: 0,
                  enableAutoSlider: false,
                ),
              ),
            ),
            //Flechas
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
            //BOTÓN SALIR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 230,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CrearComandaScreen()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF1BDAF1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "CREAR COMANDA",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
