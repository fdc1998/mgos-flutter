// main.dart
import 'package:flutter/material.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert'; // for using json.decode()
import 'dart:developer' as developer;

void main() {
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The list that contains information about photos
  List _loadedPhotos = [];
  var texto1 = "";
  var texto2 = "";
  var texto3 = "";

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const apiUrl = 'http://apis.grupomg.net.br:8000/get_oss/43';

    HttpClient client = HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      _loadedPhotos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Column(
                children: <Widget>[
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
        body: SafeArea(
            child:
            ListView.separated(
              itemCount: _loadedPhotos.length,
              itemBuilder: (BuildContext ctx, index) {
                // developer.log(_loadedPhotos[index], name: 'DEBUG');
                if (_loadedPhotos[index]['login'] == null) {
                  texto1 = 'Local: ${_loadedPhotos[index]['estrutura_descricao']}';
                } else {
                  texto1 = 'Nome: ${_loadedPhotos[index]['razao']} \nEnd: ${_loadedPhotos[index]['endereco']} Bairro: ${_loadedPhotos[index]['bairro']}';
                }
                return ListTile(
                  title: Text(_loadedPhotos[index]['assunto'].toUpperCase(),
                    style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:
                      Text(texto1,
                        textAlign: TextAlign.left
                      ),
                );
              }, separatorBuilder: (BuildContext context, int index){
                return Divider();
            }
            )));
  }
}