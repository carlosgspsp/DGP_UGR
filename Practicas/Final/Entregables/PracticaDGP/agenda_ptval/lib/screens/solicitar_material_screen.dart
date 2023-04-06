import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:agenda_ptval/models/material.dart';
import 'package:agenda_ptval/widgets/widgets.dart';

class SolicitarMaterialScreen extends StatefulWidget {

  // La lista de materiales disponibles se obtiene de BD
  List<String> listaMateriales = [];

  SolicitarMaterialScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SolicitarMaterialScreen> createState() => _SolicitarMaterialScreenState();
}

class _SolicitarMaterialScreenState extends State<SolicitarMaterialScreen> {

  final ScrollController _scrollController = ScrollController();
  final List<ListTileMaterial> _listaMaterialesActual = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyNuevoMaterial = GlobalKey<FormState>();
  final TextEditingController _cantidadMatController = TextEditingController();
  final TextEditingController _nombreNuevoMatController = TextEditingController();
  String _nombreMaterial = '';
  bool _visible = true;

  Future<List<String>> obtenerMateriales() async {
    // Datos de la BD provisonales
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'agenda_ptval',
    ));

    final results = await conn.query('SELECT nombre FROM materiales');

    List<String> listaMateriales = [];
    for (var row in results) {
      listaMateriales.add(row[0]);
    }

    conn.close();

    return listaMateriales;
  }

  Future crearNuevoMaterial(String nombreMaterial) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'agenda_ptval',
    ));

    var result = await conn.query('INSERT INTO materiales (nombre) VALUES (?)', [nombreMaterial]);
    
    conn.close();

    return result.insertId;
  }

  // Convertir primera letra de una palabra a mayúscula
  String fisrtToUpperCase(String palabra) {
    return palabra[0].toUpperCase() + palabra.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();

    // Añadir listener para el scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        setState(() {
          print('Se ha llegado al final de la lista');
          _visible = false;
        });
      }
      else {
        setState(() {
          _visible = true;
        });
      }
    });

    // TODO: Obtener la lista de materiales de BD
  //  obtenerMateriales().then((value) => widget.listaMateriales = value);
    // Por ahora se usa una lista de materiales de prueba
    widget.listaMateriales = [
      'Lápices', 'Papel', 'Bolígrafos', 'Sacapuntas', 'Ceras'
    ];

    _nombreMaterial = widget.listaMateriales[0];

  }

  Future<MaterialClase?> pedirNuevoMaterial() => showDialog<MaterialClase>(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 35.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: const Text('Añadir nuevo material', style: TextStyle(fontSize: 30.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nuevo material', style: TextStyle(fontSize: 30.0)),
        
              const SizedBox(height: 20.0),
        
              DropdownButtonFormField<String>(
                iconEnabledColor: const Color(0xFF1BDAF1),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Color(0xFF1BDAF1)),
                  ),
                  errorStyle: const TextStyle(fontSize: 20.0)
                ),
                value: _nombreMaterial,
                items: widget.listaMateriales.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _nombreMaterial = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || _listaMaterialesActual.any((element) => element.material.nombreMaterial == value)) {
                    return 'Seleccione un material que no esté en la lista';
                  }
                  return null;
                },
              ),
        
              const SizedBox(height: 20.0),
              const Text('Nueva cantidad', style: TextStyle(fontSize: 30.0)),
              const SizedBox(height: 20.0),
        
              TextFormField(
                controller: _cantidadMatController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Color(0xFF1BDAF1)),
                  ),
                  focusColor:Color(0xFF1BDAF1),
                  errorStyle: TextStyle(fontSize: 20.0),
                  labelText: 'Cantidad',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'Introduzca una cantidad correcta';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(
                context,
                MaterialClase(
                  nombreMaterial: _nombreMaterial,
                  cantidadMaterial: int.parse(_cantidadMatController.text)
              ));
            }
          },
          child: const Text('Añadir', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () => Navigator.maybePop(context),
          child: const Text('Cancelar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
      ],
    ),
  );

  // AlertDialog para añadir un nuevo tipo de material a la BD
  Future<String?> agregarNuevoMaterial() => showDialog<String?> (
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 35.0),
      title: const Text('Crear un nuevo tipo de material', style: TextStyle(fontSize: 30.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKeyNuevoMaterial,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nombreNuevoMatController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nombre del material',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Color(0xFF1BDAF1)),
                  ),
                  focusColor:Color(0xFF1BDAF1),
                  errorStyle: TextStyle(fontSize: 20.0),
                  labelStyle: TextStyle(fontSize: 20.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) != null) {
                    return 'Introduzca un nombre correcto';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {
            if (_formKeyNuevoMaterial.currentState!.validate()) {
              Navigator.of(context).pop(_nombreNuevoMatController.text);
            }
          },
          child: const Text('Aceptar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
        TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
        ),
      ],
    ),
  );
  
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
          "SOLICITAR MATERIAL",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      pedirNuevoMaterial().then((material) {
                        if (material != null) {
                          setState(() {
                            _listaMaterialesActual.add(ListTileMaterial(material: material));
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    elevation: 0.0,
                    backgroundColor: const Color(0xFF1BDAF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Añadir material', style: TextStyle(fontSize: 40.0, color: Colors.black),),
                  ),

                  const SizedBox(width: 15.0),

                  ElevatedButton(
                    onPressed: () {
                      agregarNuevoMaterial().then((material) {
                        if (material != null) {
                          material = fisrtToUpperCase(material);
                          // crearNuevoMaterial(material).then((value) {
                          //   if (value != null) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Material creado con éxito.', style: TextStyle(fontSize: 30)),
                          //         backgroundColor: Colors.green,
                          //         duration: Duration(seconds: 4),
                          //       )
                          //     );
                          //   }
                          // });
                          print(material);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    elevation: 0.0,
                    backgroundColor: const Color(0xFF1BDAF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Crear nuevo material', style: TextStyle(fontSize: 40.0, color: Colors.black),),
                  ),

                ],
              ),
            ),

            const Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Text(
              'Materiales:',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
            ),

            if (_listaMaterialesActual.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Aún no se ha añadido ningún material a la lista. Pulse el botón "Añadir material" para añadir uno.',
                  style: TextStyle(color: Colors.grey[400],fontSize: 30.0, fontWeight: FontWeight.w100, fontStyle: FontStyle.italic),),
              )
            else
              Flexible(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20.0),
                  itemCount: _listaMaterialesActual.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                        ),
                        alignment: AlignmentDirectional.centerEnd,
                        // color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.delete, color: Colors.white, size: 30.0,),
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          _listaMaterialesActual.removeAt(index);
                        });
                      },
                      child: _listaMaterialesActual[index]
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 20.0),
                ),
              ),

            const SizedBox(height: 20.0),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
            
                    ElevatedButton(
                      onPressed: () {
                        if (_listaMaterialesActual.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error. Añade al menos un material a la lista.', style: TextStyle(fontSize: 30)),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 4),
                            )
                          );
                          return;
                        }
                        // Crear una lista con los materiales solicitados
                        List<MaterialClase> listaMaterialesSolicitados = [];

                        for (var material in _listaMaterialesActual) {
                          listaMaterialesSolicitados.add(material.material);
                        }

                        // Mostar un dialogo preguntando si se desea enviar la solicitud
                        showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                            title: const Text('¿Desea enviar la solicitud de materiales actual?'),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Mostrar diálogo de que la solicitud se ha enviado
                                  Navigator.maybePop(context);
                                  Navigator.maybePop(context);
                                },
                                child: const Text('Aceptar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0)),
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1BDAF1),),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.maybePop(context),
                                child: const Text('Cancelar', style: TextStyle(color: Colors.black, fontSize: 30.0)),
                              ),
                            ]
                          ))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      elevation: 0.0,
                      backgroundColor: const Color(0xFF1BDAF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text('Confirmar selección', style: TextStyle(fontSize: 40.0, color: Colors.black),),
                    ),
            
                    const SizedBox(width: 15.0),
            
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      elevation: 0.0,
                      backgroundColor: const Color(0xFF1BDAF1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text('Cancelar', style: TextStyle(fontSize: 40.0, color: Colors.black),),
                    ),
            
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}