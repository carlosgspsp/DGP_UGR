import 'package:agenda_ptval/models/comanda_material.dart';
import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:flutter/material.dart';
import '../models/alumno.dart';
import 'custom_card_image.dart';

class TarjetaComandaAlumno extends StatelessWidget {
  final Alumno? alumno;
  final ComandaMaterial comandaMat;

  TarjetaComandaAlumno(
  {
    required this.alumno,
    required this.comandaMat,
    Key? key
  }): super(key: key);

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
                backgroundColor: const Color(0xFFA8EC77),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(comandaMat.urlImagenComandaMaterial),
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
                      Text(comandaMat.nombreComandaMaterial.toUpperCase(), style: const TextStyle(fontSize: 30)),
                      //Nombre alumno y fecha
                      Column(
                        children: [
                          Text(alumno!.nombre.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(width: 30),
              Container(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerComandaScreen(
                                  tituloComanda: comandaMat.nombreComandaMaterial,
                                  descripcionComanda: comandaMat.descripcionComandaMaterial,
                                  urlImagenPerfilComanda: comandaMat.urlImagenComandaMaterial,
                                )));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15.0)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFA8EC77)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(width: 2.0),
                      ),
                    ),
                  ),
                  child: const Text("VER MI COMANDA",
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
        )
    );
  }
}
