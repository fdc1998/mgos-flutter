import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../model/osModel.dart';

class CamPreview extends StatefulWidget {
  const CamPreview({Key? key}) : super(key: key);

  @override
  _CamPreviewState createState() => _CamPreviewState();
}

class _CamPreviewState extends State<CamPreview> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameras =await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState((){});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized){
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {

              },
              child:
              button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {cameraController.takePicture().then((XFile? file) {
                if (mounted) {
                  if (file != null) {
                    print('Foto salva em ${file.path}');
                  }
                }
              });
              },
              child:
              button(Icons.camera_alt_outlined , Alignment.bottomCenter),
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

Widget button(IconData icon, Alignment alignment ) {
  return Align(
    alignment: alignment,
    child: Container (
        margin: const EdgeInsets.only(
            left: 20,
            bottom: 20
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow (
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 10
              )
            ]
        ),
        child: const Center (
            child: Icon(
                Icons.flip_camera_ios_outlined,
                color: Colors.black54
            )
        )

    ),
  );
}

class OsInstall extends StatelessWidget {
  const OsInstall({Key? key, required this.detail}) : super(key: key);
  final OSs detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("detail.assunto)"),
        ),
        body: ListView(
          children: [
            Center (
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image.asset('assets/images/empty-image.png',
                      ),
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.camera, size: 18),
                        label: Text("CTO"), onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CamPreview()),
                      );
                    }
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image.asset('assets/images/empty-image.png',
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera, size: 18),
                      label: Text("SINAL CTO"), onPressed: () {
                    },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image.asset('assets/images/empty-image.png',
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera, size: 18),
                      label: Text("SINAL DROP"), onPressed: () {
                    },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image.asset('assets/images/empty-image.png',
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera, size: 18),
                      label: Text("ONU"), onPressed: () {
                    },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      Image.asset('assets/images/empty-image.png',
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera, size: 18),
                      label: Text("INSTAÇÃO"), onPressed: () {
                    },
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }
}
