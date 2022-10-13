import 'dart:core';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert';
import '../model/osModel.dart';
import 'osdetail.dart';

List<CameraDescription> cameras = [];


Future<List<OSs>> fetchData() async {
  List<OSs> oSsFromJson(String str) => List<OSs>.from(json.decode(str).map((x) => OSs.fromJson(x)));

  const apiUrl = 'http://apis.grupomg.net.br:8000/get_oss/76';

  HttpClient client = HttpClient();
  client.autoUncompress = true;

  final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
  request.headers
      .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  final HttpClientResponse response = await request.close();

  final String content = await response.transform(utf8.decoder).join();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return jsonDecode(content);
    final oSs = oSsFromJson(content);
    return(oSs);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

late List<CameraDescription> _cameras;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Kindacode.com',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> OS_STATUS = ["A", "FA"];

  Icon invalidOs (List index) {
    if ((!OS_STATUS.contains(index[0]) || !OS_STATUS.contains(index[1])) && index[2] != "5") {
      return const Icon(Icons.report_problem, size: 40, color: Colors.black);
    } else if (['50', "19", "13"].contains(index[2])) {
      return const Icon(Icons.router, size: 40, color: Colors.cyan);
    } else if (index[2] == "1") {
      return const Icon(Icons.assignment, size: 40, color: Colors.green);
    } else if (["10", "11"].contains(index[2])) {
      return const Icon(Icons.published_with_changes, size: 40, color: Colors.deepPurple);
    } else if (["44", "5"].contains(index[2])) {
      return const Icon(Icons.recycling, size: 40, color: Colors.amber);
    }
    return const Icon(Icons.build, size: 40, color: Colors.red);
  }

  Color colorTile (List index) {
    if ((!OS_STATUS.contains(index[0]) || !OS_STATUS.contains(index[1])) && index[2] != "5") {
      return Colors.yellow;
  } else {
      return Colors.white;
    }
  }

  Color colorOs (List index) {
    if ((!OS_STATUS.contains(index[0]) || !OS_STATUS.contains(index[1])) && index[2] != "5") {
      return Colors.black;
    } else if (["50", "19", "13"].contains(index[2])) {
      return Colors.cyan;
    } else if (index[2] == "1") {
      return Colors.green;
    } else if (["10", "11"].contains(index[2])) {
      return Colors.deepPurple;
    } else if (["2", "3"].contains(index[2])) {
      return Colors.deepOrangeAccent;
    } else if (["44", "5"].contains(index[2])) {
      return Colors.amber;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Column(
              children: const <Widget>[
                Text('MGOS',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text("Olá Jefferson",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ]
          )
      ),
      body:FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                
                return Card(
                  child: ListTile(
                    tileColor: colorTile([snapshot.data[index].contratoStatus, snapshot.data[index].loginStatus, snapshot.data[index].osAssuntoId]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OsDetail(detail: snapshot.data[index])),
                        );
                      },
                      title: Text(snapshot.data[index].assunto.toUpperCase(), style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colorOs([snapshot.data[index].contratoStatus, snapshot.data[index].loginStatus, snapshot.data[index].osAssuntoId]),
                      ),
                      ),
                      leading: invalidOs([snapshot.data[index].contratoStatus, snapshot.data[index].loginStatus, snapshot.data[index].osAssuntoId]),
                      subtitle: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: snapshot.data[index].razao,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              TextSpan(
                                  text: '\n${snapshot.data[index].endereco}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                              TextSpan(
                                text: '\n${snapshot.data[index].bairro} - ${snapshot.data[index].cidade}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ]
                        ),
                      )
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


