import 'package:agenda_ptval/widgets/widgets.dart';

class Tarea {
  String nombreAlumno = "Sin Asignar";
  final String idTarea;
  final String titulo;
  final String descripcion;
  String fechaIni;
   String fechaFin;
  final String horaIni;
  final String horaFin;
  final String urlImagenPerfil;
  final int realizada;
  final int feedback;
  final String urlComprobante;
  final String urlFeedback;
  List<CustomCardImage> pasos;

  Tarea({
    required this.idTarea,
    required this.nombreAlumno,
    required this.titulo,
    required this.descripcion,
    required this.fechaIni,
    required this.fechaFin,
    required this.horaIni,
    required this.horaFin,
    required this.urlImagenPerfil,
    required this.realizada,
    required this.feedback,
    required this.urlComprobante,
    required this.urlFeedback,
    required this.pasos,
  });
}
