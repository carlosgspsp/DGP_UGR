import 'package:flutter/material.dart';

class CustomCardImageEditable extends StatefulWidget {
  String imageUrl;
  String cardName;
  String idPaso;

  CustomCardImageEditable(
      {Key? key, required this.imageUrl, required this.cardName, required this.idPaso})
      : super(key: key);

  @override
  State<CustomCardImageEditable> createState() =>
      _CustomCardImageEditableState();
}

class _CustomCardImageEditableState extends State<CustomCardImageEditable> {
  late TextEditingController _textDialogController;
  String newURL = '';

  @override
  void initState() {
    super.initState();
    _textDialogController = TextEditingController();
  }

  @override
  void dispose() {
    _textDialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> openDialogImage() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Cambiar imagen'),
              content: TextField(
                keyboardType: TextInputType.url,
                controller: _textDialogController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: 'Ingrese la URL de la imagen'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(_textDialogController.text),
                  child: const Text('Aceptar'),
                ),
              ],
            ));

    Future<String?> openDialogDescripcion() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Cambiar descripción del paso'),
              content: TextField(
                keyboardType: TextInputType.url,
                controller: _textDialogController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: 'Ingrese la descripción del paso en la tarea'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(_textDialogController.text),
                  child: const Text('Aceptar'),
                ),
              ],
            ));

    return Card(
      // * To have rounded border in all children, set clipBehavior property
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      // To have more rounded borders, use shape property
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          if (widget.imageUrl.isNotEmpty)
            // * Widget that can contain an image. The image can take a while to render from the Internet
            InkWell(
              child: Image(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.fill,
                width: double.infinity,
                height: 900,
              ),
              onTap: () async {
                final newURL = await openDialogImage();
                if (newURL == null || newURL.isEmpty) {
                  return;
                }
                setState(() {
                  widget.imageUrl = newURL;
                });
                print(widget.imageUrl);
              },
            ),

          if (widget.imageUrl.isEmpty)
            Column(
              children: const [
                Icon(Icons.image, size: 200),
                Text("Elige una imagen",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ],
            ),
          // * Image with a placeholder that displays while the image is loading
          // FadeInImage(
          //   image: NetworkImage(imageUrl),
          //   placeholder: const AssetImage('assets/images/jar-loading.gif'),
          //   width: double.infinity,
          //   height: 230,
          //   fit: BoxFit.cover,
          //   fadeInDuration: const Duration(milliseconds: 300),
          // ),

          if (widget.cardName != null)
            InkWell(
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                child: Text(widget.cardName,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
              ),
              onTap: () async {
                final newDescription = await openDialogDescripcion();
                if (newDescription == null || newDescription.isEmpty) {
                  return;
                }
                setState(() {
                  widget.cardName = newDescription.toUpperCase();
                });
              },
            ),
        ],
      ),
    );
  }
}
