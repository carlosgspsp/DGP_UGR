import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AnadirComprobante extends StatefulWidget {
  String tituloTarea = 'Como poner un microondas';
  String urlImagenPerfilTarea;
  List<CustomCardImage>? pasosTarea = [];
  // Image imagenPerfilTarea;

  AnadirComprobante({
    Key? key,
   required this.tituloTarea,
    required this.urlImagenPerfilTarea,
    this.pasosTarea,
  }) : super(key: key);

  @override
  State<AnadirComprobante> createState() => AnadirComprobanteState();
  
}

class AnadirComprobanteState extends State<AnadirComprobante> {
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
         
        title: Center(child: Text(widget.tituloTarea, style: TextStyle(fontSize: 40, color: Colors.black  ))), //Título de tarea dinámico
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
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
                            backgroundImage:  NetworkImage(widget.urlImagenPerfilTarea),
                            radius: 120,
                          ),
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // Text(widget.tituloTarea,
                  //     textAlign: TextAlign.center, //Centrar título
                  //     style: const TextStyle(
                  //         fontSize: 60, fontWeight: FontWeight.bold)),
                  const Divider(height: 20,
                                thickness: 5,
                                indent: 20,
                                endIndent: 0,
                                color: Colors.black12,),
                  // Text(widget.descripcionTarea,
                  //     style: const TextStyle(fontSize: 55)),
                  // const Divider(color: Colors.black12),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         const Text("FECHA",
                  //             style: TextStyle(
                  //                 fontSize: 55, fontWeight: FontWeight.bold)),
                  //         Text(widget.fechaFinTarea,
                  //             style: const TextStyle(fontSize: 55)),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         const Text("HORA",
                  //             style: TextStyle(
                  //                 fontSize: 55, fontWeight: FontWeight.bold)),
                  //         Text(widget.horaFinTarea,
                  //             style: const TextStyle(fontSize: 55)),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const Text("PASOSsss A SEGUIR",
                      textAlign: TextAlign.center, //Centrar pasos
                      style:
                          TextStyle(fontSize: 55, fontWeight: FontWeight.bold)),

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
                          onPressed: () { //Al presionar cambia de paso
                            setState(() {
                              if (_index > 0) {
                                _index--;
                              }
                            });
                          },
                          child: const Icon(Icons.arrow_back_outlined),
                        ),
                        const SizedBox(width: 500),
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

                  const SizedBox(height: 35),
                  const Divider(height: 20,
                                thickness: 5,
                                indent: 20,
                                endIndent: 0,
                                color: Colors.black12,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                         const Text("COMPLETAR",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontSize: 55, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                           const SizedBox(width: 120),
                          FloatingActionButton(
                          heroTag: 'completada',
                          backgroundColor: const Color(0xFFA8EC77),
                          elevation: 0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.check, color: Colors.black, size: 50.0,),
                        ),
                        ],
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
