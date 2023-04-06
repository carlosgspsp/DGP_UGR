
class MaterialClase {
  final String nombreMaterial;
  int cantidadMaterial;

  MaterialClase({
    required this.nombreMaterial,
    required this.cantidadMaterial,
  });

  factory MaterialClase.fromJson(Map<String, dynamic> json) {
    return MaterialClase(
      nombreMaterial: json['nombreMaterial'],
      cantidadMaterial: json['cantidadMaterial'],
    );
  }
}