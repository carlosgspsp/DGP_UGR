import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/screens/DescargarComandas.dart';
import 'package:agenda_ptval/screens/ver_tarea_pasos.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_ptval/models/tarea.dart';
import 'package:image_picker/image_picker.dart';
import 'anadir_comprobante.dart';

class VerTareaScreen extends StatefulWidget {
  Tarea tarea;

  // Image imagenPerfilTarea;

  VerTareaScreen({
    Key? key,
    required this.tarea,
  }) : super(key: key);

  @override
  State<VerTareaScreen> createState() => _VerTareaScreenState();
}

class _VerTareaScreenState extends State<VerTareaScreen> {
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
        title: Text(
          widget.tarea.titulo,
          style: const TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
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
          height: 1200,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen de perfil de la tarea. Dentro de Stack para que se ajuste al tamaño del CircleAvatar
                  Stack(alignment: AlignmentDirectional.center, children: [
                    CircleAvatar(
                      radius: 124,
                      backgroundColor: const Color(0xFFA8EC77),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.tarea.urlImagenPerfil),
                        radius: 120,
                      ),
                    ),
                  ]),

                  // Text(widget.tituloTarea,
                  //     textAlign: TextAlign.center, //Centrar título
                  //     style: const TextStyle(
                  //         fontSize: 60, fontWeight: FontWeight.bold)),

                  Text(widget.tarea.descripcion,
                      style: const TextStyle(fontSize: 55),
                      textAlign: TextAlign.center),

                  //Botón para mostrar los pasos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 270,
                        height: 110,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TareaPasosScreen(
                                        tituloTarea: widget.tarea.titulo,
                                        pasosTarea: widget.tarea.pasos,
                                      )),
                            );
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
                          child: const Text(
                            "MOSTRAR\nPASOS TAREA",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black12),
                  //fechas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("FECHA INICIO",
                              style: TextStyle(
                                  fontSize: 55, fontWeight: FontWeight.bold)),
                          Text(widget.tarea.fechaIni,
                              style: const TextStyle(fontSize: 40)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("FECHA FIN",
                              style: TextStyle(
                                  fontSize: 55, fontWeight: FontWeight.bold)),
                          Text(widget.tarea.fechaFin,
                              style: const TextStyle(fontSize: 40)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  const Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black12,
                  ),
                  //Botón completar tarea
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 390,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AnadirComprobante(tarea: widget.tarea)),
                            );
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
                                children: const [
                                  Text(
                                    "COMPLETAR TAREA ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 35),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     pickImage();
                  //   },
                  //   style: ButtonStyle(
                  //     elevation: MaterialStateProperty.all(0),
                  //     backgroundColor: MaterialStateProperty.all<Color>(
                  //         const Color(0xFFA8EC77)),
                  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(18.0),
                  //         // side: const BorderSide(width: 2.0),
                  //       ),
                  //     ),
                  //   ),
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: Text("SUBIR COMPROBANTE",
                  //         style: TextStyle(fontSize: 60)),
                  //   ),
                  // ),

                  // const SizedBox(height: 35),

                  // if (_imagenComprobante != null)
                  //   InkWell(
                  //       child: Container(
                  //         height: 500,
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image: FileImage(File(_imagenComprobante!.path)),
                  //             fit: BoxFit.cover,
                  //           ),
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         // Se usa el plugin image_viewer para ver la imagen en pantalla completa
                  //         showImageViewer(context,
                  //             FileImage(File(_imagenComprobante!.path)));
                  //       })
                ]),
          ),
        ),
      ))),
    );
  }
}
