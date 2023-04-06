import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:agenda_ptval/models/tarea.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../datab_controller/controller.dart';

class AnadirComprobante extends StatefulWidget {
  Tarea tarea;
  AnadirComprobante({
    required this.tarea,
    super.key,
  });

  @override
  State<AnadirComprobante> createState() => AnadirComprobanteState();
}

class AnadirComprobanteState extends State<AnadirComprobante> {
  // Conexión a la base de datos
  final Controller _conn = Controller();

  int _index = 0;
  final _picker = ImagePicker();
  XFile? _imagenComprobante;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = XFile(image.path);
      setState(() {
        _imagenComprobante = imageTemp;
        print(_imagenComprobante!.path);
      });
    } on PlatformException catch (e) {
      print('Error al seleccionar la imagen: $e');
    }
  }

  Future<void> aniadeComprobante(String id, String pathimagen) async {
    _conn.pushComprobante(id, pathimagen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.tarea.titulo,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black))), //Título de tarea dinámico
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black, //Color corregido a negro
            size: 40,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Card(
        // elevation: 5.0,
        // clipBehavior: Clip.antiAlias,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(24),
        // ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen de perfil de la tarea. Dentro de Stack para que se ajuste al tamaño del CircleAvatar
                  Stack(alignment: AlignmentDirectional.center, children: [
                    CircleAvatar(
                      radius: 124,
                      backgroundColor: Color(0xFFA8EC77),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.tarea.urlImagenPerfil),
                        radius: 120,
                      ),
                    ),
                  ]),

                  const SizedBox(height: 20),
                  const Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black12,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFA8EC77)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side: const BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("SUBIR COMPROBANTE",
                          style: TextStyle(fontSize: 60, color: Colors.black)),
                    ),
                  ),

                  const SizedBox(height: 35),

                  if (_imagenComprobante != null)
                    InkWell(
                        child: Container(
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(_imagenComprobante!.path)),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onTap: () {
                          // Se usa el plugin image_viewer para ver la imagen en pantalla completa
                          showImageViewer(context,
                              FileImage(File(_imagenComprobante!.path)));
                        }),

                  const Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black12,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Antes de salir de la pantalla, almacenar la imagen en la base de datos

                            aniadeComprobante(widget.tarea.idTarea,
                                widget.tarea.urlComprobante);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFA8EC77)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(width: 2.0),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "GUARDAR",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 50.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ))),
    );
  }
}
