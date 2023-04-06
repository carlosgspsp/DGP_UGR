import 'package:agenda_ptval/screens/login_admin.dart';
import 'package:agenda_ptval/screens/login_profesor.dart';
import 'package:agenda_ptval/screens/menu_inicial_screen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:logging/logging.dart';
import '../enumerators/ventanas_origen';
import '../enumerators/roles';

class HomeTodosScreen extends StatefulWidget {
  List<List<TarjetaClase>>? listaClases = [];
  /*late List<List<TarjetaClase>>? listaClases; = [
    [
      TarjetaClase(
        nombreClase: "1ºA",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºB",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºC",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºD",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºE",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºF",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "1ºG",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
    ],
    [
      TarjetaClase(
        nombreClase: "2ºA",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºB",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºC",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºD",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºE",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºF",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
      TarjetaClase(
        nombreClase: "2ºG",
        ventanaOrigen: ventanasOrigen.LOGIN,
      ),
    ]
  ];*/
  final int numeroClasesPorPantalla = 8;
  HomeTodosScreen({Key? key}) : super(key: key);

  @override
  State<HomeTodosScreen> createState() => _HomeTodosScreenState();
}

class _HomeTodosScreenState extends State<HomeTodosScreen> {
  late CarouselSliderController _sliderController;
  Controller controlador = new Controller();

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
          ventanaOrigen: ventanasOrigen.LOGIN));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "INICIO",
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
              child: CarouselSlider.builder(
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  if (widget.listaClases != null) {
                    return RenderListaClases(
                        listaClases: (widget.listaClases)![index]);
                  }
                  throw 'La lista de clases es null';
                },
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 0),
                  indicatorBorderColor: Colors.black,
                ),
                itemCount: widget.listaClases != null
                    ? (widget.listaClases)!.length
                    : 0,
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
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 190,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginAdminScreen(
                                rol: roles.ADMIN,
                              )),
                    );
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFA8EC77)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(width: 2.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "ADMIN",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 190,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginProfeScreen(rol: roles.PROFESOR)),
                    );
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFA8EC77)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(width: 2.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "PROFESOR",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
