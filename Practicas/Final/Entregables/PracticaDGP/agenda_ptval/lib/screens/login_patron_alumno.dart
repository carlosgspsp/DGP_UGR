import 'package:agenda_ptval/screens/menu_inicial_screen.dart';
import 'package:collection/collection.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import '../enumerators/roles';

class LoginAlumnoPatron extends StatefulWidget {
  final Alumno alumno;

  LoginAlumnoPatron({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  State<LoginAlumnoPatron> createState() => _LoginAlumnoPatronState();
}

class _LoginAlumnoPatronState extends State<LoginAlumnoPatron> {
  Future<bool> signIn(String inputPatter) async {
    // TODO: Comprobar que el patron introducido es igual al del alumno

    // Por ahora, se comprueba que el patron introducido es igual a 1234
    if (inputPatter == widget.alumno.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡PATRÓN CORRECTO!', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡PATRÓN INCORRECTO!', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      return false;
    }
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
          "PATRÓN",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
                child: Text(
              'DIBUJA TU PATRÓN',
              style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
            )),
            Flexible(
              child: PatternLock(
                pointRadius: 30,
                notSelectedColor: Colors.black,
                selectedColor: const Color(0xFFA8EC77),
                fillPoints: true,
                onInputComplete: (List<int> input) {
                  String inputString = input.join(" ");
                  print(inputString);
                  signIn(inputString).then((value) {
                    if (value) {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuInicioAlumno(alumno: widget.alumno)));alumno);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuInicialScreen(rol: roles.ALUMNO, usuario: widget.alumno)));
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
