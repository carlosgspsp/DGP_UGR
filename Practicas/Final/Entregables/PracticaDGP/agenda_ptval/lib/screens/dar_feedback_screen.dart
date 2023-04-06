import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DarFeedbackScreen extends StatefulWidget {
  String nombreTarea;
  String nombreAlumno;
  String urlImagenPerfilAlumno;
  String urlImagenFeedback =
      "https://www.idsplus.net/wp-content/uploads/default-placeholder.png";
  String urlImagenComprobante =
      "https://www.larazon.es/resizer/8XaDfioFjWPvTlXwkMboOKDruNE=/600x400/smart/filters:format(jpg)/cloudfront-eu-central-1.images.arcpublishing.com/larazon/JL255SHK2JFRBO6DCJVRHKATZA.jpg";

  DarFeedbackScreen({
    Key? key,
    required this.nombreTarea,
    required this.nombreAlumno,
    required this.urlImagenPerfilAlumno,
  }) : super(key: key);

  @override
  State<DarFeedbackScreen> createState() => _DarFeedbackScreenState();
}

class _DarFeedbackScreenState extends State<DarFeedbackScreen> {
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

  Future<void> _seleccionarFeedback(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImagenesFeedbackScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    /*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));*/
    setState(() {
      if (result != null) widget.urlImagenFeedback = result;
    });
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
        /*title: const Center(
            //TITULOOO
            child: Text("FEEDBACK", style: TextStyle(fontSize: 40))),*/
        title: const Text(
          "COMPLETAR TAREA",
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                "${widget.nombreTarea}",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 20),
              InkWell(
                child:
                    Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: const Color(0xFF1BDAF1),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(widget.urlImagenPerfilAlumno),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ]),
              ),
              const SizedBox(width: 30),
              Text(
                "${widget.nombreAlumno}",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
              Text(
                "COMPROBANTE",
                style: TextStyle(fontSize: 25),
              ),
              Container(
                width: 500,
                height: 300,
                child: PinchZoom(
                  child: Image.network(widget.urlImagenComprobante),
                  resetDuration: const Duration(milliseconds: 250),
                  maxScale: 3.5,
                  onZoomStart: () {
                    print('Start zooming');
                  },
                  onZoomEnd: () {
                    print('Stop zooming');
                  },
                ),
              ),
              const SizedBox(height: 30),
              /*InkWell(
                child: Image.network(widget.urlImagenComprobante),
              ),*/
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          _seleccionarFeedback(context);
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
                          "SELECCIONAR FEEDBACK",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "FEEDBACK",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              InkWell(
                child:
                    Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: const Color(0xFF1BDAF1),
                    child: CircleAvatar(
                      radius: 150,
                      backgroundImage: NetworkImage(widget.urlImagenFeedback),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ]),
              ),
              Padding(
                //padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
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
                          "COMPLETAR",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.maybePop(context);
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
