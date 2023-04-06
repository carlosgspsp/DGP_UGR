import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import '../models/alumno.dart';
import 'custom_card_image.dart';

class TarjetaTarea extends StatelessWidget {
  bool visual;
  //String idtarea;
  final Alumno? alumno;
  /*final String titulo;
  final String descripcion;
  final DateTime fechaIni;
  final DateTime fechaFin;
  final bool realizada;
  final bool corregida;
  final String urlImagenPerfil;
  final String urlFotoCompletada;
  final String urlFotoFeedback;*/
  final Tarea tarea;
  final List<CustomCardImage> pasos;
  late DateTime fechaIni;
  late DateTime fechaFin;

  TarjetaTarea(
      {required this.visual,
      required this.alumno,
      required this.tarea,
      required this.pasos,
      Key? key})
      : super(key: key);
      

  @override
  Widget build(BuildContext context) {
    fechaIni = DateTime.parse(tarea.fechaIni);
    fechaFin = DateTime.parse(tarea.fechaFin);

    tarea.fechaFin = tarea.fechaFin.split(" ")[0];
    tarea.fechaIni = tarea.fechaIni.split(" ")[0];

    //Variables para alumno sin asignar
    Color? colorin;
    var nombre;
    var fuente = FontWeight.normal;
    //Establecer diferencias
    if (alumno == null) {
      colorin = Colors.grey[350];
      nombre = "Sin asignar";
      fuente = FontWeight.bold;
    }else{
      nombre = "${alumno!.nombre} ${alumno!.apellidos}";
      colorin = Colors.green[200];
    }

    if(tarea.realizada == false && alumno != null){
      colorin = Colors.red[200];
    }else if(tarea.feedback == false && alumno != null){
      colorin = Colors.yellow[200];
    }

    
    if (visual == true) {
      return Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: colorin,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF1BDAF1),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(tarea.urlImagenPerfil),
                    radius: 26,
                  ),
                ),
                const SizedBox(width: 20),
                //Nombre tarea y datos
                Container(
                  width: 270,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(tarea.titulo,
                            style: const TextStyle(fontSize: 23)),
                        //Nombre alumno y fecha
                        Column(
                          children: [
                            Text(nombre,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: fuente)),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                                "${fechaIni.day}/${fechaIni.month}/${fechaIni.year} - ${fechaFin.day}/${fechaFin.month}/${fechaFin.year}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: fuente)),
                          ],
                        ),
                      ]),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerTareaScreen(
                                      tarea: tarea)));
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
                    child: const Text(" Ver\nTarea ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),

                const SizedBox(width: 20),
                Container(
                  height: 47,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarTareasScreen(
                                    tituloTarea: tarea.titulo,
                                    descripcionTarea: tarea.descripcion,
                                    fechaFinTarea: " ",
                                    urlImagenPerfilTarea: tarea.urlImagenPerfil,
                                    pasosTarea: pasos,
                                    tarea: tarea,
                                    alumnoAsignado: alumno,
                                  )));
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
                    child: const Text(" Editar\nTarea ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),

                const SizedBox(width: 20),
                Container(
                    height: 47,
                    child: ElevatedButton(
                      onPressed: () {
                        if (alumno != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DarFeedbackScreen(
                                        nombreAlumno: "${nombre}",
                                        nombreTarea: tarea.titulo,
                                        urlImagenPerfilAlumno:
                                            alumno!.fotoPerfil,
                                      )));
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content:
                                    Text('La tarea no tiene alumno asignada')));
                        }
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
                      child: const Text(" Corregir ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          )),
                    ))
              ],
            ),
          ));
    } else {
      return Container();
    }
  }
}
