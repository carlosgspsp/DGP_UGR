import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mysql1/mysql1.dart';
import '../enumerators/ventanas_origen';

class EditarComandaScreen extends StatefulWidget {
  String tituloComanda = 'Como poner un microondas';
  String descripcionComanda =
      'Con esta tarea aprenderemos a poner un microondas';
  // String fechaFinTarea = '16/11/2022';
  // String horaFinTarea = '12:30';
  String urlImagenPerfilComanda;
  String idComanda;
  // List<CustomCardImage>? pasosTarea = [
  //   CustomCardImage(
  //       imageUrl:
  //           'https://c8.alamy.com/zoomses/9/481a4d4ccdbe4a80be5b640dafa4d101/2bfcd6x.jpg',
  //       cardName: 'Paso 1: Abrir puerta microondas'),
  //   CustomCardImage(
  //       imageUrl:
  //           'https://static.vecteezy.com/system/resources/previews/003/765/882/non_2x/whole-chicken-grilling-in-microwave-oven-color-icon-vector.jpg',
  //       cardName: 'Paso 2: Meter comida en el microondas'),
  //   CustomCardImage(
  //       imageUrl:
  //           'https://c8.alamy.com/zoomses/9/481a4d4ccdbe4a80be5b640dafa4d101/2bfcd6x.jpg',
  //       cardName: 'Paso 3: Cerrar puerta microondas'),
  // ];

  EditarComandaScreen({
    Key? key,
    required this.tituloComanda,
    required this.descripcionComanda,
    // required this.fechaFinTarea,
    // required this.horaFinTarea,
    required this.urlImagenPerfilComanda,
    required this.idComanda,
    // this.pasosTarea,
  }) : super(key: key);

  @override
  State<EditarComandaScreen> createState() => _EditarComandaScreenState();
}

class _EditarComandaScreenState extends State<EditarComandaScreen> {

  // Reference to form widget
  final GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> imageFormKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> thirdFormKey = GlobalKey<FormState>();
  String nombreComanda = '';
  String descripcionComanda = '';
  String url = '';
  

  TextEditingController urlController = TextEditingController();
  TextEditingController urlImagenPerfilController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController nombreComandaController = TextEditingController();
  TextEditingController descripcionComandaController = TextEditingController();
  TextEditingController FechaInicioController =
      TextEditingController(text: '10/10/2022 09:00');
  TextEditingController FechaFinalController =
      TextEditingController(text: '15/10/2022 23:59');

  final Controller _conn = Controller();

  @override
  void dispose() {
    urlController.dispose();
    cardNameController.dispose();
    nombreComandaController.dispose();
    descripcionComandaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nombreComandaController.text = widget.tituloComanda;
    descripcionComandaController.text = widget.descripcionComanda;
    urlImagenPerfilController.text = widget.urlImagenPerfilComanda;
    super.initState();
    urlController.addListener(() {
      setState(() {
        url = urlController.text;
      });
    });
    urlImagenPerfilController.addListener(() {
      setState(() {
        widget.urlImagenPerfilComanda = urlImagenPerfilController.text;
      });
    });
    // cardNameController.addListener(() {
    //   setState(() {
    //     newCardName = cardNameController.text;
    //   });
    // });
    nombreComandaController.addListener(() {
      setState(() {
        nombreComanda = nombreComandaController.text;
      });
    });
    descripcionComandaController.addListener(() {
      setState(() {
        descripcionComanda = descripcionComandaController.text;
      });
    });
  }

  Future<String?> openDialogImage() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Cambiar imagen de perfil de la tarea'),
            content: Form(
              key: imageFormKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una URL';
                  }
                  return null;
                },
                keyboardType: TextInputType.url,
                controller: urlImagenPerfilController,
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
                  if (imageFormKey.currentState!.validate()) {
                    Navigator.of(context).pop(urlImagenPerfilController.text);
                  }
                },  
                child: const Text('Aceptar'),
              ),
            ],
          ));

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
          "EDITAR COMANDA",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
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
                    CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          NetworkImage(widget.urlImagenPerfilComanda),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListaClasesScreen(
                                      ventanaOrigen:
                                          ventanasOrigen.CREAR_EDITAR)));
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

              Form(
                  key: secondFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nombreComandaController,
                          decoration: const InputDecoration(
                            labelText: 'NOMBRE:',
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
                          controller: descripcionComandaController,
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
                              return 'POR FAVOR, INGRESE LA DESCRIPCIÓN DE LA TAREA';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),

                        const SizedBox(height: 50),

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
                                        builder: (context) => VerComandaScreen(
                                              descripcionComanda:
                                                  descripcionComandaController
                                                      .text,
                                              // fechaFinTarea:
                                              //     FechaFinalController.text,
                                              // horaFinTarea:
                                              //     FechaFinalController.text,
                                              tituloComanda:
                                                  nombreComandaController.text,
                                              urlImagenPerfilComanda:
                                                  widget.urlImagenPerfilComanda,
                                              // pasosTarea: widget.pasosTarea,
                                            )),
                                  );
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
                                  "PREVISUALIZAR COMANDA",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 190,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (secondFormKey.currentState!.validate()) {
                                      // Actualizar la información de la comanda en la base de datos
                                      _conn.editarComandaMaterial(
                                        widget.idComanda,
                                        nombreComandaController.text,
                                        descripcionComandaController.text,
                                        urlImagenPerfilController.text,
                                      ).then((value) => print(value));
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
