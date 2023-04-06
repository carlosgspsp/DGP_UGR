import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../enumerators/ventanas_origen';
import '../models/alumno.dart';
import '../models/tarea.dart';

class EditarTareasScreen extends StatefulWidget {
  String tituloTarea = 'Como poner un microondas';
  String descripcionTarea = 'Con esta tarea aprenderemos a poner un microondas';
  String fechaFinTarea = '16/11/2022';
  String urlImagenPerfilTarea;
  Tarea tarea;
  Alumno? alumnoAsignado;
  Enum ventanaOrigen = ventanasOrigen.CREAR_EDITAR;
  List<CustomCardImage>? pasosTarea = []; 

  EditarTareasScreen({
    Key? key,
    required this.tituloTarea,
    required this.descripcionTarea,
    required this.fechaFinTarea,
    required this.urlImagenPerfilTarea,
    required this.tarea,
    required this.alumnoAsignado,
    this.pasosTarea,
  }) : super(key: key);

  @override
  State<EditarTareasScreen> createState() => _EditarTareasScreenState();
}

class _EditarTareasScreenState extends State<EditarTareasScreen> {
  int _index = 0;
  DateTime? fechaInicio = null;
  DateTime? fechaFinal = null;
  TimeOfDay? horaInicio = null;
  TimeOfDay? horaFinal = null;
  Controller controlador = Controller();

  Map<String, dynamic> _tarea = {
    'titulo': 'Tarea 1',
    'descripcion': 'Descripción de la tarea 1',
    'pasos': [],
  };

  final List<CustomCardImageEditable> _listOfSteps = [];

  // Reference to form widget
  final GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> thirdFormKey = GlobalKey<FormState>();
  String nombreTarea = '';
  String descripcionTarea = '';
  String url = '';
  String? newCardName;
  Map<String, String> _newStepData = {
    'url': '',
    'cardName': '',
  };

  TextEditingController urlController = TextEditingController();
  TextEditingController urlImagenPerfilController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController nombreTareaController =
      TextEditingController(text: 'COMO PONER UN MICROONDAS');
  TextEditingController descripcionTareaController =
      TextEditingController(text: 'TAREA PARA APRENDER A PONER UN MICROONDAS');
  TextEditingController FechaInicioController =
      TextEditingController(text: '10/10/2023 09:00');
  TextEditingController FechaFinalController =
      TextEditingController(text: '15/10/2022 23:59');

