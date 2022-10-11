import 'package:flutter/material.dart';
import '../model/osModel.dart';
import 'package:camera/camera.dart';

import 'osExec.dart';


class OsDetail extends StatelessWidget {
  OsDetail({Key? key, required this.detail}) : super(key: key);
  final OSs detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O.S. ${detail.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:temP(detail),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.play_circle, size: 18),
                label: Text("INICIAR OS"), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OsExec(detail: detail)),
                );
              },
              )
            ]
        ),
      ),
    );
  }
}

Widget temP(OSs os) {
  List<String> OS_STATUS = ["A", "FA"];
  final Map Detail;

  Detail = os.toJson();

  if ((!OS_STATUS.contains(os.contratoStatus) || !OS_STATUS.contains(os.loginStatus)) && os.osAssuntoId != "5") {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Atenção !!!",
              style: TextStyle(fontSize: 26,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
              textAlign: TextAlign.center,
            ),
            const Text(
              "\nContrato / Login não esta ativo, entrar em contato com o setor de contratos!!!\n\n\nContrato:\n",
              style: TextStyle(fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto"),
              textAlign: TextAlign.center,
            ),
            Text(
              "Nome: ${os.razao}\nUsuário: ${os.login}\nSenha: ${os.senha}",
              style: const TextStyle(fontSize: 18.0,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto"),
            )
          ]
      ),
    );
  } else {
    return  ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            horizontalTitleGap: 5,
            contentPadding:EdgeInsets.all(0),
            leading: Icon(Icons.description, size: 40, color: Colors.blue),
            title: Text(Detail.keys.elementAt(6).toUpperCase(), style: TextStyle(color: Colors.blue)),
            subtitle: Text(Detail.values.elementAt(6), style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ),
        Card(
          child: ListTile(
              horizontalTitleGap: 5,
              contentPadding:EdgeInsets.all(0),
              leading: Icon(Icons.account_box, size: 40, color: Colors.blue),
              title: Text(Detail.keys.elementAt(12).toUpperCase(), style: TextStyle(color: Colors.blue)),
              subtitle: Text(Detail.values.elementAt(12), style: TextStyle(color: Colors.black))
          ),
        ),
        Card(
          child: ListTile(
              horizontalTitleGap: 5,
              contentPadding:EdgeInsets.all(0),
              leading: Icon(Icons.home, size: 40, color: Colors.blue),
              title: Text(Detail.keys.elementAt(7).toUpperCase(), style: TextStyle(color: Colors.blue)),
              subtitle: Text('${Detail.values.elementAt(7)}\n${Detail.values.elementAt(8)} - ${Detail.values.elementAt(9)}\n${Detail.values.elementAt(10)}', style: TextStyle(color: Colors.black))
          ),
        ),
        Card(
          child: ListTile(
              horizontalTitleGap: 5,
              contentPadding:EdgeInsets.all(0),
              leading: Icon(Icons.electrical_services, size: 40, color: Colors.blue),
              title: Text('CONEXÃO', style: TextStyle(color: Colors.blue)),
              subtitle: Text('Usúario: ${Detail.values.elementAt(15)}\nSenha: ${Detail.values.elementAt(16)}', style: TextStyle(color: Colors.black))
          ),
        ),
        Card(
          child: ListTile(
              horizontalTitleGap: 5,
              contentPadding:EdgeInsets.all(0),
              leading: Icon(Icons.task, size: 40, color: Colors.blue),
              title: Text('DESCRIÇÃO', style: TextStyle(color: Colors.blue)),
              subtitle: Text(Detail.values.elementAt(2), style: TextStyle(color: Colors.black))
          ),
        ),
      ],
    );
  }
}