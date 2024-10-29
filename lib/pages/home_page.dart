import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpwa;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List pokedex = [];
  dynamic color(index) {
    dynamic setColor;
    switch (pokedex[index]["type"][0]) {
      case "Grass":
        setColor = Colors.greenAccent;
        break;
      case "Fire":
        setColor = Colors.redAccent;
        break;
      case "Water":
        setColor = Colors.blueAccent;
        break;
      case "Poisson":
        setColor = Colors.deepPurpleAccent;
        break;
      case "Electric":
        setColor = Colors.amber;
        break;
      case "Rock":
        setColor = Colors.grey;
        break;
      case "Ground":
        setColor = Colors.brown;
        break;
      case "Psychic":
        setColor = Colors.indigoAccent;
        break;
      case "Fighting":
        setColor = Colors.orange;
        break;
      case "Bug":
        setColor = Colors.lightGreenAccent;
        break;
      case "Ghost":
        setColor = Colors.deepPurple;
        break;
      case "Normal":
        setColor = Colors.white54;
        break;
      default:
        setColor = Colors.pinkAccent;
        break;
    }
    return setColor;
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fecthPokeApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 180, 71, 44),
        Color.fromARGB(255, 29, 26, 26),
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
      child: Stack(
        children: [
          Positioned(
              top: -80,
              right: -180,
              child: Image.asset(
                "assets/Pokeball.png",
                width: 370,
                fit: BoxFit.fitWidth,
              )),
          const Positioned(
              top: 100,
              left: 20,
              child: Text(
                "Pokedex",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              )),
          Positioned(
              top: 150,
              bottom: 0,
              width: width,
              child: Column(
                children: [
                  pokedex != null
                      ? Expanded(
                          child: GridView.builder(
                              itemCount: pokedex.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: InkWell(
                                    child: SafeArea(
                                        child: Stack(
                                      children: [
                                        Container(
                                          width: width,
                                          margin: EdgeInsets.only(top: 80),
                                          decoration: const BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  top: 90,
                                                  left: 15,
                                                  child: Text(
                                                    pokedex[index]["num"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 128, 64, 48)),
                                                  )),
                                              Positioned(
                                                  top: 130,
                                                  left: 15,
                                                  child: Text(
                                                      pokedex[index]["name"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white54))),
                                              Positioned(
                                                  top: 170,
                                                  left: 15,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 10,
                                                        left: 10,
                                                        top: 10,
                                                        bottom: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: Colors.black
                                                            .withOpacity(0.5)),
                                                    child: Text(
                                                        pokedex[index]["type"]
                                                            [0],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: color(index),
                                                            shadows: [
                                                              BoxShadow(
                                                                  color: color(
                                                                      index),
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  spreadRadius:
                                                                      1.0,
                                                                  blurRadius:
                                                                      15)
                                                            ])),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: CachedNetworkImage(
                                            imageUrl: pokedex[index]["img"],
                                            height: 180,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3 / 5)))
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ))
        ],
      ),
    ));
  }

  void fecthPokeApi() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGo-Pokedex/master/pokedex.json");
    httpwa.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data["pokemon"];
      }
      setState(() {});
      print(pokedex);
    });
  }
}
