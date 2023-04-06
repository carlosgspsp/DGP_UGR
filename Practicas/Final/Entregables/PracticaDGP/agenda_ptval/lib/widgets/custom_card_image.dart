import 'package:flutter/material.dart';

class CustomCardImage extends StatefulWidget {
  final String imageUrl;
  final String cardName;
  final String idPaso;

  const CustomCardImage(
      {Key? key, required this.imageUrl, required this.cardName, required this.idPaso})
      : super(key: key);

  @override
  State<CustomCardImage> createState() => _CustomCardImageState();
}

class _CustomCardImageState extends State<CustomCardImage> {
  @override
  Widget build(BuildContext context) {
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
            Image(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.fill,
              width: double.infinity,
              height: 800,
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
            Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Text(widget.cardName.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 55, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
