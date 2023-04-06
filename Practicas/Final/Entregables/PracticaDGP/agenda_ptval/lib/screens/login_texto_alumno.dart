import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/menu_inicial_screen.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../enumerators/roles';
import 'package:agenda_ptval/datab_controller/controller.dart';

class LoginAlumnoTexto extends StatefulWidget {
  final Alumno alumno;

  LoginAlumnoTexto({
    Key? key,
    required this.alumno,
  }) : super(key: key);

  @override
  State<LoginAlumnoTexto> createState() => _LoginAlumnoTextoState();
}

class _LoginAlumnoTextoState extends State<LoginAlumnoTexto> {
  final TextEditingController _passwdAlumnoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Controller controlador = new Controller();

  Future<bool> signIn() async {
    String passwdAlumno = _passwdAlumnoController.text;
    bool esCorrecta = false;

    if (_formKey.currentState!.validate()) {
      // Consultar a la base de datos si la contraseña es correcta
      String query = "SELECT * FROM `alumno`";
      var resultado_query = await controlador.queryBD(query, []);

      print(passwdAlumno);
      if (passwdAlumno == widget.alumno.password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('¡CONTRASEÑA CORRECTA!', style: TextStyle(fontSize: 30)),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
        esCorrecta = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('¡CONTRASEÑA INCORRECTA!', style: TextStyle(fontSize: 30)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
        esCorrecta = false;
      }
    }

    // Provisonalmente, siempre devuelve true
    return esCorrecta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("CONTRASEÑA",
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
      body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 200.0,
                  backgroundImage: NetworkImage(widget.alumno.fotoPerfil),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),
                Text(
                  "${widget.alumno.nombre} ${widget.alumno.apellidos}"
                      .toUpperCase(),
                  style: const TextStyle(fontSize: 50.0),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 200.0),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GenTextFormField(
                    controller: _passwdAlumnoController,
                    hintText: "CONTRASEÑA",
                    icon: Icons.lock,
                    obscureText: true,
                    inputType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    signIn().then((value) {
                      // Si el inicio de sesión es correcto, navegar a la página de inicio del alumno
                      if (value) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuInicioAlumno(alumno: widget.alumno)));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuInicialScreen(
                                    rol: roles.ALUMNO,
                                    usuario: widget.alumno)));
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
          )),
    );
  }
}
