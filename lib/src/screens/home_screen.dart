import 'package:flutter/material.dart'; 
import '../SwipeAnimation/index.dart';

class HomeScreen extends StatefulWidget{
  createState() {
      
      return HomeStateScreen();
    }
}

class HomeStateScreen extends State<HomeScreen> {
  int _currentIndex = 0; 
  final List<Widget> _children = []; 

  void onTabTapped(int index){
    setState((){
      _currentIndex = index; 
    });
  }
  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page")
        ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider();
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding:EdgeInsets.zero,
              child: Text('Fakerinos'),
              decoration: BoxDecoration(
                
              )
            ),
            ListTile(
              title: Text('Profile'),
              onTap:(){

              })
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("Multiplayer")
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("Crowd Source")
          ),
          
        ],
        
      ),
      )
    );
} } 

Widget _buildCarousel(BuildContext context, int carouselIndex) {
    final headers = ["Recommended For You", "Trending", "Newest"]; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(headers[carouselIndex]),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Center(
      child: GestureDetector(
        onTap: ()=> Navigator.push(
              context,
              // TODO: Refactor this whole CardDemo Component
              new MaterialPageRoute(builder: (context) => new CardDemo()),
            ),
        onDoubleTap: ()=> showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: new Text("You liked this"));
          }), 
        child: Card(
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
            const ListTile(
            leading: Icon(Icons.album), 
            title: Text('Lala'), 
            subtitle: Text("Subtitle"))]
            ,)
            ,)
            ,));
  }
