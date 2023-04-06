import 'dart:convert';
import 'package:agenda_ptval/screens/menu_inicial_screen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:agenda_ptval/models/imagen_login.dart';
import 'package:http/http.dart' as http;
import '../enumerators/roles';

class LoginAlumnoImagenes extends StatefulWidget {
  final Alumno alumno;
  static int selected = 0;

  LoginAlumnoImagenes({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  State<LoginAlumnoImagenes> createState() => _LoginAlumnoImagenesState();
}

class _LoginAlumnoImagenesState extends State<LoginAlumnoImagenes> {
  // URL de la API Arasaac para obtener las imágenes de formas geométricas
  final String _urlAPI =
      'https://api.arasaac.org/api/pictograms/es/search/formas%20geom%C3%A9tricas';
  // Hay que obtener la lista de imágenes del alumno
  final List<ImagenLogin> _listaImagenesLogin = [];

  Future<void> _fetchImagesLogin() async {
    final response = await http.get(Uri.parse(_urlAPI));

    if (response.statusCode == 200) {
      // Lista de JSON
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Recorrer la lista de JSON y convertirlos en objetos
      for (var json in jsonList) {
        ImagenLogin imagenLogin = ImagenLogin.fromJson(json);

        print(imagenLogin.idImagen);

        setState(() {
          _listaImagenesLogin.add(imagenLogin);
        });
      }

      // return _listaImagenesLogin;
    } else {
      // Si esta respuesta no fue OK, lanza un error.
      throw Exception('Fallo al cargar las imágenes');
    }
  }

  Future<bool> signIn() async {
    print(TarjetaImagenLoginAlumno.imagenesSeleccionadas);

    // Comprobar que se han seleccionado 2 imágenes antes de iniciar sesión
    if (TarjetaImagenLoginAlumno.imagenesSeleccionadas.length != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('POR FAVOR, ELIGE 2 IMÁGENES PARA ENTRAR.',
              style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 10),
        ),
      );
      return false;
    }

    String imagenesSeleccionadasString =
        TarjetaImagenLoginAlumno.imagenesSeleccionadas.join(" ");

    if (imagenesSeleccionadasString == widget.alumno.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('INICIO DE SESIÓN CORRECTO', style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('INICIO DE SESIÓN INCORRECTO',
              style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Obtener las imágenes del alumno al crear el widget
    _fetchImagesLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text("IMÁGENES",
                  style: TextStyle(fontSize: 50, color: Colors.black))),
          backgroundColor: const Color(0xFFA8EC77),
          elevation: 0,
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
        ),
        body: SafeArea(
          child: Column(
            children: [
              GridView.count(
                padding: const EdgeInsets.all(10.0),
                shrinkWrap: true,
                primary: true,
                crossAxisCount: 4,
                children: List.generate(_listaImagenesLogin.length, (index) {
                  return TarjetaImagenLoginAlumno(
                      imagen: _listaImagenesLogin[index].imagen,
                      idImagen: _listaImagenesLogin[index].idImagen);
                }),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  signIn().then((value) {
                    // Si el inicio de sesión es correcto, navegar a la página de inicio del alumno
                    if (value) {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuInicioAlumno(alumno: widget.alumno)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MenuInicialScreen(rol: roles.ALUMNO, usuario: widget.alumno,)));
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  elevation: 0.0,
                  backgroundColor: const Color(0xFFA8EC77),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontSize: 40.0, color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
