import 'package:agenda_ptval/screens/home_todos_screen.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'models/tarea.dart';
import 'models/alumno.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool expr = true;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              breakpoints: const [
                ResponsiveBreakpoint.resize(350, name: MOBILE),
                ResponsiveBreakpoint.autoScale(600, name: TABLET),
                ResponsiveBreakpoint.resize(800, name: DESKTOP),
                ResponsiveBreakpoint.resize(950, name: 'GRID'),
                ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
              ],
            ),
        debugShowCheckedModeBanner: false,
        title: 'Agenda PTVAL',
        home: HomeTodosScreen(
            /*listaClases: [
            [
              const TarjetaClase(
                nombreClase: "1ºA",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºB",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºC",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºD",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºE",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºF",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "1ºG",
                ventanaOrigen: "login",
              ),
            ],
            [
              const TarjetaClase(
                nombreClase: "2ºA",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºB",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºC",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºD",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºE",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºF",
                ventanaOrigen: "login",
              ),
              const TarjetaClase(
                nombreClase: "2ºG",
                ventanaOrigen: "login",
              ),
            ]
          ],*/
            ));
  }
}
