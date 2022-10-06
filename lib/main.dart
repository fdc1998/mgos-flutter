// main.dart
import 'package:flutter/material.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert'; // for using json.decode()
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
  var txtNome = "";
  var txtEnd = "";
  var txtBairro = "";
  var txtCidade = "";

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
        body: SafeArea(
            child:
            ListView.builder(
              padding: EdgeInsets.only(top:5, left: 5,right: 5),
              itemCount: _loadedPhotos.length,
              itemBuilder: (BuildContext ctx, index) {
                if (_loadedPhotos[index]['login'] == null) {
                  texto1 = 'Local: ${_loadedPhotos[index]['estrutura_descricao']}';
                } else {
                  txtNome = _loadedPhotos[index]['razao'];
                  txtEnd = _loadedPhotos[index]['endereco'];
                  txtBairro = _loadedPhotos[index]['bairro'];
                  txtCidade = _loadedPhotos[index]['cidade'];
                }
                return Card(
                    child: ListTile(
                  tileColor: HexColor("#f2f2f2"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OsDetail(detail: _loadedPhotos[index])),
                    );
                  },
                  title: Text(_loadedPhotos[index]['assunto'].toUpperCase(),
                    style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: txtNome,
                              style: GoogleFonts.mPlusRounded1c(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                        ),
                        const TextSpan(
                            text: "\nEnd: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        TextSpan(
                          text: txtEnd,
                        ),
                        const TextSpan(
                            text: "\nBairro: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        TextSpan(
                          text: txtBairro,
                        ),
                        const TextSpan(
                            text: "\nCidade: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        TextSpan(
                          text: txtCidade,
                        ),
                      ],
                  ),
                  )

                ),
                );
              },
            )));
  }
}

class Detail {
  String? data;
  String? id;
  String? msg;
  String? estrutura;
  String? estruturaDescricao;
  String? osAssuntoId;
  String? assunto;
  String? endereco;
  String? bairro;
  String? cidade;
  String? complemento;
  String? referencia;
  String? razao;
  String? cnpjCpf;
  String? contratoStatus;
  String? loginStatus;
  String? login;
  String? senha;

  Detail(
      {this.data,
        this.id,
        this.msg,
        this.estrutura,
        this.estruturaDescricao,
        this.osAssuntoId,
        this.assunto,
        this.endereco,
        this.bairro,
        this.cidade,
        this.complemento,
        this.referencia,
        this.razao,
        this.cnpjCpf,
        this.contratoStatus,
        this.loginStatus,
        this.login,
        this.senha});

  Detail.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    id = json['id'];
    msg = json['msg'];
    estrutura = json['estrutura'];
    estruturaDescricao = json['estrutura_descricao'];
    osAssuntoId = json['os_assunto_id'];
    assunto = json['assunto'];
    endereco = json['endereco'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    complemento = json['complemento'];
    referencia = json['referencia'];
    razao = json['razao'];
    cnpjCpf = json['cnpj_cpf'];
    contratoStatus = json['contrato_status'];
    loginStatus = json['login_status'];
    login = json['login'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['id'] = this.id;
    data['msg'] = this.msg;
    data['estrutura'] = this.estrutura;
    data['estrutura_descricao'] = this.estruturaDescricao;
    data['os_assunto_id'] = this.osAssuntoId;
    data['assunto'] = this.assunto;
    data['endereco'] = this.endereco;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['complemento'] = this.complemento;
    data['referencia'] = this.referencia;
    data['razao'] = this.razao;
    data['cnpj_cpf'] = this.cnpjCpf;
    data['contrato_status'] = this.contratoStatus;
    data['login_status'] = this.loginStatus;
    data['login'] = this.login;
    data['senha'] = this.senha;
    return data;
  }
}

class OsDetail extends StatelessWidget {
  const OsDetail({super.key, required this.detail});

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.assunto.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("OsDetail"),
      ),
    );
  }
}
