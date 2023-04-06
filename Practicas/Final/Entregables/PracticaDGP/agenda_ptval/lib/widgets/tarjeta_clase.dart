import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/lista_alumnos_screen.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../enumerators/tipos_login';

class TarjetaClase extends StatefulWidget {
  final String nombreClase;
  final Enum ventanaOrigen;
  late List<List<TarjetaAlumno>> listaAlumnos = [];
  final int numeroAlumnosPorPantalla = 8;

  TarjetaClase(
      {required this.nombreClase, required this.ventanaOrigen, Key? key})
      : super(key: key);

  @override
  State<TarjetaClase> createState() => _TarjetaClaseState();
}

class _TarjetaClaseState extends State<TarjetaClase> {
  List<List<Alumno>> _listaAlumnos = [];
  Controller controlador = new Controller();

  @override
  void initState() {
    super.initState();
    rellenarListaAlumnos();
  }

  Future<void> rellenarListaAlumnos() async {
    String query =
        "SELECT * FROM `clas_tiene_alum` WHERE `Nombre_clase` LIKE '${widget.nombreClase}'";
    var resultadoQuery = await controlador.queryBD(query, []);

    List<TarjetaAlumno> listaTodosAlumnos = [];
    List<TarjetaAlumno> listaAux = [];

    for (var row in resultadoQuery) {
      query =
          "SELECT * FROM `alumno` WHERE `DNI_alumno` LIKE '${row['DNI_alumno']}'";
      var resultadoQueryAlumno = await controlador.queryBD(query, []);

      for (var row2 in resultadoQueryAlumno) {
        listaTodosAlumnos.add(TarjetaAlumno(
          alumno: Alumno(
            nombre: row2['Nombre'],
            dni: row2['DNI_alumno'],
            apellidos: row2['Apellidos'],
            fotoPerfil: row2['URL_foto'],
            correo: row2['Correo'],
            tipoLogin: row2['Tipo_alumno'] == 1
                ? tiposLogin.IMAGENES
                : row2['Tipo_alumno'] == 2
                    ? tiposLogin.PATRON
                    : tiposLogin.TEXTO,
            //tipoAlumno: row2['Tipo_alumno'],
            autorizado: row2['Autorizado'],
            password: row2['Contrasennia'],
          ),
          ventanaOrigen: widget.ventanaOrigen,
        ));
      }
    }

    int contador = 0;

    for (int i = 0; i < listaTodosAlumnos.length; i++) {
      if (contador == widget.numeroAlumnosPorPantalla - 1) {
        contador = 0;
        setState(() {
          (widget.listaAlumnos)!.add(listaAux);
        });
        listaAux.clear();
      }

      listaAux.add(listaTodosAlumnos[i]);
      contador += 1;
    }
    if (listaAux.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        (widget.listaAlumnos)!.add(listaAux);
      });
    }

    print("RellenarClases: ${widget.listaAlumnos}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ElevatedButton(
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListaAlumnosScreen(
                        ventanaOrigen: widget.ventanaOrigen,
                        nombreClase: widget.nombreClase,
                        listaAlumnos: widget.listaAlumnos,
                      )));
        }),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFA8EC77)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(width: 2.0),
            ),
          ),
        ),
        child: Text(widget.nombreClase,
            style: const TextStyle(fontSize: 50, color: Colors.black)),
      ),
    );
  }
}
