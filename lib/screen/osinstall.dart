
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OsInstall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name'),
      ),
      body: Center (
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                Image.file(File('/data/user/0/com.mgnet.mgos.mgos/cache/CAP4109344986767009233.jpg'),
                ),
              ),
          ]
      ),
      ),
    );
  }
}
