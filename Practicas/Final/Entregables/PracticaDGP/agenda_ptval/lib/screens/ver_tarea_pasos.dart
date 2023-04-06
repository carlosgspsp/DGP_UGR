import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/screens/DescargarComandas.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TareaPasosScreen extends StatefulWidget {
  String tituloTarea = 'Como poner un microondas';

  List<CustomCardImage>? pasosTarea;
  // Image imagenPerfilTarea;

  TareaPasosScreen({
    Key? key,
    required this.tituloTarea,
    required this.pasosTarea,
  }) : super(key: key);

  @override
  State<TareaPasosScreen> createState() => _TareaPasosScreenState();
}

class _TareaPasosScreenState extends State<TareaPasosScreen> {
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
        title: Center(
            child: Text(widget.tituloTarea,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black))), //Título de tarea dinámico
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            //flecha para atrás
            Icons.arrow_back,
            size: 40,
            color: Colors.black, //Color corregido a negro
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
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.pasosTarea![_index],

                  const SizedBox(height: 35),

                  if (widget.pasosTarea != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.large(
                          heroTag: 'izquierda',
                          backgroundColor: const Color(0xFFA8EC77),
                          elevation: 0,
                          onPressed: () {
                            //Al presionar cambia de paso
                            setState(() {
                              if (_index > 0) {
                                _index--;
                              }
                            });
                          },
                          child: const Icon(Icons.arrow_back_outlined),
                        ),
                        const SizedBox(width: 550),
                        FloatingActionButton.large(
                          heroTag: 'derecha',
                          backgroundColor: const Color(0xFFA8EC77),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              if (_index < widget.pasosTarea!.length - 1) {
                                _index++;
                              }
                            });
                          },
                          child: const Icon(Icons.arrow_forward_outlined),
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
