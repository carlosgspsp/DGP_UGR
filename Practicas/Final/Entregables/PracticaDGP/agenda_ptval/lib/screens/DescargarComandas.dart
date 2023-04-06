import 'dart:io';
import 'dart:async';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DescargarComandas extends StatefulWidget {
  DescargarComandas({
    Key? key,
  }) : super(key: key);

  @override
  State<DescargarComandas> createState() => _DescargarComandas();
}

class _DescargarComandas extends State<DescargarComandas> {
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
            "DESCARGAR COMANDAS",
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          backgroundColor: const Color(0xFF1BDAF1),
          elevation: 0,
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 20),
                      Text("Comandas: ",
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold)),
                      const Divider(color: Colors.black12),

                      // ignore: prefer_const_constructors
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://s1.eestatic.com/2018/05/02/actualidad/actualidad_304233531_130193550_1706x960.jpg'),
                        ),
                        title: Text('Comanda 1'),
                      ),
                    ],
                  ),
                )),
          ),
        )));
  }
}
