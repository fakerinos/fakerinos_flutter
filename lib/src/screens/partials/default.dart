import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import "../../SwipeAnimation/index.dart";
import "./cards.dart";
import "../../Session.dart";
import "./decks.dart"; 
import "../leaderboard/main(leader).dart";


class DefaultHomeScreen extends StatefulWidget{
  @override
   

  createState(){
    return DefaultHomeStateScreen(); 
  }

  
}

class DefaultHomeStateScreen extends State<DefaultHomeScreen>{

  Decks decksData;
  Deck doubleTappedDeck;
  Deck tappedDeck; 
  final Set<int> starredDecks  = new Set<int>(); 
  String particularsUrl = "https://fakerinos.herokuapp.com/api/accounts/profile/";
  String username = "lionell26";
  bool contains; 

  @override
  void initState(){
    super.initState();
    print("Default Home Screen w Decks initializing");
    _fetchData(); 
  }
  

    _fetchData() async {
      print("Fetching data"); 
    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck", 
    headers: {HttpHeaders.authorizationHeader: "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7"}); 
    
    if (response.statusCode == 200) {
            
      var decodedJson = jsonDecode(response.body); 
      print(decodedJson);
      decksData = Decks.fromJson(decodedJson);

      print("decks output");
      print(decksData.toJson()); 

      setState(() {
      });
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load cards');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Center (
        child: new Container(
        width: 500,
        height: 1000,
        child: Column(children: <Widget>[
        leaderboardButton(),
        Expanded(
        child: decksData == null ?
        Center(child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index <= 0 ) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider(
              height: 3
            );
          }
        },
      )),] ))));
  }
  

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
        onTap: (){ 
        tappedDeck = decksData.decks[itemIndex];
        // print("[Default Screen] " +  "articles:" + tappedDeck.articles.toString());
        Navigator.push(context,
        new MaterialPageRoute(builder: (context)=> CardDemo(articles: tappedDeck.articles)));
        },
        onDoubleTap: (){ 
          doubleTappedDeck = decksData.decks[itemIndex]; 
          // Adding or removing deck logic 
          starredDecks.contains(doubleTappedDeck.pk) ? 
          contains = true : contains = false; 
          contains ? starredDecks.remove(doubleTappedDeck.pk) : 
          starredDecks.add(doubleTappedDeck.pk);

          print(starredDecks);
          starDecks();
          showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: contains ?  
          new Text("You unliked the ${doubleTappedDeck.subject} deck") :
          new Text("You liked the ${doubleTappedDeck.subject} deck"));
          
          });}, 
        child: Card(
          elevation: 10,
          child: ListTile(
              leading: Icon(Icons.album), 
              title: Text(decksData.decks[itemIndex].subject), 
              subtitle: Text(decksData.decks[itemIndex].subject)
            ))
          
            ,));
             
  }


  void starDecks() async {
    
    print("Uploading staredDecks to server..."); 

    Map<String, List<int>> payload = {
      "starred_decks" : starredDecks.toList()
    };
    var body = json.encode(payload); 
    print(body);
    print("lala");
    print(particularsUrl + username );
    final response = await patch(particularsUrl + username + "/", body:body, 
    headers: {HttpHeaders.authorizationHeader: 
    "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7", 
    HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200){
      print("200 success");
    } else {
      print(response.statusCode);
    }
    
    // final parsedResponse = json.decode(response); 
    // print(parsedResponse);


}

Widget leaderboardButton(){
  return new Container(
          padding: EdgeInsets.only(top: 70.0),
          child: ButtonTheme(
            minWidth: 350,
            height: 50,
            child: new RaisedButton(
            color: Colors.white,
            textColor: Color(0xAA0518FF),
            child: new Text("See the leaderboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
            onPressed: () => Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LeaderPage())),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))
            )
          
        )
        );
}
}

