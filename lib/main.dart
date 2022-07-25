import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'sreen2.dart';
import 'consstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red[700],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Pokédex',
          style: estiloPokeTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Screen1(),
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  late String pokemonInput = '1';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.0,
          ),
          Image.asset(
            'images/Button_Icon_Blue.svg.png',
            scale: 12,
          ),
          SizedBox(
            height: 70.0,
          ),
          Center(
            child: Text(
              'FIND YOUR POKÉMON\n\n',
              style: findPoke,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              'Write a pokémon name or number:',
              style: writeName,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter(
                  RegExp("[A-Za-z0-9 ]"),
                  allow: true,
                ),
              ],
              scrollPadding: EdgeInsets.only(bottom: 140),
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                pokemonInput = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.orange,
                hintText: 'Ex: Bulbasaur',
                hintStyle: TextStyle(
                  color: Colors.white60,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PokeContent(pokemonInput);
                    },
                  ),
                );
              },
              child: Text(
                'Search Pokémon',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
