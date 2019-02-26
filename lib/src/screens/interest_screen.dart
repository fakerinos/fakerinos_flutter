import 'package:flutter/material.dart'; 
import '../screens/home_screen.dart';

class InterestScreen extends StatefulWidget {
  createState() { 
    return InterestStateScreen(); 
  } 
}

class InterestStateScreen extends State<InterestScreen> {

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Getting Started")
        ),
        body: InterestGrid().build(),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 2.0,
          onPressed: (){
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new HomeScreen()),
            );
          },
          icon: Icon(Icons.save),
          label: Text("Save")
        ),
      )
    );
} }

class InterestGrid {
  Card makeGridCell(String name, IconData icon){
    return Card(
      color: Colors.cyan,
      elevation: 5.0, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down, 
        children: <Widget>[
          Center(child: Icon(icon)),
          Center(child: Text(name)), 
        ]
      ),
    );
  }
  
  GridView build(){
    return GridView.count(
      primary: true, 
      padding: EdgeInsets.all(2.0), 
      crossAxisCount: 2, 
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        makeGridCell("Adventures", Icons.terrain),
        makeGridCell("Local", Icons.local_activity),
        makeGridCell("Social", Icons.chat_bubble),
        makeGridCell("Sports", Icons.explore),
        
      ]
    );
  }
}