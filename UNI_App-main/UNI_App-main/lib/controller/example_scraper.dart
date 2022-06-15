import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<List<Canteen>> fetchCanteen() async {
  List<Canteen> canteenList = [];

  final response = await http
      .get(Uri.parse('https://sigarra.up.pt/feup/pt/mob_eme_geral.cantinas'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var data = json.decode(response.body);

    canteenList.add(Canteen.fromJson(data[0]));
    canteenList.add(Canteen.fromJson(data[1]));
    canteenList.add(Canteen.fromJson(data[2]));
    canteenList.add(Canteen.fromJson(data[3]));
    canteenList.add(Canteen.fromJson(data[4]));
    canteenList.add(Canteen.fromJson(data[5]));

    return canteenList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Canteen');
  }
}

class Canteen {
  final String codigo;
  final String descricao;
  final String horario;
  final String ementas;

  const Canteen({
    @required this.codigo,
    @required this.descricao,
    @required this.horario,
    @required this.ementas,
  });

  factory Canteen.fromJson(Map<String, dynamic> json) {
    return Canteen(
      codigo: json['codigo'].toString(),
      descricao: json['descricao'].toString(),
      horario: json['horario'].toString(),
      ementas: json['ementas'].toString(),
    );
  }
}

/*class MenuInfo {
  final String data;
  final String carne;
  final String peixe;
  final String vegetariano;

  const MenuInfo({
    required this.data,
    required this.carne,
    required this.peixe,
    required this.vegetariano,
  });

  factory MenuInfo.fromJson(Map<String, dynamic> json) {
    return MenuInfo(
      data: json['data'].toString(),
      carne: json['carne'].toString(),
      peixe: json['peixe'].toString(),
      vegetariano: json['vegetariano'].toString(),

    );
  }
}

*/

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Canteen>> futurelistCanteen;

  @override
  void initState() {
    super.initState();
    futurelistCanteen = fetchCanteen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cantinas da FEUP'),
        ),
        body: Center(
          child: FutureBuilder<List<Canteen>>(
              future: futurelistCanteen,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  // return: show loading widget
                }
                if (snapshot.hasError) {
                  // return: show error widget
                }
                List<Canteen> canteens = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: canteens.length,
                    itemBuilder: (context, index) {
                      Canteen canteen = canteens[index];
                      return new ListTile(
                        leading: CircleAvatar(),
                        title: new Text(canteen.descricao),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
