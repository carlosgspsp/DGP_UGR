import 'package:agenda_ptval/models/alumno.dart';
import 'package:agenda_ptval/screens/crear_tarea_screen.dart';
import 'package:agenda_ptval/screens/lista_tarea_filtrada.dart';
import 'package:agenda_ptval/widgets/render_lista_tareas.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
//ort 'package:flutteusel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:mysql1/mysql1.dart';
import '../enumerators/tipos_login';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../datab_controller/controller.dart';
import '../models/tarea.dart';
import 'DescargarComandas.dart';
import 'menu_inicial_screen.dart';

class ListaTareasScreen extends StatefulWidget {
  List<List<TarjetaTarea>> listaTareas;

  ListaTareasScreen({required this.listaTareas, Key? key}) : super(key: key);

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  final TextEditingController _controllerUser = TextEditingController();
  late CarouselSliderController _sliderController;
  final Controller _conn = Controller();
  final List<CustomCardImage> _pasosTarea = [];
  Alumno? _alumno;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 buscarTarea() {
      final form = _formKey.currentState;
      String titulo = _controllerUser.text;
      var nombre;
        print(titulo);
      
        for (int i = 0; i < widget.listaTareas[0].length; i ++) {
         if (widget.listaTareas[0].elementAt(i).tarea.titulo.contains(titulo)) {
           widget.listaTareas[0].elementAt(i).visual = true;
         }else{
              widget.listaTareas[0].elementAt(i).visual = false;
         }
        }
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListaTareasFiltradaScreen(
                                listaTareas: widget.listaTareas,
                              )),
                    );
       
    }
  Future<void> _fetchTareas() async {
    widget.listaTareas.clear();
    // Obtener todas las tareas de la bd
    Results results = await _conn.getAllTareas();

    // Almacenar las Tareas
    List<List<TarjetaTarea>> listaTareasAux = [];
    List<TarjetaTarea> lista = [];
    TarjetaTarea tarea;
    int max = 6;
    int i = 0;

    for (var row in results) {
      await _fetchAlumnoTarea(row['ID_tarea']);
      await _fetchPasosTarea(row['ID_tarea']);

      // if (_alumno == null) {
      //   print('****************************************************');
      //   print("ALUMNO NULO");
      //   print('****************************************************');
      // }

      tarea = TarjetaTarea(
        
        alumno: _alumno,
        visual: true,
        tarea: Tarea(idTarea: row['ID_tarea'],
          nombreAlumno: _alumno != null ?_alumno!.nombre : '',
          titulo: row['Titulo'],
        descripcion: row['Descripcion'],
        urlImagenPerfil: row['URL_foto'],
        fechaFin: row['Fecha_fin'].toString(),
        horaFin: '',
        horaIni: '',
        fechaIni: row['Fecha_ini'].toString(),
        realizada: row['Realizada'],
        feedback: row['Tiene_feedback'],
        urlComprobante: row['URL_foto_completada'] , urlFeedback: row['URL_foto_feedback'], pasos: _pasosTarea),
        pasos: _pasosTarea,
      );
      lista.add(tarea);
      i++;
      if (i == max) {
        listaTareasAux.add(lista);
        lista = [];
        i = 0;
      }
    }
    if (i < max && lista.isNotEmpty) {
      listaTareasAux.add(lista);
    }
    setState(() {
      // Añadir la lista de comandas a la lista de listas de comandas
      widget.listaTareas = listaTareasAux;
    });
  }

  // Almacenar el alumno asociado a la tarea
  Future<void> _fetchAlumnoTarea(String idTarea) async {
    // late Alumno alumnFinal;
    Results result = await _conn.getAlumnoTarea(idTarea);
    if (!result.isNotEmpty) {
      _alumno = null;
    }
    // Alumno alumno = Alumno(
    //   nombre: 'PEPE',
    //   apellidos: 'PEREX',
    //   dni: '12345678A',
    //   correo: 'pepe@correo.es',
    //   fotoPerfil: ' ',
    //   tipoLogin: tiposLogin.TEXTO,
    //   password: '1234',
    //   autorizado: 1,
    //   tipoAlumno: 1,
    // );
    for (var row in result) {
      // Inicializar los datos del almuno
      _alumno = Alumno(
          nombre: row['Nombre'],
          apellidos: row['Apellidos'],
          dni: row['DNI_alumno'],
          correo: row['Correo'],
          fotoPerfil: row['URL_foto'],
          tipoLogin: tiposLogin.TEXTO,
          password: row['Contrasennia'],
          autorizado: row['Autorizado'],
);

      // _alumno.nombre = row['Nombre'];
      // _alumno.apellidos = row['Apellidos'];
      // _alumno.dni = row['DNI_alumno'];
      // _alumno.correo = row['Correo'];
      // _alumno.fotoPerfil = row['URL_foto'];
      // _alumno.tipoLogin = tiposLogin.TEXTO;
      // _alumno.password = row['Contrasennia'];
      // _alumno.autorizado = row['Autorizado'];
      // _alumno.tipoAlumno = row['Tipo_alumno'];
      // print('****************************************************');
      // print("ALUMNO ASIGNADO $idTarea");
      // print(_alumno.nombre);
      // print(_alumno.apellidos);
      // print(_alumno.dni);
      // print('****************************************************');

    }
  }

  Future<void> _fetchPasosTarea(String idTarea) async {
    // Obtener todos los pasos asociados a la tarea

    _conn.getPasosTarea(idTarea).then((value) {
      // Almacenar los pasos asociados a la tarea
      CustomCardImage paso;
      for (var row in value) {
        paso = CustomCardImage(
            imageUrl: row['URL_imagen'], cardName: row['Titulo'], idPaso: row['ID_paso'],);
        _pasosTarea.add(paso);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
    _fetchTareas();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      Future.delayed(const Duration(seconds: 2));
      _fetchTareas();
    });
  }

  //Filtros
  final List<String> items = [
    'Tareas asignadas',
    'Tareas no asignadas',
    'Fecha de entrega mas lejana',
    'Fecha de entrega mas proxima',
    'Mostrar Todo',
  ];
  String? selectedValue;
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
          "LISTA DE TAREAS",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: const Color(0xFF1BDAF1),
        onRefresh: _pullRefresh,
        child: ListView(
          children: <Widget>[
              GenTextFormField(
            
            controller: _controllerUser,
            hintText: 'Introduzca el nombre de la tarea a buscar',
            icon: Icons.edit_note_rounded ,
            obscureText: false,
            inputType: TextInputType.name,
              ),
               const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => buscarTarea(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    elevation: 0.0,
                    backgroundColor: const Color(0xFF1BDAF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(width: 2.0),

                    ),
                  ),
                  child: const Text(
                    'Realizar busqueda',
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                ),
            //Filtrado
            const SizedBox(height: 10),
            Container(
              height: 43,
              decoration: new BoxDecoration(
                border: Border.all(width: 1.5),
                color: const Color(0xFF1BDAF1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    '  Filtrar por:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    if (value == "Tareas asignadas") {
                      for (int i = 0; i < widget.listaTareas[0].length; i++) {
                        if (widget.listaTareas[0].elementAt(i).alumno == null) {
                          widget.listaTareas[0].elementAt(i).visual = false;
                        } else {
                          widget.listaTareas[0].elementAt(i).visual = true;
                        }
                      }
                      //LLamar a la lista filtrada
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTareasScreen(
                                  listaTareas: widget.listaTareas,
                                )),
                      );
                    } else if (value == "Tareas no asignadas") {
                      for (int i = 0; i < widget.listaTareas[0].length; i++) {
                        if (widget.listaTareas[0].elementAt(i).alumno == null) {
                          widget.listaTareas[0].elementAt(i).visual = true;
                        } else {
                          widget.listaTareas[0].elementAt(i).visual = false;
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTareasScreen(
                                  listaTareas: widget.listaTareas,
                                )),
                      );
                    } else if (value == "Mostrar Todo") {
                      for (int i = 0; i < widget.listaTareas[0].length; i++) {
                        widget.listaTareas[0].elementAt(i).visual = true;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTareasFiltradaScreen(
                                  listaTareas: widget.listaTareas,
                                )),
                      );
                    }
                    if (value == "Fecha de entrega mas proxima") {
                      widget.listaTareas[0].sort((a, b) {
                        //sorting in ascending order

                        return (a.fechaFin).compareTo((b.fechaFin));
                      });
                      List<List<TarjetaTarea>> listaTareas =
                          <List<TarjetaTarea>>[];
                      for (int i = 0; i < widget.listaTareas[0].length; i++) {
                        widget.listaTareas[0].elementAt(i).visual = true;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTareasFiltradaScreen(
                                  listaTareas: widget.listaTareas,
                                )),
                      );
                    } else if (value == "Fecha de entrega mas lejana") {
                      widget.listaTareas[0].sort((b, a) {
                        //sorting in ascending order

                        return (a.fechaFin).compareTo((b.fechaFin));
                      });
                      List<List<TarjetaTarea>> listaTareas =
                          <List<TarjetaTarea>>[];
                      for (int i = 0; i < widget.listaTareas[0].length; i++) {
                        widget.listaTareas[0].elementAt(i).visual = true;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTareasScreen(
                                  listaTareas: widget.listaTareas,
                                )),
                      );
                    }
                    //Elegir ventana

                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 140,
                  itemHeight: 40,
                ),
              ),
            ),

            //Lista de tareas
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 700,
                // width: 200,
                child: CarouselSlider.builder(
                  unlimitedMode: true,
                  controller: _sliderController,
                  slideBuilder: (index) {
                    return RenderListaTareas(
                        listaTareas: widget.listaTareas[index]);
                  },
                  // slideTransform: null,
                  slideIndicator: CircularSlideIndicator(
                    padding: const EdgeInsets.only(bottom: 32),
                    indicatorBorderColor: Colors.black,
                  ),
                  itemCount: widget.listaTareas.length,
                  initialPage: 0,
                  enableAutoSlider: false,
                ),
              ),
            ),
            //Flechas
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Align(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 240, maxWidth: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.large(
                        heroTag: 'btn1',
                        backgroundColor: const Color(0xFF1BDAF1),
                        elevation: 0,
                        onPressed: () {
                          _sliderController
                              .previousPage(Duration(milliseconds: 600));
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
                          _sliderController
                              .nextPage(Duration(milliseconds: 600));
                          ;
                        },
                        child: const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //BOTÓN SALIR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CrearTareasScreen()));
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF1BDAF1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(width: 2.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "CREAR TAREA",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
