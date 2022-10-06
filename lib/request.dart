// main.dart
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}


// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));
//
// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
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

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    data: json["data"] == null ? null : json["data"],
    id: json["id"] == null ? null : json["id"],
    msg: json["msg"] == null ? null : json["msg"],
    estrutura: json["estrutura"] == null ? null : json["estrutura"],
    estruturaDescricao: json["estrutura_descricao"] == null ? null : json["estrutura_descricao"],
    osAssuntoId: json["os_assunto_id"] == null ? null : json["os_assunto_id"],
    assunto: json["assunto"] == null ? null : json["assunto"],
    endereco: json["endereco"] == null ? null : json["endereco"],
    bairro: json["bairro"] == null ? null : json["bairro"],
    cidade: json["cidade"] == null ? null : json["cidade"],
    complemento: json["complemento"] == null ? null : json["complemento"],
    referencia: json["referencia"] == null ? null : json["referencia"],
    razao: json["razao"] == null ? null : json["razao"],
    cnpjCpf: json["cnpj_cpf"] == null ? null : json["cnpj_cpf"],
    contratoStatus: json["contrato_status"] == null ? null : json["contrato_status"],
    loginStatus: json["login_status"] == null ? null : json["login_status"],
    login: json["login"] == null ? null : json["login"],
    senha: json["senha"] == null ? null : json["senha"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
    "id": id == null ? null : id,
    "msg": msg == null ? null : msg,
    "estrutura": estrutura == null ? null : estrutura,
    "estrutura_descricao": estruturaDescricao == null ? null : estruturaDescricao,
    "os_assunto_id": osAssuntoId == null ? null : osAssuntoId,
    "assunto": assunto == null ? null : assunto,
    "endereco": endereco == null ? null : endereco,
    "bairro": bairro == null ? null : bairro,
    "cidade": cidade == null ? null : cidade,
    "complemento": complemento == null ? null : complemento,
    "referencia": referencia == null ? null : referencia,
    "razao": razao == null ? null : razao,
    "cnpj_cpf": cnpjCpf == null ? null : cnpjCpf,
    "contrato_status": contratoStatus == null ? null : contratoStatus,
    "login_status": loginStatus == null ? null : loginStatus,
    "login": login == null ? null : login,
    "senha": senha == null ? null : senha,
  };
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
      return Icon(Icons.report_problem, size: 40);
    } else if (['50', "19", "13"].contains(index[2])) {
      return Icon(Icons.router, size: 40, color: Colors.cyan);
    } else if (index[2] == "1") {
      return Icon(Icons.assignment, size: 40, color: Colors.green);
    } else if (["10", "11"].contains(index[2])) {
      return Icon(Icons.published_with_changes, size: 40, color: Colors.deepPurple);
    } else if (["44", "5"].contains(index[2])) {
      return Icon(Icons.recycling, size: 40, color: Colors.amber);
    }
    return Icon(Icons.build, size: 40, color: Colors.red);
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
    }
    return Colors.black;;
  }

  Future<void> _fetchData() async {
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
      return jsonDecode(content);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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
                final status_contract = snapshot.data[index]['contrato_status'];
                final status_login = snapshot.data[index]['login_status'];
                final assunto_id = snapshot.data[index]['os_assunto_id'];
                
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
  const OsDetail({Key? key, required this.detail}) : super(key: key);
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