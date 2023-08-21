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
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20), // Define o raio de curvatura
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ));
  }
}
