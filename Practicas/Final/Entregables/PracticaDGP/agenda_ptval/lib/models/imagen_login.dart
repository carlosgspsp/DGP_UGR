
class ImagenLogin {
  final String imagen;
  final int idImagen;

  ImagenLogin({
    required this.imagen,
    required this.idImagen,
  });

  // Convertir un objeto JSON en un objeto ImagenLogin
  factory ImagenLogin.fromJson(Map<String, dynamic> json) {
    return ImagenLogin(
      imagen: 'https://static.arasaac.org/pictograms/' + json['_id'].toString() + '/' + json['_id'].toString() + '_300.png',
      idImagen: json['_id'],
    );
  }
}