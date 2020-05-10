import 'dart:convert';

import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String id;
  final String imageUrl;
  final String description;
  final String name;

  final int imageWidth;
  final int imageHeight;

  const Cat(
      {this.id,
      this.imageUrl,
      this.description,
      this.name,
      this.imageWidth,
      this.imageHeight});

  @override
  List<Object> get props => [id, imageUrl, description, name];

  static Cat fromJson(dynamic json) {
    final breeds = json['breeds'];

    var breed = firstOrNull(breeds);

    return Cat(
        id: json['id'] ?? '',
        imageUrl: json['url'] ?? '',
        description: breed != null ? breed['description'] ?? 'Empty' : 'Empty',
        name: breed != null ? breed['name'] ?? 'Empty' : 'Empty',
        imageWidth: json['width'],
        imageHeight: json['height']);
  }

  static E firstOrNull<E>(List<E> list) {
    return list == null || list.isEmpty ? null : list.first;
  }
}
