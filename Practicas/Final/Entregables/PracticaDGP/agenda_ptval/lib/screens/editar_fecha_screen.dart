import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditarFechaScreen extends StatefulWidget {
  String fechaFinTarea = '16/11/2022';
  String horaFinTarea = '12:30';

  @override
  State<EditarFechaScreen> createState() => _EditarFechaScreenState();
}

class _EditarFechaScreenState extends State<EditarFechaScreen> {
  DateTime fechaInicio = DateTime(2022, 12, 24, 5, 30);
  DateTime fechaFinal = DateTime(2022, 12, 24, 5, 30);

  // Reference to form widget
  final GlobalKey<FormState> firstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> secondFormKey = GlobalKey<FormState>();
  String url = '';

  TextEditingController urlController = TextEditingController();
  TextEditingController urlImagenPerfilController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      setState(() {
        url = urlController.text;
      });
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Text(
          "EDITAR FECHA",
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: const Color(0xFFA8EC77),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              Text("FECHA INICIO", style: TextStyle(fontSize: 40)),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final fecha = await pickDate();
                        if (fecha == null) return;

                        final nuevaFecha = DateTime(
                          fecha.year,
                          fecha.month,
                          fecha.day,
                          fechaInicio.hour,
                          fechaInicio.minute,
                        );

                        setState(() => fechaInicio = nuevaFecha);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFA8EC77)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "${fechaInicio.day}/${fechaInicio.month}/${fechaInicio.year}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final hora = await pickTime();
                        if (hora == null) return;

                        final nuevaFecha = DateTime(
                          fechaInicio.year,
                          fechaInicio.month,
                          fechaInicio.day,
                          hora.hour,
                          hora.minute,
                        );

                        setState(() => fechaInicio = nuevaFecha);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFA8EC77)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "${fechaInicio.hour}:${fechaInicio.minute}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Text("FECHA FINAL", style: TextStyle(fontSize: 40)),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final fecha = await pickDate();
                        if (fecha == null) return;

                        final nuevaFecha = DateTime(
                          fecha.year,
                          fecha.month,
                          fecha.day,
                          fechaFinal.hour,
                          fechaFinal.minute,
                        );

                        setState(() => fechaFinal = nuevaFecha);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFA8EC77)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "${fechaFinal.day}/${fechaFinal.month}/${fechaFinal.year}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final hora = await pickTime();
                        if (hora == null) return;

                        final nuevaFecha = DateTime(
                          fechaFinal.year,
                          fechaFinal.month,
                          fechaFinal.day,
                          hora.hour,
                          hora.minute,
                        );

                        setState(() => fechaFinal = nuevaFecha);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFA8EC77)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "${fechaFinal.hour}:${fechaFinal.minute}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFA8EC77)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "GUARDAR",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFA8EC77)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "CANCELAR",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
