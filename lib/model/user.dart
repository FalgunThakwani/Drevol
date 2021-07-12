import 'package:flutter/material.dart';

class User {
  String username;
  String email;
  String city;
  String profile_pic;
  List<Contact> contact;
  List<FavProducts> favProducts;
  List<VisProducts> visProducts;


  User( {required this.username,
  required this.email,
  required this.city,
  required this.contact,
    required this.favProducts,
    required this.visProducts,
    required this.profile_pic
  }
   );

  factory User.fromJson(Map<String, dynamic> json){
var list=json["favourite_products"] as List;
List<FavProducts> favlist = list.map((i) => FavProducts.fromJson(i)).toList();
var list1=json["visited_products"] as List;
List<VisProducts> vislist = list1.map((i) => VisProducts.fromJson(i)).toList();
var list2=json["contact_numbers"] as List;
List<Contact> conlist = list2.map((i) => Contact.fromJson(i)).toList();

    return User(
      username:json['username'],
      email:json['email'],
      city: json['city'],
      contact: conlist,
      profile_pic: json["profile_pic"],
      favProducts:favlist,
      visProducts: vislist
    );
  }
}

class Contact {
  String contact_type;
  String contact_no;

  Contact({
    required this.contact_no,
    required this.contact_type
  });

  factory Contact.fromJson(Map<String,dynamic> json){
    return Contact(
        contact_no: json['contact_no'],
        contact_type: json['contact_type']
    );
  }
}

class FavProducts {
  var product_id;
  FavProducts(
  {
    this.product_id
}
      );
  factory FavProducts.fromJson(Map<String,dynamic> json){
    return FavProducts(
      product_id: json['product_id']
    );
  }
}

class VisProducts {
  var Vproduct_id;
  VisProducts(
  {
    this.Vproduct_id
}
      );
  factory VisProducts.fromJson(Map<String,dynamic> json){
    return VisProducts(
      Vproduct_id: json['product_id']
    );
  }
}
