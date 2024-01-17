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
          // Menu desplegable
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            
            items: <String>['Bienvenida', 'Agregar', 'Buscar', 'Listar_Modificar_Eliminar']
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
          const Center(
            child: Text(
              "Bienvenido a esta App de prueba",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          SizedBox(height: 20), // Espacio entre los contenidos
          Center(
            child: SizedBox(
              width: 200, // el ancho necesario
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaContenido()),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios), 
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
    case 'Agregar':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaContenido()),
      );
      break;
    case 'Buscar':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaListar()),
      );
      break;
    case 'Listar_Modificar_Eliminar':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaginaApi()),
      );
      break;

  }
}
class PaginaContenido extends StatefulWidget {
  @override
  _StatePaginaContenido createState() => _StatePaginaContenido();
}

class _StatePaginaContenido extends State<PaginaContenido>{
  String paginaSeleccionada = 'Agregar';
  List<dynamic> datoSeleccionado = [];

  Future<void> postData(Map<String, dynamic> newData) async {
    // url de la API
    final String apiUrl = 'https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/';



    // hacer el POST a la api
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(newData),
        headers: {'Content-Type': 'application/json'},
      );
      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Request Body: ${json.encode(newData)}');
      
      if (response.statusCode == 201) {
        //Mostrar un mensaje si es que se agrega un item 
        print('Response: ${response.body}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item añadido exitosamente'),
            duration: Duration(seconds: 3), // Se puede ajustar la duracion
          ),
        );
      }
      else if (response.statusCode == 500) {
        // el codigo de error 500 aparece si es que ya existe un item con ese ID
        //se imprimen mensajes en consola que ayuden a entender algun posible error en el formato
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        // Se muestra un mensaje en caso de que ya exista un item con el mismo ID
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ya hay un item con ese ID'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      else {

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      //para ver un mensaje de error en consola 
      print('Exception: $e');
    }
  }


  


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
          
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            
            items: <String>['Bienvenida', 'Agregar', 'Buscar', 'Listar_Modificar_Eliminar']
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
              "Agrega un nuevo item a la API",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
              // Primer bloque de contenido
              Column(

                children: [
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> newData = {
                        'departmentId' : controladorID.text.toString(),
                        'departmentName':controladorNombre.text.toString(),
                        'departmentDesc': controladorDescripcion.text.toString(),
                      };
                      postData(newData);
                      // Llama la funcion cuando se presiona el boton y se le da el parametro newData
                      
                      print('Se hace POST Request');
                    },
                    child: Text('Agregar item'),
                  ),
                ],
              ),
             

            ],
          ),
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



}

class PaginaListar extends StatefulWidget {
  @override
  _PaginaListarState createState() => _PaginaListarState();
}

class _PaginaListarState extends State<PaginaListar>{
  String paginaSeleccionada = 'Buscar';
  List<dynamic> datoSeleccionado = [];

  Future<void> getOne(String id) async {
    try {
      final response = await http.get(Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/$id'));

      if (response.statusCode == 200) {
        print('get al : $id');
        final Map<String, dynamic> parsedJson = json.decode(response.body);
        setState(() {
          datoSeleccionado.addAll(parsedJson['data']);
        });
        print(datoSeleccionado);
        // Limpia el valor del controlador de texto para seleccionar items por ID
        controladorSeleccion.text = '';
      }
      else if (response.statusCode == 404) {
        // HTTP status code 404 indica que no se pudo encontrar esa ID
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        // Muestra un mensaje indicando que no hay datos en esa ID
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No hay datos en esa ID'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      else {
        throw Exception('Failed to get: $id');
      }
    } catch (e) {
      print('Error get data with ID $id: $e');
    }
  }

  TextEditingController controladorSeleccion = TextEditingController();

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
          // Dropdown menu
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            
            items: <String>['Bienvenida', 'Agregar', 'Buscar', 'Listar_Modificar_Eliminar']
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
            
            children: [
              Text(
              "Buscar items de la API por ID",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              )),
              
              ListView.builder(
                
                shrinkWrap: true,
                itemCount: datoSeleccionado.length, 
                itemBuilder: (context, index) {
                 
                  return ListTile(
                    title: Text('${datoSeleccionado[index]['departmentName']}'),
                    subtitle: Text('${datoSeleccionado[index]['departmentDesc']}'),
                    leading: Text('${datoSeleccionado[index]['departmentId']}'),
                   
                  );
                },
              ),

                  TextField(
                    controller: controladorSeleccion,
                    decoration:
                    InputDecoration(labelText: 'ingrese ID item a seleccionar'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String id = controladorSeleccion.text.toString();
                      // Llama la funcion cuando se presiona el boton
                      getOne(id);

                  
                      print(id);
                    },
                    child: Text('Buscar item por ID'),
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




class _PaginaApiState extends State<PaginaApi> {
  String paginaSeleccionada = 'Listar_Modificar_Eliminar';
  List<dynamic> jsonData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final List<dynamic> allData = [];

    for (int i = 1; i <= 10; i++) {
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
      }
    }

    setState(() {
      jsonData = allData;
      isLoading = false;
    });
  }

  Future<void> deleteData(int id) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.delete(Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/$id'));

      if (response.statusCode == 200) {
        print('Deleted data with ID: $id');
        await fetchData();
      } else {
        throw Exception('Failed to delete data with ID: $id');
      }
    } catch (e) {
      print('Error deleting data with ID $id: $e');
    }
  }

  Future<void> updateData(int id, Map<String, dynamic> newData) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.put(
        Uri.parse('https://af-mutual-valida-dev-001.azurewebsites.net/api/department/v1/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newData),
      );

      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Request Body: ${json.encode(newData)}');

      if (response.statusCode == 200) {
        print('Updated data with ID: $id');
        await fetchData();
      } else {
        print('Failed to update data with ID: $id');
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to update data with ID: $id');
      }
    } catch (e) {
      print('Error modificando data con ID $id: $e');
    }
  }


  Future<void> showUpdateDialog(int id) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modificar Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nuevo nombre'),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(labelText: 'Nueva descripción'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Map<String, dynamic> newData = {
                  'departmentId' : id.toString(),
                  'departmentName':nameController.text.toString(),
                  'departmentDesc': descController.text.toString(),
                };
                updateData(id, newData);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de items de la API"),
        centerTitle: true,
        leading:
        IconButton(
            onPressed: null,
            icon:
            Image.network('https://media.licdn.com/dms/image/C4E0BAQGEl5jj-N2CQw/company-logo_200_200/0/1630601529912?e=2147483647&v=beta&t=6znabYsnflfc7HFJwL3GK0wsvYYKflF9bJSg4egIzew')
        ),
        actions: [
          // Dropdown menu
          DropdownButton<String>(
            value: paginaSeleccionada,
            onChanged: (String? nuevoValor) {
              setState(() {
                paginaSeleccionada = nuevoValor!;
              });
              navegarPaginaSeleccionada(paginaSeleccionada, context);
            },
            
            items: <String>['Bienvenida', 'Agregar', 'Buscar', 'Listar_Modificar_Eliminar']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Center(
        
        child: isLoading
            ? CircularProgressIndicator()
            : jsonData.isEmpty
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteData(int.parse(departmentId));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showUpdateDialog(int.parse(departmentId));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}







/*
Solución temporal a error CORS cross origin de conexion a API desde chrome
1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
3- Find '--disable-extensions'
4- Add '--disable-web-security'

La solucion definitiva seria que desde el server donde esta la API permitan el origen de esta app
*/








