// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BoardPage {
  String tittle;
  String descr;
  String image;
  BoardPage({
    required this.tittle,
    required this.descr,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tittle': tittle,
      'descr': descr,
      'image': image,
    };
  }

  factory BoardPage.fromMap(Map<String, dynamic> map) {
    return BoardPage(
      tittle: map['tittle'] as String,
      descr: map['descr'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BoardPage.fromJson(String source) =>
      BoardPage.fromMap(json.decode(source) as Map<String, dynamic>);
}
