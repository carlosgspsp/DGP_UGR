import 'dart:ffi';

import 'package:agenda_ptval/models/alumno.dart';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';

import '../widgets/custom_card_image_editable.dart';

final IP = 'dgp.c3to43au3c2n.eu-west-3.rds.amazonaws.com';

class Controller {
  Future<dynamic> queryBD(String query, List valores) async {
    Results resultado;

    var settings = ConnectionSettings(
        host: IP,
        port: 3306,
        user: 'root',
        password: 'dgpgrupotres',
        db: 'agendaptval');
    print("antes");
    var conn = await MySqlConnection.connect(settings);
    print("conectado");
    try {
      resultado = await conn.query(query, valores);
    } catch (error) {
      print(error.toString());
      return "ERROR QUERYBD\n" + error.toString();
    }
    await conn.close();
    return resultado;
  }

  /// Función para obtener todas las tareas
  /// @author Samuel
  Future<dynamic> getAllTareas() async {
    String query = "SELECT * FROM `tarea`";
    var resultadoQuery = await queryBD(query, []);
    return resultadoQuery;
  }

  // Función para obtener El alumno asignado a una trea
  Future<dynamic> getAlumnoTarea(String tarea_id) async {
    String query =
        "SELECT * FROM `alumno` WHERE DNI_alumno IN (SELECT DNI_alumno FROM `al_tiene_tar` WHERE ID_tarea = ?)";

    var resultadoQuery = await queryBD(query, [tarea_id]);

    return resultadoQuery;
  }

  /// Función para subir una tareas
  /// id tiene que ser primeras dos letras de la tabla más hora y fecha con segundos rollo:
  /// ta_16/12/2220:29:50

  /// @author Samuel
  Future<dynamic> pushTarea(
      String ID_tarea,
      String Titulo,
      String Descripcion,
      String URL_foto,
      String Fecha_ini,
      String Fecha_fin,
      int Realizada,
      int Tiene_feedback,
      String URL_foto_completada,
      String URL_foto_feedback) async {
    String query =
        "INSERT into `tarea` (ID_tarea, Titulo, Descripcion, URL_foto, Fecha_ini, Fecha_fin, Realizada, Tiene_feedback, URL_foto_completada, URL_foto_feedback, Fecha_orden) values (?,?,?,?,?,?,?,?,?,?,?)";
    List<dynamic> valores = [
      ID_tarea,
      Titulo,
      Descripcion,
      URL_foto,
      Fecha_ini,
      Fecha_fin,
      Realizada,
      Tiene_feedback,
      URL_foto_completada,
      URL_foto_feedback,
      ''
    ];

    var resultado_query = await queryBD(query, valores);

    //for (var row in resultado_query) {
    //print(row['DNI_admin']);
    //}

    return resultado_query;
  }

  // Future<dynamic> pushPasos(
  //     String idTarea, List<CustomCardImageEditable> _listOfSteps) async {
  //   for (int i = 0; i < _listOfSteps.length; i++) {
  //     String query = "INSERT into `pasos` (idPaso, imagen, titulo, orden paso)";
  //   }

  //   String query = "INSERT into `tar_tiene_pas` (idTarea,)";
  // }

  /// Función para cambiar de contraseña a un usuario
  /// @author Samuel
  Future<dynamic> cambiarPassword(String newPassword, String idUsuario) async {
    String query = 'update Usuarios set password = ? where id_usuario = ?';

    List<String> valores = [newPassword, idUsuario];
    Results r = await queryBD(query, valores);

    return r;
  }

  //Función para iniciar sesión
  Future<bool> iniciarSesion(String username, String password) async {
    bool resultado = false;
    bool noMeter = false;
    bool noPrevio = false;
    int numAlum = -1;

    List<String> passwords;

    String query = 'select * from Alumno where username=? and password=?';

    var resultado_query = await queryBD(query, [username, password]);

    //  Si el resultado de la consulta está vacío es que el usuario y contraseña no es alumno
    if (!resultado_query.isEmpty) {
      resultado = true; //ES ALUMNO

    } else {
      String query = 'select * from Admin where username=? and password=?';

      var resultado_query = await queryBD(query, [username, password]);

      //  Si el resultado de la consulta está vacío es que el usuario y contraseña no es admin
      if (!resultado_query.isEmpty) {
        resultado = true; //ES ADMIN

      } else {
        String query = 'select * from Profesor where username=? and password=?';

        var resultado_query = await queryBD(query, [username, password]);

        //  Si el resultado de la consulta está vacío es que el usuario y contraseña no exste
        if (!resultado_query.isEmpty) {
          resultado = true; //ES PROFESOR

        }
      }
    }
    return resultado;
  }

