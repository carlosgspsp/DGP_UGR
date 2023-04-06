import 'package:agenda_ptval/models/menu_option.dart';
import 'package:agenda_ptval/screens/crear_alumno.dart';
import 'package:agenda_ptval/screens/editar_alumno.dart';
import 'package:agenda_ptval/screens/lista_alumnos_admin.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import '../enumerators/roles';

class GestionAlumnosScreen extends StatefulWidget {
  var listaMenuGestionAlumno = <MenuOption>[
    MenuOption(
      route: 'gestion_alumnos',
      name: 'CREAR ALUMNO',
      rol: roles.ADMIN,
      screen: CrearAlumno()
    ),

    MenuOption(
      route: 'gestion_alumnos',
      name: 'MIS ALUMNOS',
      rol: roles.ADMIN,
      screen: const ListaAlumnosAdmin()
    ),
  ];
  GestionAlumnosScreen({Key? key}) : super(key: key);

  @override
  State<GestionAlumnosScreen> createState() => _GestionAlumnosScreenState();
  
}

class _GestionAlumnosScreenState extends State<GestionAlumnosScreen> {
  
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
          "GESTIÓN ALUMNOS",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 1000,
            child: ListView.separated(
              padding: const EdgeInsets.all(75),
              itemCount: widget.listaMenuGestionAlumno.length,
              itemBuilder: (context, item) => ListTile(
                visualDensity: VisualDensity(vertical: 4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0)),
                title: Center(
                    child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.listaMenuGestionAlumno[item].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widget.listaMenuGestionAlumno[item].screen));
                },
                tileColor: const Color(0xFF1BDAF1),
              ),
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
          Container(
            height: 90,
            width: 160,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0),
                  ),
                ),
              ),
              child: const Text(
                "ATRÁS",
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}