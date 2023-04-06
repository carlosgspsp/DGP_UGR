import 'package:agenda_ptval/screens/gestion_alumnos_admin.dart';
import 'package:agenda_ptval/screens/home_todos_screen.dart';
import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../enumerators/ventanas_origen';
import '../enumerators/tipos_login';
import '../enumerators/roles';

import '../screens/lista_tareas.dart';
import '../widgets/custom_card_image.dart';
import 'alumno.dart';

class MenuOption {
  final String route;
  final String name;
  final Widget screen;
  final Enum rol;

  MenuOption(
      {required this.route,
      required this.name,
      required this.screen,
      required this.rol});
}

// ignore: camel_case_types
class homeMenuOptions {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    // MenuOption(
    //   route: 'home',
    //   name: 'Home Screen',
    //   screen: const HomeScreen(),
    //   icon: Icons.home
    // ),

    MenuOption(
        route: 'gestion_alumnos',
        name: 'GESTION ALUMNOS',
        rol: roles.ADMIN,
        screen: GestionAlumnosScreen()),

    MenuOption(
      route: 'lista_tareas',
      name: 'GESTIÓN TAREAS',
      rol: roles.ADMIN_PROFESOR,
      screen: ListaTareasScreen(
        listaTareas: [],
      ),
    ),

    MenuOption(
      route: 'lista_comandas',
      name: 'GESTIÓN COMANDAS',
      rol: roles.ADMIN_PROFESOR,
      // Ya no recibe la lista de comandas, sino que se obtiene de la base de datos
      screen: ListaComandasScreen(),
    ),

   

    

     
  ];
}