  // Función para insertar una nueva comanda de tipo Material
  Future<dynamic> insertarComandaMaterial(
      String nombre, String descripcion, String urlImagen) async {
    String id = 'com_mat_${DateTime.now()}';
    String query =
        "INSERT into `comanda_material` (id_com_mat, nombre, descripcion, url_imagen) values (?,?,?,?)";
    List<String> valores = [id, nombre, descripcion, urlImagen];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

  // Función para editar una comanda de tipo Material
  Future<dynamic> editarComandaMaterial(
      String id, String nombre, String descripcion, String urlImagen) async {
    String query =
        "UPDATE `comanda_material` SET nombre = ?, descripcion = ?, url_imagen = ? WHERE id_com_mat = ?";
    List<String> valores = [nombre, descripcion, urlImagen, id];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

  // Función para obtener una lista de todas las comandas
  Future<dynamic> getComandas() async {
    String query = "SELECT * FROM `comanda_material`";

    var resultadoQuery = await queryBD(query, []);

    return resultadoQuery;
  }

  Future<dynamic> pushComprobante(String id, String pathimagen) async {
    String query =
        "UPDATE `tarea` SET URL_foto_completada = ? WHERE ID_tarea = ?";
    List<String> valores = [pathimagen, id];

    var resultadoQuery = await queryBD(query, valores);
    return resultadoQuery;
  }

  Future<dynamic> getAdmin(String user) async {
    String query = "SELECT contrasennia FROM `admin` where admin.DNI_admin = ?";

    var resultadoQuery = await queryBD(query, [user]);

    return resultadoQuery;
  }

  Future<dynamic> getProfe(String user) async {
    String query =
        "SELECT contrasennia FROM `profesor` where profesor.DNI_profe = ?";

    var resultadoQuery = await queryBD(query, [user]);

    return resultadoQuery;
  }

  // Función para obtener todos los datos de un alumno dado su DNI
  Future<dynamic> getAlumno(String dni) async {
    String query = "SELECT * FROM `alumno` WHERE DNI_alumno = ?";

    var resultadoQuery = await queryBD(query, [dni]);

    return resultadoQuery;
  }

  // Función para obtener todas las tareas asignadas a un alumno
  Future<dynamic> getTareasAlumno(String dni) async {
    String query =
        "SELECT * FROM `tarea` WHERE ID_tarea IN (SELECT ID_tarea FROM `al_tiene_tar` WHERE DNI_alumno = ?)";

    var resultadoQuery = await queryBD(query, [dni]);

    return resultadoQuery;
  }

  // Función para obtener todas las tareas asignadas a un alumno
  Future<dynamic> getTarea(String ID) async {
    String query = "SELECT * FROM `tarea` WHERE ID_tarea = ?";
    var resultadoQuery = await queryBD(query, [ID]);
    return resultadoQuery;
  }

  // Función para obtener los pasos asociados a una tarea
  Future<dynamic> getPasosTarea(String idTarea) async {
    String query =
        "SELECT * FROM `pasos` WHERE ID_paso IN (SELECT ID_paso FROM `tar_tiene_pas` WHERE ID_tarea = ?)";

    var resultadoQuery = await queryBD(query, [idTarea]);

    return resultadoQuery;
  }

  // Función para obtener todas las comandas de material asignadas a un alumno
  Future<dynamic> getComandasMaterialAlumno(String dni) async {
    String query =
        "SELECT * FROM `comanda_material` WHERE id_com_mat IN (SELECT ID_comanda_mat FROM `al_tiene_com_mat` WHERE DNI_alumno = ?)";

    var resultadoQuery = await queryBD(query, [dni]);

    print(resultadoQuery);

    return resultadoQuery;
  }

  // Función para insertar un nuevo alumno en la base de datos
  Future<dynamic> insertarAlumno(Alumno nuevoAlumno) async {
    int tipo = 0;
    if (nuevoAlumno.tipoLogin.name == 'TEXTO') {
      tipo = 1;
    } else if (nuevoAlumno.tipoLogin.name == 'IMAGENES') {
      tipo = 2;
    } else if (nuevoAlumno.tipoLogin.name == 'PATRON') {
      tipo = 3;
    }

    String query =
        "INSERT into `alumno` (DNI_alumno, Nombre, Apellidos, URL_foto, Contrasennia, Correo, Autorizado, Tipo_alumno) values (?,?,?,?,?,?,?,?)";
    List<dynamic> valores = [
      nuevoAlumno.dni,
      nuevoAlumno.nombre,
      nuevoAlumno.apellidos,
      nuevoAlumno.fotoPerfil,
      nuevoAlumno.password,
      nuevoAlumno.correo,
      nuevoAlumno.autorizado,
      tipo
    ];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

  // Función para editar un alumno en la base de datos
  Future<Results> editarAlumno(Alumno alumno) async {
    int tipo = 0;
    if (alumno.tipoLogin.name == 'TEXTO') {
      tipo = 1;
    } else if (alumno.tipoLogin.name == 'IMAGENES') {
      tipo = 2;
    } else if (alumno.tipoLogin.name == 'PATRON') {
      tipo = 3;
    }

    String query =
        "UPDATE `alumno` SET Nombre = ?, Apellidos = ?, URL_foto = ?, Contrasennia = ?, Correo = ?, Autorizado = ?, Tipo_alumno = ? WHERE DNI_alumno = ?";
    List<dynamic> valores = [
      alumno.nombre,
      alumno.apellidos,
      alumno.fotoPerfil,
      alumno.password,
      alumno.correo,
      alumno.autorizado,
      tipo,
      alumno.dni
    ];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

  // Función para eliminar un alumno de la base de datos
  Future<Results> eliminarAlumno(String dni) async {
    String query = "DELETE FROM `alumno` WHERE DNI_alumno = ?";
    List<dynamic> valores = [dni];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

  // Función para obtener todos los alumnos de la base de datos
  Future<Results> getAlumnos() async {
    String query = "SELECT * FROM `alumno`";

    var resultadoQuery = await queryBD(query, []);

    return resultadoQuery;
  }
  
  Future<dynamic> asignarAlumno(String idAlumno, String idTarea) async {
    String query =
        "INSERT into `al_tiene_tar` (DNI_alumno, ID_tarea) values (?,?)";

    List<String> valores = [idAlumno, idTarea];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

Future<dynamic> actualizarAlumnoAsignado(String idAlumno, String idTarea) async {
  
         String query =
        " UPDATE `al_tiene_tar` SET DNI_alumno = ? WHERE ID_tarea = ?";
   

    List<String> valores = [idAlumno, idTarea];

    var resultadoQuery = await queryBD(query, valores);

    return resultadoQuery;
  }

    Future<dynamic> UpdatePasos(
      List<CustomCardImageEditable> pasos) async {
    
    List<dynamic> valores;
    String query;
    var resultadoQuery;

    for (int i = 0; i < pasos.length; i++) {
      
      
      query =
        " UPDATE `pasos` SET URL_imagen = ?, Titulo = ?, Orden_paso = ? WHERE ID_paso = ?";    

      valores = [pasos[i].imageUrl, pasos[i].cardName, i, pasos[i].idPaso];

      resultadoQuery = await queryBD(query, valores);

      query = "INSERT into `tar_tiene_pas` (ID_tarea, ID_paso) values (?,?)";
      
    }

    return resultadoQuery;
  }

  

  




  Future<dynamic> pushPasos(
      List<CustomCardImageEditable> pasos, String idTarea) async {
    String idPaso;
    List<dynamic> valores;
    String query;
    var resultadoQuery;

    for (int i = 0; i < pasos.length; i++) {
      idPaso = 'pa_${DateTime.now()}';
      query =
          "INSERT into `pasos` (ID_paso, URL_imagen, Titulo, Orden_paso) values (?,?,?,?)";

      valores = [idPaso, pasos[i].imageUrl, pasos[i].cardName, i];

      resultadoQuery = await queryBD(query, valores);

      query = "INSERT into `tar_tiene_pas` (ID_tarea, ID_paso) values (?,?)";

      valores = [idTarea, idPaso];

      resultadoQuery = await queryBD(query, valores);
    }

    return resultadoQuery;
  }

  
}
