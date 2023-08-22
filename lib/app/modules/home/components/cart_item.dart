// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  const CardItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 3, 62, 255), Color.fromARGB(255, 228, 167, 0)], // Cores do gradiente
            begin: Alignment.topLeft, // Ponto de início do gradiente
            end: Alignment.bottomRight, // Ponto de término do gradiente
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(20), // Define o raio de curvatura
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ));
  }
}
