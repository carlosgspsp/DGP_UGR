import 'package:agenda_ptval/screens/crear_tarea_screen.dart';
import 'package:agenda_ptval/widgets/render_lista_tareas.dart';
import 'package:flutter/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
//ort 'package:flutteusel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../datab_controller/controller.dart';
import '../models/alumno.dart';
import 'DescargarComandas.dart';
import 'lista_tareas.dart';
import 'menu_inicial_screen.dart';

class ListaTareasFiltradaScreen extends StatefulWidget {
  List<List<TarjetaTarea>> listaTareas;

  
  ListaTareasFiltradaScreen({required this.listaTareas, Key? key}) : super(key: key);

  @override
  State<ListaTareasFiltradaScreen> createState() => _ListaTareasFiltradaScreenState();
}

class _ListaTareasFiltradaScreenState extends State<ListaTareasFiltradaScreen> {
  late CarouselSliderController _sliderController;
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      final TextEditingController _controllerUser = TextEditingController();
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
  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();

  }

  //Filtros
  final List<String> items = [
    'Tareas asignadasss',
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

      //Desplegable filtros

      body: ListView(
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
          //Buscador
          //Filtrado
           //Desplegable filtros
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
                          builder: (context) => ListaTareasScreen(
                                listaTareas: widget.listaTareas,
                              )),
                    );
                  }
                  if (value == "Fecha de entrega mas proxima") {
                   widget.listaTareas[0].sort((b, a) {
                      //sorting in ascending order

                      return (b.fechaFin)
                          .compareTo((a.fechaFin));
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
                    // List<List<TarjetaTarea>> listaTareas =
                    //     <List<TarjetaTarea>>[];
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
                        _sliderController.nextPage(Duration(milliseconds: 600));
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
    );
  }
}
