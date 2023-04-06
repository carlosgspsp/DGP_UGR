import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SeleccionMenuScreen extends StatefulWidget {
  String nombreAlumno = 'Nombre Alumno';
  String urlImagenPerfilAlumno = 'assets/images/student.png';

  List<String>? menus2 = ["menu 1", "menu 2"];
  // Image imagenPerfilTarea;

  SeleccionMenuScreen({
    Key? key,
    required this.nombreAlumno,
    required this.urlImagenPerfilAlumno,
  }) : super(key: key);

  @override
  State<SeleccionMenuScreen> createState() => SeleccionMenuScreenState();
}

class SeleccionMenuScreenState extends State<SeleccionMenuScreen> {
  int _index = 0;
  final _picker = ImagePicker();
  XFile? _imagenComprobante;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Center(
            child: Text("ELEGIR MENÚ ALUMNO", style: TextStyle(fontSize: 50))),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body:
          //  ListView.builder(
          //     itemBuilder: (builder, index) {
          //       Map data = widget.menus[index];
          //       return ListTile(
          //         title: Text("${data['name']}"),
          //         subtitle: Text("${data['type']}"),

          //       );
          //     },
          //     itemCount: widget.menus.length,
          //   ),
          SingleChildScrollView(
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
                  Row(
                    //alinear foto con nombre al inicio
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          // Imagen de perfil de la tarea. Dentro de Stack para que se ajuste al tamaño del CircleAvatar
                          Stack(
                              alignment: AlignmentDirectional.topStart,
                              children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage(widget.urlImagenPerfilAlumno),
                                ),
                              ]),
                        ],
                      ),
                      Column(
                        children: [
                          //Nombre del niño
                          Text(widget.nombreAlumno,
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)),
                          const Divider(color: Colors.black12),
                        ],
                      ),
                    ],
                  ),

                  const Divider(color: Colors.black12),
                  const Text("Menús del alumno",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),
                  //Menús
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("  Menú 1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("  (Sin Lactosa)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("Menú 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("  (Sin Gluten)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("Menú 3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Color(0xFFA8EC77))),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("  (Sin verduras)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  backgroundColor: Color(0xFFA8EC77))),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("Menú 4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("  (Sin Carnes)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(" Menú 5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("  (Sin Marisco)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),
                  const Divider(color: Colors.black12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFA8EC77)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "GUARDAR",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFA8EC77)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "CANCELAR",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ))),
    );
  }
}
