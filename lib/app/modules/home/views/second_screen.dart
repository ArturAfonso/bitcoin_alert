import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 151, 56),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Colors.grey[200]!,
        ])),
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          child: Column(
            children: const [
              Spacer(),
              Center(
                child: Text('Vindo da notificação'),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
