import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/gen_text_form_field.dart';
import '../enumerators/tipos_login';
import 'package:flutter/material.dart';

class CrearAlumno extends StatefulWidget {
  CrearAlumno({Key? key}) : super(key: key);

  @override
  State<CrearAlumno> createState() => _CrearAlumnoState();
}

class _CrearAlumnoState extends State<CrearAlumno> {
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerApellidos = TextEditingController();
  final TextEditingController _controllerDNI = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _value = "TEXTO";
  final Controller _conn = Controller();

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
            "CREAR ALUMNO",
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          backgroundColor: const Color(0xFF1BDAF1),
          elevation: 0,
        ),
        // Formulario para introducir los datos del alumno
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nombre",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenTextFormField(
                      controller: _controllerNombre,
                      hintText: 'Nombre Alumno',
                      icon: Icons.person,
                      obscureText: false,
                      inputType: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Apellidos",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenTextFormField(
                      controller: _controllerApellidos,
                      hintText: 'Apellidos Alumno',
                      icon: Icons.person,
                      obscureText: false,
                      inputType: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "DNI",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenTextFormField(
                      controller: _controllerDNI,
                      hintText: 'DNI Alumno',
                      icon: Icons.document_scanner,
                      obscureText: false,
                      inputType: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenTextFormField(
                      controller: _controllerEmail,
                      hintText: 'Email Alumno',
                      icon: Icons.mail,
                      obscureText: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  // DropdownButton para seleccionar el tipo de alumno
                  const Text(
                    "Tipo de Login para el alumno",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    value: _value,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        fontSize: 40, color: const Color(0xFF1BDAF1)),
                    underline: Container(
                      height: 2,
                      color: const Color(0xFF1BDAF1),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _value = newValue!;
                      });
                    },
                    items: <String>['TEXTO', 'IMAGEN', 'PATRÓN']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Contraseña",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GenTextFormField(
                      controller: _controllerPassword,
                      hintText: 'Contraseña Alumno',
                      icon: Icons.lock,
                      obscureText: false,
                      inputType: TextInputType.name),

                  const SizedBox(
                    height: 20,
                  ),
                  // Botón para crear el alumno
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Enum tipoLogin = tiposLogin.TEXTO;
                        if (_value == "TEXTO") {
                          tipoLogin = tiposLogin.TEXTO;
                        } else if (_value == "IMAGEN") {
                          tipoLogin = tiposLogin.IMAGENES;
                        } else if (_value == "PATRÓN") {
                          tipoLogin = tiposLogin.PATRON;
                        }

                        // Crear objeto alumno
                        Alumno alumno = Alumno(
                          nombre: _controllerNombre.text,
                          apellidos: _controllerApellidos.text,
                          dni: _controllerDNI.text,
                          correo: _controllerEmail.text,
                          tipoLogin: tipoLogin,
                          password: _controllerEmail.text,
                          fotoPerfil: 'assets/images/student.png',
                          autorizado: 1,
                          //tipoAlumno: 1
                        );

                        // Añadir alumno en la base de datos
                        _conn
                            .insertarAlumno(alumno)
                            .then((value) => print(value));

                        Navigator.pop(context);
                      }
                    },
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
                      'CREAR ALUMNO',
                      style: TextStyle(fontSize: 40.0, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
