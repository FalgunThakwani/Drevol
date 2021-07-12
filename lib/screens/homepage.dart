import 'dart:convert';
import 'dart:typed_data';

import 'package:drevol1/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  late bool _isSearching;
  String _searchText = "";
  bool sort=false;

  List searchresult = [];
  List searchresultCity=[];
  List searchresultEmail=[];
  List searchresultPrimarycontact=[];
  List searchresultPic=[];
  List<User> userjson = [];

  _HomePage() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  Future<String> loadUserFromAsset() async {
    return await rootBundle.loadString("assets/users.json");
  }

  Future loaduser() async {
    String jsonString = await loadUserFromAsset();
    var userlist = jsonDecode(jsonString)['users'] as List;
    List<User> userobjs =
        userlist.map((userjson) => User.fromJson(userjson)).toList();
    userjson = userobjs;
    // print(userobjs[0].username);
    // print(userobjs[0].email);
    // print(userobjs[0].city);
    // print(userobjs[0].favProducts[0].product_id);
    // print(userobjs[0].visProducts[0].Vproduct_id);
    // print(userobjs[0].contact[0].contact_no);
  }


  @override
  void initState() {
    super.initState();
    _isSearching = false;
    loaduser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("Home"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.logout))],
      ),
      body: ListView(
        children: [

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: searchOperation,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search by name"),
                ),
              ),
              IconButton(onPressed: (){
                setState((){
                  sort=true;
                });
              }, icon: const Icon(Icons.sort_by_alpha))
            ],
          ),
FutureBuilder(future:loaduser(),builder: (context,snapshot){
  return Container(
      child: searchresult.length != 0 || _controller.text.isNotEmpty
          ? ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: searchresult.length,
        itemBuilder: (BuildContext context, int index) {
          var primarycontact =
              userjson[index].contact[0].contact_no;
           // var product_id=userjson[index].favProducts[].product_id;

          return (card(
              searchresult[index],
              searchresultEmail[index],
              searchresultPrimarycontact[index],
              searchresultCity[index],
              searchresultPic[index])
              // ListTile(title: Text(userjson[index].username))
          );
        },
      )
          : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: userjson.length,
        itemBuilder: (BuildContext context, int index) {
          if(sort){
            userjson.sort((a,b) => a.username.compareTo(b.username));
          }
          var primarycontact =
              userjson[index].contact[0].contact_no;



          return (card(
              userjson[index].username,
              userjson[index].email,
              primarycontact,
              userjson[index].city,
              userjson[index].profile_pic)

          );
        },
      ));
},)

        ],
      ),
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    searchresultCity.clear();
     searchresultEmail.clear();
    searchresultPrimarycontact.clear();
     searchresultPic.clear();
    if (_isSearching != null) {
      for (int i = 0; i < userjson.length; i++) {
        String data = userjson[i].username;
        String email=userjson[i].email;
        String city=userjson[i].city;
        String primary=userjson[i].contact[0].contact_no;
        String pic=userjson[i].profile_pic;
        if (data.toLowerCase().contains(searchText.toLowerCase())  || city.toLowerCase().contains(searchText.toLowerCase()) ) {
          searchresult.add(data);
          searchresultCity.add(city);
          searchresultEmail.add(email);
          searchresultPrimarycontact.add(primary);
          searchresultPic.add(pic);
          print(searchresult);

        }
      }
    }
  }


}

Widget card(String username, String email, var primarycontact, String city,
    String imgbase64) {
  String _bytes = imgbase64.split(',').last;
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    child: Row(
      children: [
        Expanded(child: imageFromBase64String(_bytes)),
        Column(
          children: [
            Text("Name: $username",textAlign:TextAlign.left,textDirection: TextDirection.ltr,),
            Text("email:$email ",textAlign: TextAlign.left),
            Text("Primary Contact: $primarycontact"),
            Text("City: $city"),
            Text("Products he may like: ")
          ],
        )
      ],
    ),
  );
}

Image imageFromBase64String(String base64String) {
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.fill,
  );
}
void  snack(BuildContext context){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text("Incorrect username or password")));
}

