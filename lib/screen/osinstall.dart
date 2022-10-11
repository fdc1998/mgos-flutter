import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class OsInstall extends StatefulWidget {
  const OsInstall({Key? key}) : super(key: key);

  @override
  State<OsInstall> createState() => _OsInstallState();
}


class _OsInstallState extends State<OsInstall> {
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
                    Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
                      fit:BoxFit.fill,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera, size: 18),
                    label: Text("CTO"), onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CameraPreview()),
                    // );
                  }
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                    Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
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
                    Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
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
                    Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
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
                    Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
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
