import 'dart:ui';

import 'package:flutter/material.dart';
//se reemplazó MyApp por MaterialApp, ya que permite utilizar otros Widgets
void main() {
  runApp(MaterialApp(
    home: PaginaBienvenida(),
  ));
}

class PaginaBienvenida extends StatefulWidget {
  @override
  _PaginaBienvenidaState createState() => _PaginaBienvenidaState();
}

class _PaginaBienvenidaState extends State<PaginaBienvenida>{
  String paginaSeleccionada = 'Bienvenida';


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
            Image.network('https://media.licdn.com/dms/image/C4E0BAQGEl5jj-N2CQw/company-logo_200_200/0/1630601529912?e=2147483647&v=beta&t=6znabYsnflfc7HFJwL3GK0wsvYYKflF9bJSg4egIzew')
        ),
        actions: [
          // Dropdown menu in the AppBar
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            items: <String>['Bienvenida', 'Datos', 'Pagina 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Bienvenido a esta App de prueba",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          SizedBox(height: 20), // Add some spacing between the text and the button
          Center(
            child: SizedBox(
              width: 200, // Set the width as needed
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaContenido()),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios), // Replace with your desired icon
                label: Text('Comenzar'),
              ),
            ),
          ),
        ],
      ),

    );
  }
}


//Función para navegar a la pagina seleccionada

void navegarPaginaSeleccionada(String paginaSeleccionada, context){
  switch (paginaSeleccionada){
    case 'Bienvenida':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaBienvenida()),
      );
      break;
    case 'Datos':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaContenido()),
      );
      break;
    case 'Pagina 3':
    //ir a la pagina 3
      break;
  }
}
class PaginaContenido extends StatefulWidget {
  @override
  _StatePaginaContenido createState() => _StatePaginaContenido();
}

class _StatePaginaContenido extends State<PaginaContenido>{
  String paginaSeleccionada = 'Datos';
  //estructura para almacenar los datos
  List<Item> items = [];

  //Controladores para los los campos de texto

  TextEditingController controladorID = TextEditingController();
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorDescripcion = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Huemul"),
        centerTitle: true,
        leading:
        IconButton(
            onPressed: null,
            icon:
            Image.network('https://media.licdn.com/dms/image/C4E0BAQGEl5jj-N2CQw/company-logo_200_200/0/1630601529912?e=2147483647&v=beta&t=6znabYsnflfc7HFJwL3GK0wsvYYKflF9bJSg4egIzew')
        ),
        actions: [
          // Dropdown menu in the AppBar
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            items: <String>['Bienvenida', 'Datos', 'Pagina 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Formulario para el ingreso de datos
            TextField(
              controller: controladorID,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: controladorNombre,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: controladorDescripcion,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Añadir items a la lista
                addItem();
              },
              child: Text('Agregar Item'),
            ),
            SizedBox(height: 20),
            // Lista para mostrar los items existentes
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('ID: ${items[index].id}, Nombre: ${items[index].nombre}, Descripcion: ${items[index].descripcion}'),
                    // Add more functionality as needed, e.g., edit or delete items
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaginaBienvenida()),
          );
        },
        child: Icon(Icons.home),

      ),
    );
  }

  // Function to add an item to the list
  void addItem() {
    setState(() {
      Item newItem = Item(
        id: controladorID.text,
        nombre: controladorNombre.text,
        descripcion: controladorDescripcion.text,
      );

      items.add(newItem);

      // Clear text field controllers after adding item
      controladorID.clear();
      controladorNombre.clear();
      controladorDescripcion.clear();
    });
  }
/**
 **/
}



//crear la clase para almacenar los items
class Item {
  final String id;
  final String nombre;
  final String descripcion;

  Item({required this.id, required this.nombre, required this.descripcion});
}