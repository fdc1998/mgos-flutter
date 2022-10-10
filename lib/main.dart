// main.dart
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert';

class OSs {
  OSs({
    required this.data,
    required this.id,
    required this.msg,
    required this.estrutura,
    required this.estruturaDescricao,
    required this.osAssuntoId,
    required this.assunto,
    required this.endereco,
    required this.bairro,
    required this.cidade,
    required this.complemento,
    required this.referencia,
    required this.razao,
    required this.cnpjCpf,
    required this.contratoStatus,
    required this.loginStatus,
    required this.login,
    required this.senha,
  });

  String data;
  String id;
  String msg;
  String estrutura;
  String estruturaDescricao;
  String osAssuntoId;
  String assunto;
  String endereco;
  String bairro;
  String cidade;
  String complemento;
  String referencia;
  String razao;
  String cnpjCpf;
  String contratoStatus;
  String loginStatus;
  String login;
  String senha;

  factory OSs.fromJson(Map<String, dynamic> json) => OSs(
    data: json["data"],
    id: json["id"],
    msg: json["msg"],
    estrutura: json["estrutura"],
    estruturaDescricao: json["estrutura_descricao"],
    osAssuntoId: json["os_assunto_id"],
    assunto: json["assunto"],
    endereco: json["endereco"],
    bairro: json["bairro"],
    cidade: json["cidade"],
    complemento: json["complemento"],
    referencia: json["referencia"],
    razao: json["razao"],
    cnpjCpf: json["cnpj_cpf"],
    contratoStatus: json["contrato_status"],
    loginStatus: json["login_status"],
    login: json["login"],
    senha: json["senha"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "id": id,
    "msg": msg,
    "estrutura": estrutura,
    "estrutura_descricao": estruturaDescricao,
    "os_assunto_id": osAssuntoId,
    "assunto": assunto,
    "endereco": endereco,
    "bairro": bairro,
    "cidade": cidade,
    "complemento": complemento,
    "referencia": referencia,
    "razao": razao,
    "cnpj_cpf": cnpjCpf,
    "contrato_status": contratoStatus,
    "login_status": loginStatus,
    "login": login,
    "senha": senha,
  };
}


Future<List<OSs>> _fetchData() async {
  List<OSs> oSsFromJson(String str) => List<OSs>.from(json.decode(str).map((x) => OSs.fromJson(x)));

  const apiUrl = 'http://apis.grupomg.net.br:8000/get_oss/108';

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
      return const Icon(Icons.report_problem, size: 40);
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

  Color colorOs (List index) {
    if ((!OS_STATUS.contains(index[0]) || !OS_STATUS.contains(index[1])) && index[2] != "5") {
      return Colors.red;
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
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {

                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OsDetail(detail: snapshot.data[index])),
                        );
                      },
                      title: Text(snapshot.data[index]['assunto'].toUpperCase(), style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: colorOs([snapshot.data[index]['contrato_status'], snapshot.data[index]['login_status'], snapshot.data[index]['os_assunto_id']]),
                      ),
                      ),
                      leading: invalidOs([snapshot.data[index]['contrato_status'], snapshot.data[index]['login_status'], snapshot.data[index]['os_assunto_id']]),
                      subtitle: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: snapshot.data[index]['razao'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              TextSpan(
                                  text: '\n${snapshot.data[index]['endereco']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                              TextSpan(
                                text: '\n${snapshot.data[index]['bairro']} - ${snapshot.data[index]['cidade']}',
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


class OsDetail extends StatelessWidget {
  OsDetail({Key? key, required this.detail}) : super(key: key);
  final Map detail;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('O.S. ${detail['id']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(detail['msg']),
      ),
    );
  }
}
