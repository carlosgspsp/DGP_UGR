import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/gen_text_form_field.dart';
import '../enumerators/tipos_login';
import 'package:flutter/material.dart';

class EditarAlumno extends StatefulWidget {
  Alumno? alumno;
  EditarAlumno({
    Key? key,
    required this.alumno
  }) : super(key: key);

  @override
  State<EditarAlumno> createState() => _EditarAlumnoState();
}

class _EditarAlumnoState extends State<EditarAlumno> {

  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerApellidos = TextEditingController();
  final TextEditingController _controllerDNI = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _value = "TEXTO";
  final Controller _conn = Controller();

  @override
  void initState() {
    super.initState();
    _controllerNombre.text = widget.alumno!.nombre;
    _controllerApellidos.text = widget.alumno!.apellidos;
    _controllerDNI.text = widget.alumno!.dni;
    _controllerEmail.text = widget.alumno!.correo;
    _controllerPassword.text = widget.alumno!.password;
    // _value = widget.alumno!.tipoLogin.toString();
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
          "EDITAR ALUMNO",
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
                  inputType: TextInputType.name
                ),
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
                  inputType: TextInputType.name
                ),
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
                  inputType: TextInputType.emailAddress
                ),
                const SizedBox(
                  height: 20,
                ),
                // DropdownButton para seleccionar el tipo de alumno
                const Text(
                  "Tipo de login para el alumno",
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
                  style: const TextStyle(fontSize: 40, color: const Color(0xFF1BDAF1)),
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
                  inputType: TextInputType.name
                ),

                const SizedBox(
                  height: 20,
                ),
                // Botón para crear el alumno
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_value == "TEXTO") {
                        widget.alumno!.tipoLogin = tiposLogin.TEXTO;
                      } else if (_value == "IMAGEN") {
                        widget.alumno!.tipoLogin = tiposLogin.IMAGENES;
                      } else {
                        widget.alumno!.tipoLogin = tiposLogin.PATRON;
                      }

                      // Asignar los valores introducidos en el formulario al alumno
                      widget.alumno!.nombre = _controllerNombre.text;
                      widget.alumno!.apellidos = _controllerApellidos.text;
                      widget.alumno!.correo = _controllerEmail.text;
                      widget.alumno!.password = _controllerPassword.text;

                      // Editar alumno en la base de datos
                      await _conn.editarAlumno(widget.alumno!);

                      // Cuadro de diálogo para confirmar que se quieren hacer los cambios el alumno
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "¿Aplicar los cambios realizados al alumno?",
                                style: TextStyle(fontSize: 40),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Aplicar",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Cancelar",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                )
                              ],
                            );
                          });
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
                    'EDITAR ALUMNO',
                    style: TextStyle(fontSize: 40.0, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}