import 'package:flutter/material.dart';
import '../model/osModel.dart';
import 'osinstall.dart';




class OsExec extends StatelessWidget {
  OsExec({Key? key, required this.detail}) : super(key: key);
  final OSs detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O.S. ${detail.id}'),
      ),
      body: OsInstall(),
    );
  }
}