import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

//se reemplazó MyApp por MaterialApp, ya que permite utilizar otros Widgets
void main() {
  runApp(MaterialApp(
    home: PaginaBienvenida(),
  ));

}
List<Item> items = [];
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
            items: <String>['Bienvenida', 'Datos', 'Listar', 'Api']
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
    case 'Listar':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaListar()),
      );
      break;
    case 'Api':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaApi()),
      );
      break;
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
            items: <String>['Bienvenida', 'Datos', 'Listar', 'Api']
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
//agregar aqui
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(items[index].id), // Use a unique key for each item
                    onDismissed: (direction) {
                      // Remove the item from the list when dismissed
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red, // Background color when swiping to delete
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text('ID: ${items[index].id}, Nombre: ${items[index].nombre}, Descripcion: ${items[index].descripcion}'),
                      // Add more functionality as needed, e.g., edit or other actions
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Manually trigger deletion when the delete button is pressed
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                      ),
                    ),
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
            MaterialPageRoute(builder: (context) => PaginaListar()),
          );
        },
        child: Icon(Icons.arrow_forward_ios),

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

class PaginaListar extends StatefulWidget {
  @override
  _PaginaListarState createState() => _PaginaListarState();
}

class _PaginaListarState extends State<PaginaListar>{
  String paginaSeleccionada = 'Listar';


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
            items: <String>['Bienvenida', 'Datos', 'Listar', 'Api']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),



//insetar body con listar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Lista para mostrar los items existentes
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(items[index].id), // Use a unique key for each item
                    onDismissed: (direction) {
                      // Remove the item from the list when dismissed
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red, // Background color when swiping to delete
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text('ID: ${items[index].id}, Nombre: ${items[index].nombre}, Descripcion: ${items[index].descripcion}'),
                      // Add more functionality as needed, e.g., edit or other actions
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Manually trigger deletion when the delete button is pressed
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                      ),
                    ),
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
            MaterialPageRoute(builder: (context) => PaginaApi()),
          );
        },
        child: Icon(Icons.arrow_forward_ios),

      ),
    );
  }
}


class PaginaApi extends StatefulWidget {
  @override
  _PaginaApiState createState() => _PaginaApiState();
}

//final Uri url = Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1');
class _PaginaApiState extends State<PaginaApi> {
  String paginaSeleccionada = 'Api';
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final List<dynamic> allData = [];

    for (int i = 1; i <= 30; i++) {
      try {
        final response = await http.get(Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/$i'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> parsedJson = json.decode(response.body);
          if (parsedJson.containsKey('data') && parsedJson['data'] is List) {
            allData.addAll(parsedJson['data']);
          } else {
            throw Exception('Invalid JSON format - missing or incorrect "data" property');
          }
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        print('Error fetching data for ID $i: $e');
        // You can handle the exception as needed, for example, logging or displaying an error message.
      }
    }

    setState(() {
      jsonData = allData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (unchanged code)

      body: Center(
        child: jsonData.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
          itemCount: jsonData.length,
          itemBuilder: (context, index) {
            final department = jsonData[index];

            final departmentName = department['departmentName'] ?? 'N/A';
            final departmentDesc = department['departmentDesc'] ?? 'No description';
            final departmentId = department['departmentId'] ?? 'No id';

            return ListTile(
              title: Text(departmentName),
              subtitle: Text(departmentDesc),
              leading: Text(departmentId),
            );
          },
        ),
      ),
    );
  }
}



//crear la clase para almacenar los items
class Item {
  final String id;
  final String nombre;
  final String descripcion;

  Item({required this.id, required this.nombre, required this.descripcion});
}
/*
Solución temporal a error CORS cross origin de conexion a API desde chrome
1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
3- Find '--disable-extensions'
4- Add '--disable-web-security'

La solucion definitiva seria que desde el server donde esta la API permitan el origen de esta app
*/



Future<void> postData(Map<String, dynamic> data) async {
  final Uri url = Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1');

  // Add your required headers here
  Map<String, String> headers = {
    'orgid': '',
  };

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 201) {
    print('Data posted successfully');
  } else {
    print('Failed to post data. Status code: ${response.statusCode}');
    print('Error response: ${response.body}');
  }
}

Future<void> updateData(String id, Map<String, dynamic> newData) async {
  final Uri url = Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/$id');

  // Add your required headers here
  Map<String, String> headers = {
    'orgid': '',
  };

  final response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(newData),
  );

  if (response.statusCode == 200) {
    print('Data updated successfully');
  } else {
    print('Failed to update data. Status code: ${response.statusCode}');
    print('Error response: ${response.body}');
  }
}

Future<void> deleteData(String id) async {
  final Uri url = Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/$id');

  // Add your required headers here
  Map<String, String> headers = {
    'orgid': '',
  };

  final response = await http.delete(
    url,
    headers: headers,
  );

  if (response.statusCode == 204) {
    print('Data deleted successfully');
  } else {
    print('Failed to delete data. Status code: ${response.statusCode}');
    print('Error response: ${response.body}');
  }
}
