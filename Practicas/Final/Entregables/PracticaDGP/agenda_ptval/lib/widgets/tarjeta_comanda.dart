import 'package:agenda_ptval/models/tarea.dart';
import 'package:agenda_ptval/screens/editar_comanda_screen.dart';
import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/screens/ver_comanda_screen.dart';
import 'package:flutter/material.dart';

import 'custom_card_image.dart';

class TarjetaComanda extends StatelessWidget {

  final String nombreAlumno;
  String titulo;
  String descripcion;
  final String tipoComanda;
  // final String fechaFin;
  // final String horaFin;
  String urlImagenPerfil;
  String idComanda;

  // final List<CustomCardImage> pasos;
  
  TarjetaComanda({
    required this.nombreAlumno,
    required this.titulo,
    required this.descripcion,
    // required this.fechaFin,
    // required this.horaFin,
    required this.urlImagenPerfil,
    required this.tipoComanda,
    required this.idComanda,
    // required this.pasos,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Variables para alumno sin asignar
    Color? colorin;
    var nombre = nombreAlumno;
    var fuente =  FontWeight.normal;
    //Establecer diferencias
    if(nombreAlumno == " "){
       colorin =  Colors.grey[350];
       nombre = "Sin asignar";
       fuente =  FontWeight.bold;
    }else{
      colorin =  Colors.grey[100];
    }


        return Container( 
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
                                backgroundImage: NetworkImage(urlImagenPerfil),
                                radius: 26,
                              ),
                        ),
                const SizedBox(width: 20),
                Container(
                width: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(titulo, style: const TextStyle(fontSize: 25)),
                    Text('Tipo: $tipoComanda', style: const TextStyle(fontSize: 20)),
                    Text(nombre, style:  TextStyle(fontSize: 20, color: Colors.black, fontWeight: fuente)),
              ]
            ),
            ),
            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => VerComandaScreen(
                 tituloComanda: titulo,
                  descripcionComanda: descripcion,
                  urlImagenPerfilComanda: urlImagenPerfil,
                )));
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0),
                  ),
                ),
              ),
              child: const Text("Ver", style: TextStyle(fontSize: 20,   color: Colors.black,)),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditarComandaScreen(
                  tituloComanda: titulo,
                  descripcionComanda: descripcion,
                  urlImagenPerfilComanda: urlImagenPerfil,
                  idComanda: idComanda,
                )));
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0),
                  ),
                ),
              ),
              child: const Text("Editar", style: TextStyle(fontSize: 20,   color: Colors.black,)),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(width: 2.0),
                  ),
                ),
              ),
              child: const Text("Corregir", style: TextStyle(fontSize: 20,   color: Colors.black,)),
            )
          ],
        ),
      )
    );
  }
}
