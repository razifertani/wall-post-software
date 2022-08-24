import 'package:flutter/material.dart';

class ApiResult {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  ApiResult({this.count, this.next, this.previous, this.results});

  ApiResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
  }
}

class Result {
  Color color = Colors.white;
  String? name;
  String? classification;
  String? designation;
  String? averageHeight;
  String? skinColors;
  String? hairColors;
  String? eyeColors;
  String? averageLifespan;
  String? homeworld;
  String? language;
  List<String>? people;
  List<String>? films;
  String? created;
  String? edited;
  String? url;

  Result({this.name, this.classification, this.designation, this.averageHeight, this.skinColors, this.hairColors, this.eyeColors, this.averageLifespan, this.homeworld, this.language, this.people, this.films, this.created, this.edited, this.url});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    classification = json['classification'];
    designation = json['designation'];
    averageHeight = json['average_height'];
    skinColors = json['skin_colors'];
    hairColors = json['hair_colors'];
    eyeColors = json['eye_colors'];
    averageLifespan = json['average_lifespan'];
    homeworld = json['homeworld'];
    language = json['language'];
    people = json['people'].cast<String>();
    films = json['films'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }
}
