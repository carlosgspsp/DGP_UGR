import 'package:agenda_ptval/screens/home_todos_screen.dart';
import 'package:agenda_ptval/screens/lista_comandas_alumno.dart';
import 'package:agenda_ptval/screens/lista_tareas_alumno.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/models/menu_option.dart';
import '../enumerators/roles';

class MenuInicialScreen extends StatefulWidget {
  Enum rol;
  var listaMenu = <MenuOption>[];
  var usuario;

  MenuInicialScreen({super.key, required this.rol, required this.usuario});
  //estudiante, educador, admin
  @override
  State<MenuInicialScreen> createState() => _MenuInicialScreenState();

  void rellenarLista() {
    for (MenuOption menu in homeMenuOptions.menuOptions) {
      if (menu.rol == this.rol ||
          menu.rol == roles.ALL ||
          (this.rol != roles.ALUMNO && menu.rol == roles.ADMIN_PROFESOR)) {
        listaMenu.add(menu);
      }
    }
    // Añadir la única pantalla que verá el alumno
    // MenuOption optionAlum = MenuOption(
    //   route: 'tareas_alumno',
    //   name: 'MIS TAREAS',
    //   rol: roles.ALUMNO,
    //   screen: ListaTareasAlumno(alumno: usuario),
    // );

    // listaMenu.add(optionAlum);

    if (this.rol == roles.ALUMNO) {
      // Añadir la pantalla de tareas que verá el alumno
      MenuOption optionAlumTareas = MenuOption(
        route: 'tareas_alumno',
        name: 'MIS TAREAS',
        rol: roles.ALUMNO,
        screen: ListaTareasAlumno(alumno: usuario),
      );

      listaMenu.add(optionAlumTareas);

      // Añadir la pantalla de comandas que verá el alumno
      MenuOption optionAlumComandas = MenuOption(
        route: 'comandas_alumno',
        name: 'MIS COMANDAS',
        rol: roles.ALUMNO,
        screen: ListaComandasAlumno(alumno: usuario),
      );

      listaMenu.add(optionAlumComandas);
    }
  }
}

class _MenuInicialScreenState extends State<MenuInicialScreen> {
  @override
  Widget build(BuildContext context) {
    widget.rellenarLista();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "MENÚ",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: widget.rol == roles.ALUMNO
            ? const Color(0xFFA8EC77)
            : const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 1000,
            child: ListView.separated(
              padding: const EdgeInsets.all(75),
              itemCount: widget.listaMenu.length,
              itemBuilder: (context, item) => ListTile(
                visualDensity: VisualDensity(vertical: 4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0)),
                title: Center(
                    child: Container(
                  height: widget.rol == roles.ALUMNO
                      ? 300
                      : widget.rol == roles.PROFESOR
                          ? 200
                          : 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.listaMenu[item].name,
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
                          builder: (context) => widget.listaMenu[item].screen));
                },
                tileColor: widget.rol == roles.ALUMNO
                    ? const Color(0xFFA8EC77)
                    : const Color(0xFF1BDAF1),
              ),
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
          Container(
            height: 90,
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeTodosScreen()),
                );
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
                "SALIR",
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
