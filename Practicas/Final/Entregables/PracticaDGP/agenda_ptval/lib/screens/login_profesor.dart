import 'package:agenda_ptval/models/profesor.dart';
import 'package:agenda_ptval/screens/home_todos_screen.dart';
import 'package:agenda_ptval/screens/menu_inicial_screen.dart';
import 'package:agenda_ptval/widgets/gen_text_form_field.dart';
import 'package:flutter/material.dart';
import '../enumerators/roles';
import 'package:agenda_ptval/datab_controller/controller.dart';

class LoginProfeScreen extends StatefulWidget {
  final Enum rol;
  Profesor? Profe;

  LoginProfeScreen({required this.rol, Key? key}) : super(key: key);

  @override
  State<LoginProfeScreen> createState() => _LoginProfeScreenState();
}

class _LoginProfeScreenState extends State<LoginProfeScreen> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Controller controlador = new Controller();

  signIn() {
    final form = _formKey.currentState;
    String user = _controllerUser.text;
    String pass = _controllerPass.text;

    if (form!.validate()) {
      // Supongo que aquí habrá que hacer una llamada a la base de datos

    }
    var contra;

    controlador.getProfe(user).then((value) {
      for (var row in value) {
        if (row['contrasennia'] != "null") {
          contra = row['contrasennia'];
        }
      }

      if (contra == pass) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuInicialScreen(
                    rol: widget.rol,
                    usuario: widget.Profe,
                  )),
        );
      }
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
            "INICIO DE SESIÓN",
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          backgroundColor: const Color(0xFF1BDAF1),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      AssetImage('assets/images/orden_sjd_logo.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 200.0),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: const BoxDecoration(
                      color: Color(0xFF1BDAF1),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GenTextFormField(
                            controller: _controllerUser,
                            hintText: 'Nombre de usuario',
                            icon: Icons.person,
                            obscureText: false,
                            inputType: TextInputType.name,
                          ),
                          const SizedBox(height: 20.0),
                          GenTextFormField(
                            controller: _controllerPass,
                            hintText: 'Contraseña',
                            icon: Icons.lock,
                            obscureText: true,
                            inputType: TextInputType.text,
                          ),
                        ]),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => signIn(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    elevation: 0.0,
                    backgroundColor: const Color(0xFF1BDAF1),
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
          ),
        ));
  }
}
