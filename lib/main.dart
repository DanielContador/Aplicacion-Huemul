import 'dart:ui';

import 'package:flutter/material.dart';
//se reemplazó MyApp por MaterialApp, ya que permite utilizar otros Widgets
void main() {
  runApp(MaterialApp(
    home: PaginaBienvenida(),
  ));
}

class PaginaBienvenida extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //dentro del widget Scaffold, se puede anidar otros Widgets, es como el widget de base
      appBar: AppBar(
        title: Text("Huemul"),
        centerTitle: true,
        leading:
        IconButton(
            onPressed: null,
            icon:
            Image.network('https://media.licdn.com/dms/image/C4E0BAQGEl5jj-N2CQw/company-logo_200_200/0/1630601529912?e=2147483647&v=beta&t=6znabYsnflfc7HFJwL3GK0wsvYYKflF9bJSg4egIzew')),
      ),
      body: Center(
        child: Text("Bievenido a esta App de prueba",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaginaContenido()),
        );
      },
      child: Text('Click'),

      ),
    );
  }
}

class PaginaContenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //dentro del widget Scaffold, se puede anidar otros Widgets, es como el widget de base
      appBar: AppBar(
        title: Text("Huemul"),
        centerTitle: true,
        leading:
        IconButton(
            onPressed: null,
            icon:
            Image.network('https://media.licdn.com/dms/image/C4E0BAQGEl5jj-N2CQw/company-logo_200_200/0/1630601529912?e=2147483647&v=beta&t=6znabYsnflfc7HFJwL3GK0wsvYYKflF9bJSg4egIzew')),
      ),
      body: Center(
        child: Text("Contenido",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaginaBienvenida()),
          );
        },
        child: Text('Click'),

      ),
    );
  }

}