import 'package:agenda_ptval/datab_controller/controller.dart';
import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../enumerators/ventanas_origen';

class CrearComandaScreen extends StatefulWidget {
  String tituloComanda = 'Crear Tarea';
  String descripcionComanda = 'Nose';
  String tipoComanda = 'Material';
  String? urlImagenPerfilComanda;
  Enum ventanaOrigen = ventanasOrigen.CREAR_EDITAR;
  late Alumno? alumnoAsignado = null;
  CrearComandaScreen({Key? key}) : super(key: key);

  @override
  State<CrearComandaScreen> createState() => _CrearComandaScreenState();
}

class _CrearComandaScreenState extends State<CrearComandaScreen> {
  // Conexión a la base de datos MySQL
  final Controller _conn = Controller();

  final GlobalKey<FormState> _formKeyInfoComanda = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyImagenComanda = GlobalKey<FormState>();
  final TextEditingController _urlImagenPerfilComandaController =
      TextEditingController();
  final TextEditingController _nombreComandaController =
      TextEditingController();
  final TextEditingController _descripcionComandaController =
      TextEditingController();

  Future<String?> openDialogImage() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Cambiar imagen de perfil de la comanda'),
            content: Form(
              key: _formKeyImagenComanda,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una URL';
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
                controller: _urlImagenPerfilComandaController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: 'Ingrese la URL de la imagen'),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKeyImagenComanda.currentState!.validate()) {
                    Navigator.pop(
                        context, _urlImagenPerfilComandaController.text);
                  }
                },
                child: const Text('Aceptar'),
              ),
            ],
          ));

  Future<void> _seleccionarAlumno(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListaClasesScreen(
                  ventanaOrigen: widget.ventanaOrigen,
                )));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    /*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));*/
    setState(() {
      if (result != null) widget.alumnoAsignado = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("CREAR COMANDA",
                style: TextStyle(fontSize: 50, color: Colors.black))),
        backgroundColor: const Color(0xFF1BDAF1),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),

              // Imagen de perfil de la tarea. Dentro de Stack para que se ajuste al tamaño del CircleAvatar
              InkWell(
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    if (widget.urlImagenPerfilComanda == null)
                      const CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            AssetImage('assets/images/no_image.jpeg'),
                        backgroundColor: Colors.transparent,
                      )
                    else
                      CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(widget.urlImagenPerfilComanda!),
                        backgroundColor: Colors.transparent,
                      ),
                  ]),
                  onTap: () async {
                    final urlPerfil = await openDialogImage();

                    if (urlPerfil == null) return;

                    setState(() {
                      widget.urlImagenPerfilComanda = urlPerfil;
                    });
                  }),

              const SizedBox(height: 20),

              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          _seleccionarAlumno(context);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF1BDAF1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "ASIGNAR ALUMNO",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                (widget.alumnoAsignado != null)
                    ? '${(widget.alumnoAsignado)!.nombre} ${(widget.alumnoAsignado)!.apellidos}'
                    : "Alumno no asignado",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Form(
                  key: _formKeyInfoComanda,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreComandaController,
                          decoration: const InputDecoration(
                            labelText: 'Titulo:',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'INTRODUZCA UN TITULO',
                            border: OutlineInputBorder(),
                          ),
                          // initialValue: 'Como poner un microondas',
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'POR FAVOR, INGRESE EL TITULO DE LA TAREA';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        TextFormField(
                          controller: _descripcionComandaController,
                          decoration: const InputDecoration(
                            labelText: 'DESCRIPCIÓN:',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'INTRODUZCA UNA DESCRIPCIÓN',
                            border: OutlineInputBorder(),
                          ),
                          // initialValue: 'Tarea para aprender a usar un microondas',
                          style: const TextStyle(fontSize: 30),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'POR FAVOR, INGRESE LA DESCRIPCIÓN DE LA COMANDA';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                        const SizedBox(height: 50),
                        const Text('Tipo de comanda:',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          iconEnabledColor: const Color(0xFF1BDAF1),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFF1BDAF1)),
                              ),
                              errorStyle: const TextStyle(fontSize: 20.0)),
                          value: widget.tipoComanda,
                          items: const [
                            DropdownMenuItem(
                              value: 'Material',
                              child: Text('Material',
                                  style: TextStyle(fontSize: 20)),
                            ),
                            DropdownMenuItem(
                              value: 'Menú',
                              child:
                                  Text('Menú', style: TextStyle(fontSize: 20)),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              widget.tipoComanda = value.toString();
                            });
                          },
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 190,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_formKeyInfoComanda.currentState!.validate()) {
                                      // Insertar en la base de datos la nueva comanda
                                      if (widget.tipoComanda == 'Material') {
                                        _conn.insertarComandaMaterial(
                                          _nombreComandaController.text,
                                          _descripcionComandaController.text,
                                          _urlImagenPerfilComandaController.text,
                                        ).then((value) => print(value));
                                      }
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF1BDAF1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(width: 2.0),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "GUARDAR",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 190,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.maybePop(context);
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF1BDAF1)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(width: 2.0),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "CANCELAR",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
