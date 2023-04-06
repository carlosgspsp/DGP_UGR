import 'package:agenda_ptval/screens/screens.dart';
import 'package:agenda_ptval/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagenesFeedbackScreen extends StatefulWidget {
  @override
  State<ImagenesFeedbackScreen> createState() => _ImagenesFeedbackScreenState();
}

class _ImagenesFeedbackScreenState extends State<ImagenesFeedbackScreen> {
  final List<String> _imagenesfeedback = [
    "https://www.lavanguardia.com/files/og_thumbnail/uploads/2020/10/26/5fb286e277293.jpeg",
    "https://img.freepik.com/foto-gratis/chico-alegre-feliz-mostrando-gesto-bien_74855-3502.jpg?w=2000",
    "https://www.lavanguardia.com/files/og_thumbnail/uploads/2020/10/26/5fb286e277293.jpeg",
    "https://img.freepik.com/foto-gratis/chico-alegre-feliz-mostrando-gesto-bien_74855-3502.jpg?w=2000",
    "https://www.lavanguardia.com/files/og_thumbnail/uploads/2020/10/26/5fb286e277293.jpeg",
    "https://img.freepik.com/foto-gratis/chico-alegre-feliz-mostrando-gesto-bien_74855-3502.jpg?w=2000",
    "https://www.lavanguardia.com/files/og_thumbnail/uploads/2020/10/26/5fb286e277293.jpeg",
    "https://img.freepik.com/foto-gratis/chico-alegre-feliz-mostrando-gesto-bien_74855-3502.jpg?w=2000",
    "https://www.lavanguardia.com/files/og_thumbnail/uploads/2020/10/26/5fb286e277293.jpeg",
    "https://cpad.ask.fm/436/914/696/-119996999-1t3k859-k9cqsktbtlnpm6k/original/Fallout_3_Vault_Boy.png",
    "https://cpad.ask.fm/436/914/696/-119996999-1t3k859-k9cqsktbtlnpm6k/original/Fallout_3_Vault_Boy.png",
    "https://cpad.ask.fm/436/914/696/-119996999-1t3k859-k9cqsktbtlnpm6k/original/Fallout_3_Vault_Boy.png",
    "https://cpad.ask.fm/436/914/696/-119996999-1t3k859-k9cqsktbtlnpm6k/original/Fallout_3_Vault_Boy.png",
    "https://cpad.ask.fm/436/914/696/-119996999-1t3k859-k9cqsktbtlnpm6k/original/Fallout_3_Vault_Boy.png",
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        /* leading: const IconButton(
          Icons.arrow_back,
          size: 40, icon: Icons.arrow_back,
        ),*/

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),

        /*title: const Center(
            //TITULOOO
            child: Text("FEEDBACK", style: TextStyle(fontSize: 40))),*/
        title: const Text(
          "IMAGENES FEEDBACK",
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: const Color(0xFF1BDAF1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              GridView.count(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: [
                  for (var url in _imagenesfeedback)
                    InkWell(
                        child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(url),
                                backgroundColor: Colors.transparent,
                              ),
                            ]),
                        onTap: () async {
                          Navigator.maybePop(context, url);
                        }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