  @override
  void dispose() {
    urlController.dispose();
    cardNameController.dispose();
    nombreTareaController.dispose();
    descripcionTareaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (var value in widget.pasosTarea!){
      _listOfSteps.add(CustomCardImageEditable(imageUrl: value.imageUrl, cardName: value.cardName, idPaso: value.idPaso,));
    }

    fechaInicio = DateTime.parse(widget.tarea.fechaIni);
    fechaFinal = DateTime.parse(widget.tarea.fechaFin);

    urlImagenPerfilController =
        TextEditingController(text: widget.tarea.urlImagenPerfil);
    nombreTareaController = TextEditingController(text: widget.tarea.titulo);
    descripcionTareaController =
        TextEditingController(text: widget.tarea.descripcion);
    FechaInicioController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(fechaInicio!));
    FechaFinalController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(fechaFinal!));

        

    urlController.addListener(() {
      setState(() {
        url = urlController.text;
      });
    });
    urlImagenPerfilController.addListener(() {
      setState(() {
        widget.urlImagenPerfilTarea = urlImagenPerfilController.text;
      });
    });
    cardNameController.addListener(() {
      setState(() {
        newCardName = cardNameController.text;
      });
    });
    nombreTareaController.addListener(() {
      setState(() {
        nombreTarea = nombreTareaController.text;
      });
    });
    descripcionTareaController.addListener(() {
      setState(() {
        descripcionTarea = descripcionTareaController.text;
      });
    });
  }

  Future<String?> openDialogImage() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Cambiar imagen de perfil de la tarea'),
            content: TextField(
              keyboardType: TextInputType.url,
              controller: urlImagenPerfilController,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Ingrese la URL de la imagen'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(urlImagenPerfilController.text),
                child: const Text('Aceptar'),
              ),
            ],
          ));

  Future<int?> openDialogRemoveStep() => showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Escoger el paso a eliminar'),
            content: DropdownButton(
              items: _listOfSteps.map((CustomCardImageEditable item) {
                return DropdownMenuItem(
                  value: _listOfSteps.indexOf(item),
                  child: Text(item.cardName),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  _index = value!;
                  print('Indice del paso a eliminar: $_index');
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(_index),
                child: const Text('Aceptar'),
              ),
            ],
          ));

  Future<Map<String, String>?> openDialogAddStep() =>
      showDialog<Map<String, String>>(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Añadir nuevo paso'),
                content: Form(
                  key: firstFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: urlController,
                        decoration: const InputDecoration(
                            hintText: 'Ingrese la URL de la imagen'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese una URL';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cardNameController,
                        decoration: const InputDecoration(
                            hintText: 'Ingrese la descripción del paso'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese una descripción';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (firstFormKey.currentState!.validate()) {
                                  _newStepData['url'] = url;
                                  _newStepData['cardName'] = newCardName!;
                                  Navigator.of(context).pop(_newStepData);
                                }
                              },
                              child: const Text('Aceptar'),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));

  Future<DateTime?> pickDate(fechaInicial) => showDatePicker(
      context: context,
      initialDate: fechaInicial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime(horaInicial) =>
      showTimePicker(context: context, initialTime: horaInicial);

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

  Future<void> actualizarTarea() async {
    String query =
        " UPDATE `tarea` SET Titulo = ?, Descripcion = ?, URL_foto = ?, Fecha_fin = ?, Fecha_ini = ?  WHERE ID_tarea = ?";
    List<String> valores = [
      nombreTareaController.text,
      descripcionTareaController.text,
      urlImagenPerfilController.text,
      fechaFinal.toString(),
      fechaInicio.toString(),
      widget.tarea.idTarea
    ];
    var resultado_query = await controlador.queryBD(query, valores);
    print("Resultado Update Editar tareas: ${resultado_query}");
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
          "EDITAR TAREA",
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
                          NetworkImage(widget.urlImagenPerfilTarea),
                      backgroundColor: Colors.transparent,
                    ),
                  ]),
                  onTap: () async {
                    final urlPerfil = await openDialogImage();

                    if (urlPerfil == null) return;

                    setState(() {
                      widget.urlImagenPerfilTarea = urlPerfil;
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
                  key: thirdFormKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  var fechaInicial;
                                  var horaInicial;

                                  if (fechaInicio == null) {
                                    fechaInicial = DateTime.now();
                                  } else {
                                    fechaInicial = fechaInicio;
                                  }
                                  final fecha = await pickDate(fechaInicial);
                                  if (fecha == null) return;

                                  if (horaInicio == null) {
                                    horaInicial = TimeOfDay.now();
                                  } else {
                                    horaInicial = horaInicio;
                                  }
                                  final hora = await pickTime(horaInicial);
                                  if (hora == null) return;

                                  var df = DateFormat("h:mm a");
                                  var dt = df.parse(hora.format(context));

                                  final nuevaFecha = DateTime(
                                    fecha.year,
                                    fecha.month,
                                    fecha.day,
                                  );

                                  fechaInicio = nuevaFecha;

                                  final nuevahora = TimeOfDay(
                                      hour: hora.hour, minute: hora.minute);

                                  horaInicio = nuevahora;

                                  FechaInicioController.text =
                                      "${DateFormat('dd/MM/yyyy').format(fecha)}  ${DateFormat('HH:mm').format(dt)}";
                                },
                                controller: FechaInicioController,

                                decoration: const InputDecoration(
                                  labelText: 'FECHA INICIO:',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'INTRODUZCA UNA FECHA',
                                  border: OutlineInputBorder(),
                                ),
                                // initialValue: 'Como poner un microondas',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'POR FAVOR, INGRESE LA FECHA DE INICIO';
                                  }

                                  if (fechaFinal != null) {
                                    if (fechaInicio!.isAfter(fechaFinal!)) {
                                      return 'LA FECHA INICIAL ES POSTERIOR A LA FECHA FINAL';
                                    } else if (fechaInicio!
                                        .isAtSameMomentAs(fechaFinal!)) {
                                      if (horaFinal != null) {
                                        if (horaInicio!.hour >
                                            horaFinal!.hour) {
                                          return 'LA FECHA INICIAL ES POSTERIOR A LA FECHA FINAL';
                                        } else if (horaInicio!.hour ==
                                            horaFinal!.hour) {
                                          if (horaInicio!.minute >
                                              horaFinal!.minute) {
                                            return 'LA FECHA INICIAL ES POSTERIOR A LA FECHA FINAL';
                                          }
                                        }
                                      }
                                    }
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());

                                  var fechaInicial;
                                  var horaInicial;

                                  if (fechaInicio == null) {
                                    fechaInicial = DateTime.now();
                                  } else {
                                    fechaInicial = fechaInicio;
                                  }
                                  final fecha = await pickDate(fechaInicial);
                                  if (fecha == null) return;

                                  if (horaInicio == null) {
                                    horaInicial = TimeOfDay.now();
                                  } else {
                                    horaInicial = horaInicio;
                                  }
                                  final hora = await pickTime(horaInicial);
                                  if (hora == null) return;

                                  var df = DateFormat("h:mm a");
                                  var dt = df.parse(hora.format(context));

                                  final nuevaFecha = DateTime(
                                    fecha.year,
                                    fecha.month,
                                    fecha.day,
                                  );

                                  fechaFinal = nuevaFecha;

                                  final nuevahora = TimeOfDay(
                                      hour: hora.hour, minute: hora.minute);

                                  horaFinal = nuevahora;

                                  FechaFinalController.text =
                                      "${DateFormat('dd/MM/yyyy').format(fecha)}  ${DateFormat('HH:mm').format(dt)}";
                                },
                                controller: FechaFinalController,

                                decoration: const InputDecoration(
                                  labelText: 'FECHA FINAL:',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'INTRODUZCA UNA FECHA',
                                  border: OutlineInputBorder(),
                                ),
                                // initialValue: 'Como poner un microondas',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'POR FAVOR, INGRESE LA FECHA FINAL';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      ]))),

              Form(
                  key: secondFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nombreTareaController,
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
                          controller: descripcionTareaController,
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

                        const SizedBox(height: 55),

                        // CustomCardImageEditable(
                        //   imageUrl: url,
                        //   cardName: 'Paso 1: Abrir puerta del microondas'
                        // ),

                        Row(
                          children: [
                            const Text(
                              'PASOS:',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 200),
                            Container(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final _newStep = await openDialogAddStep();

                                  if (_newStep == null) return;

                                  setState(() {
                                    CustomCardImageEditable newStep =
                                        CustomCardImageEditable(
                                      imageUrl: _newStep['url']!,
                                      cardName: _newStep['cardName']!,
                                      idPaso: 'pa_${DateTime.now()}',
                                    );
                                    _listOfSteps.add(newStep);
                                  });
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
                                  "AÑADIR PASO",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final index = await openDialogRemoveStep();
                                  if (index == null) return;
                                  setState(() {
                                    print(index);
                                    _listOfSteps.removeAt(index);

                                    if (_index > 0) _index--;
                                  });
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
                                  "ELIMINAR PASO",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        if (_listOfSteps.isNotEmpty) _listOfSteps[_index],

                        if (_listOfSteps.isEmpty)
                          Container(
                              padding: const EdgeInsets.all(20),
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'NO HAY PASOS ASIGNADOS',
                                style: TextStyle(fontSize: 30),
                              )),

                        const SizedBox(height: 35),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.large(
                              heroTag: 'btn1',
                              backgroundColor: const Color(0xFF1BDAF1),
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  if (_index > 0) {
                                    _index--;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 500),
                            FloatingActionButton.large(
                              heroTag: 'btn2',
                              backgroundColor: const Color(0xFF1BDAF1),
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  if (_index < _listOfSteps.length - 1) {
                                    _index++;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 390,
                              child: ElevatedButton(
                                onPressed: () async {
                                  List<CustomCardImage> a = [];
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VerTareaScreen(
                                            tarea: Tarea(
                                          idTarea: "0",
                                          nombreAlumno:
                                              nombreTareaController.text,
                                          titulo: nombreTareaController.text,
                                          descripcion:
                                              descripcionTareaController.text,
                                          fechaIni: FechaInicioController.text.split(" ")[0],
                                          fechaFin: FechaFinalController.text.split(" ")[0],
                                          horaIni: "0",
                                          horaFin: "0",
                                          urlImagenPerfil: urlImagenPerfilController.text,
                                          realizada: 0,
                                          feedback: 0,
                                          urlComprobante: "Null",
                                          urlFeedback: "NULL",
                                          pasos: a,
                                        )),
                                      ));
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
                                  "PREVISUALIZAR TAREA",
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
                                    thirdFormKey.currentState!.validate();
                                    if (secondFormKey.currentState!
                                        .validate()) {
                                          controlador.UpdatePasos(_listOfSteps);
                                      if (widget.alumnoAsignado != null) {
                                    controlador.actualizarAlumnoAsignado(
                                        widget.alumnoAsignado!.dni, widget.tarea.idTarea);
                                  }    
                                      actualizarTarea();
                                      Navigator.maybePop(context);
                                    }
                                  });
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
