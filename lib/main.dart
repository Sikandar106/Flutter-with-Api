import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    title: "Api Data Collector",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var apiUrl = "https://jsonplaceholder.typicode.com/photos";
  var apiData;
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {
    var response = await http.get(Uri.parse(apiUrl));
    apiData = jsonDecode(response.body);
    print(apiData);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Data Collector"),
      ),
      body: Padding(padding: 
        const EdgeInsets.all(16.0),
        child : apiData != null ?   
        ListView.builder(itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(apiData[index]["title"]),
              subtitle: Text("id : ${apiData[index]["id"]}") ,
              leading: Image.network(apiData[index]["url"]),
            ),
          );
        },  
        itemCount: apiData.length)
        : const Center(child: CircularProgressIndicator()),
      ),
      );
  }
}