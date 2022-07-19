import 'package:flutter/material.dart';
import 'network.dart';
import 'consstants.dart';

class PokeContent extends StatefulWidget {
  PokeContent(this.pokemonInput);

  String pokemonInput;

  @override
  State<PokeContent> createState() => _PokeContentState();
}

class _PokeContentState extends State<PokeContent> {
  dynamic pokeID = 'Not Found';
  dynamic pokeName = 'Not Found';
  dynamic pokeType = 'Not found';
  dynamic pokeHeight = 'Not found';
  dynamic pokeWeight = 'Not found';

  dynamic pokemonData;

  @override
  void initState() {
    super.initState();
    sendingURLtoAPI();
  }

  movePokemonId() async {
    var url = 'https://pokeapi.co/api/v2/pokemon/$pokeID';

    Network api = Network(url);

    pokemonData = await api.getData();

    setState(() {
      if (pokemonData != -1) {
        pokeID = pokemonData['id'];
        pokeName = pokemonData['forms'][0]['name'];
        pokeType = pokemonData['types'][0]['type']['name'];
        pokeHeight = pokemonData['height'];
        pokeHeight = pokeHeight / 10;
        pokeWeight = pokemonData['weight'];
        pokeWeight = pokeWeight / 10;
      } else {
        pokeID = 'Not Found';
        pokeName = 'Not Found';
        pokeType = 'Not found';
        pokeHeight = 'Not found';
        pokeWeight = 'Not found';
      }
      pokeName = pokeName.toUpperCase();
    });
    atualiza();
  }

  atualiza() {
    setState(() {
      if (pokemonData != -1) {
        pokeID = pokemonData['id'];
        pokeName = pokemonData['forms'][0]['name'];
        pokeType = pokemonData['types'][0]['type']['name'];
        pokeHeight = pokemonData['height'];
        pokeHeight = pokeHeight / 10;
        pokeWeight = pokemonData['weight'];
        pokeWeight = pokeWeight / 10;
      } else {
        pokeID = 'Not Found';
        pokeName = 'Not Found';
        pokeType = 'Not found';
        pokeHeight = 'Not found';
        pokeWeight = 'Not found';
      }
      pokeName = pokeName.toUpperCase();
    });
  }

  Future sendingURLtoAPI() async {
    setState(() async {
      var pokemonInput = widget.pokemonInput;

      if (pokemonInput == null) {
        pokemonInput = '1';
      }

      pokemonInput = pokemonInput.toLowerCase();

      var url = 'https://pokeapi.co/api/v2/pokemon/$pokemonInput';

      Network api = Network(url);
      pokemonData = await api.getData();

      if (pokemonData != -1) {
        pokeID = pokemonData['id'];
        pokeName = pokemonData['forms'][0]['name'];
        pokeType = pokemonData['types'][0]['type']['name'];
        pokeHeight = pokemonData['height'];
        pokeHeight = pokeHeight / 10;
        pokeWeight = pokemonData['weight'];
        pokeWeight = pokeWeight / 10;
      } else {
        pokeID = 'Not Found';
        pokeName = 'Not Found';
        pokeType = 'Not found';
        pokeHeight = 'Not found';
        pokeWeight = 'Not found';
      }

      pokeName = pokeName.toUpperCase();

      //print(pokemonData);
      print(pokeID);
      print(pokeName);
      print(pokeType);

      atualiza(); // Não sei pq nao atualizava, mas miguelei forçando com esse método
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      appBar: AppBar(
        title: Text(
          'Pokédex',
          style: estiloPokeTitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Image.asset('images/arrow_left.png'),
                            iconSize: 20,
                            onPressed: () {
                              pokeID = pokeID - 1;
                              movePokemonId();
                            },
                          ),
                          IconButton(
                            icon: Image.asset('images/arrow_right.png'),
                            iconSize: 20,
                            onPressed: () {
                              pokeID = pokeID + 1;
                              movePokemonId();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'This is your Pokémon:',
                        style: estiloResult,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        pokeName,
                        style: estiloPoke,
                      ),
                      if (pokeID != 'Not Found')
                        Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokeID.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      if (pokeID == 'Not Found')
                        Image.asset(
                          'images/sory.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Pokémon Number: $pokeID\n',
                        style: estiloPokeNumber,
                      ),
                      Text(
                        'Type: $pokeType\n',
                        style: estiloPokeType,
                      ),
                      Text(
                        'Height: $pokeHeight meters.\n\nWeight: $pokeWeight kg.',
                        style: estiloPokeData,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
