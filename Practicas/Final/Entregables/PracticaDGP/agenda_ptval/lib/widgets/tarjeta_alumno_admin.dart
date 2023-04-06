import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/screens/editar_alumno.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import '../models/alumno.dart';
import 'custom_card_image.dart';

class TarjetaAlumnoAdmin extends StatefulWidget {
  final Alumno? alumno;

  TarjetaAlumnoAdmin(
  {
    required this.alumno,
    Key? key
  }): super(key: key);

  @override
  State<TarjetaAlumnoAdmin> createState() => _TarjetaAlumnoAdminState();
}

class _TarjetaAlumnoAdminState extends State<TarjetaAlumnoAdmin> {

  final Controller _conn = Controller();

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 62,
                backgroundColor: const Color(0xFF1BDAF1),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.alumno!.fotoPerfil),
                  radius: 60,
                ),
              ),
              const SizedBox(width: 30),
              //Nombre tarea y datos
              Container(
                width: 270,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Alumno: ${widget.alumno!.nombre} ${widget.alumno!.apellidos}", style: const TextStyle(fontSize: 30)),
                      //Nombre alumno y fecha
                      Column(
                        children: [
                          Text("DNI: ${widget.alumno!.dni}",
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarAlumno(alumno: widget.alumno),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15.0)),
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
                      child: const Text("EDITAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // Eliminar el alumno de base de datos
                        // Mostar un dialogo de confirmacion
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Eliminar alumno"),
                              content: const Text("¿Estás seguro de que quieres eliminar este alumno?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Eliminar alumno de base de datos
                                    await _conn.eliminarAlumno(widget.alumno!.dni);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    
                                  },
                                  child: const Text("Eliminar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(15.0)),
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
                      child: const Text("ELIMINAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
