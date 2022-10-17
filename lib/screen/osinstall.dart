
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../model/osModel.dart';
import '../screen/oss.dart';
import 'dart:async';
import 'dart:io';


class CamPreview extends StatefulWidget {
  const CamPreview({Key? key}) : super(key: key);

  @override
  _CamPreviewState createState() => _CamPreviewState();
}

class _CamPreviewState extends State<CamPreview> {
  // late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  void startCamera(int direction) async {
    // cameras = await availableCameras();

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
              onTap: () {cameraController.takePicture().then((XFile? file) {
                if (mounted) {
                  if (file != null) {
                    print('Foto salva em ${file.path}');
                    Navigator.pop(context, file.path);
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
            right: 20,
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
                Icons.camera_alt_outlined,
                color: Colors.black54
            )
        )
    ),
  );
}


class OsInstall extends StatefulWidget {
  const OsInstall({Key? key, required this.detail}) : super(key: key);
  final OSs detail;

  @override
  State<OsInstall> createState() => _OsInstallState();
}

class _OsInstallState extends State<OsInstall> {
  late String _imageToShow;
  late String _cto_img;
  late String _cto_sig_img;

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   print(directory.toString());
  //   return directory.path;
  // }
  //
  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   print(path.toString());
  //   return File('$path/empty-image.png');
  // }
  //
  // Future<String> readCounter() async {
  //   final file = await _localFile;
  //   print(file.path);
  //     // return int.parse(contents);
  //   return file.path;
  // }

  @override
  initState(){
    // image_file = readCounter() as String?;
    // _imageToShow = '/data/user/0/com.mgnet.mgos.mgos/app_flutter/empty-image.png';
    _cto_sig_img = '';
    _cto_img = '';
    // readCounter().then((value) {
    //   setState(() {
    //     image_file = value;
    //     print(image_file);
    //   });
    // });
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
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
                      img(_cto_img),
                    ),
                    ElevatedButton.icon(
                        icon: Icon(Icons.camera, size: 18),
                        label: Text("CTO"), onPressed: () {
                      _navigateAndDisplaySelection(context, "cto");
                    }
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                      img(_cto_sig_img),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera, size: 18),
                      label: Text("SINAL CTO"), onPressed: (){
                      _navigateAndDisplaySelection(context, "cto_sig");

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
        );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context, String name) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CamPreview()),
    );
    if (!mounted) return;
    _imageToShow = result;
    setState ((){
      if (name == 'cto') {
        _cto_img = result;
      } else if (name == 'cto_sig') {
        _cto_sig_img = result;
      }
    });
    print('Get path image ${result}, ${name}');
  }
}
 Widget img(String image) {
  if (image != '') {
    return Image.file(File(image));
  } else {
    return Image.asset('assets/images/empty-image.png');
   }
 }