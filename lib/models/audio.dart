import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyAudioList {
  final List<MyAudio> audios;
  MyAudioList({
    required this.audios,
  });

  MyAudioList copyWith({
    List<MyAudio>? audios,
  }) {
    return MyAudioList(
      audios: audios ?? this.audios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'audios': audios.map((x) => x.toMap()).toList(),
    } as Map<String, dynamic>;
  }

  factory MyAudioList.fromMap(Map<String, dynamic> map) {
    return MyAudioList(
      audios: List<MyAudio>.from(
          map['audios']?.map((Map<String, dynamic> x) => MyAudio.fromMap(x))
              as Iterable<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyAudioList.fromJson(String source) =>
      MyAudioList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyAudioList(audios: $audios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyAudioList && listEquals(other.audios, audios);
  }

  @override
  int get hashCode => audios.hashCode;
}

class MyAudio {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String lang;
  MyAudio({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    required this.lang,
  });

  MyAudio copyWith({
    int? id,
    int? order,
    String? name,
    String? tagline,
    String? color,
    String? desc,
    String? url,
    String? category,
    String? icon,
    String? image,
    String? lang,
  }) {
    return MyAudio(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    } as Map<String, dynamic>;
  }

  factory MyAudio.fromMap(Map<String, dynamic> map) {
    return MyAudio(
      id: map['id']?.toInt() as int,
      order: map['order']?.toInt() as int,
      name: map['name'] as String,
      tagline: map['tagline'] as String,
      color: map['color'] as String,
      desc: map['desc'] as String,
      url: map['url'] as String,
      category: map['category'] as String,
      icon: map['icon'] as String,
      image: map['image'] as String,
      lang: map['lang'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyAudio.fromJson(String source) =>
      MyAudio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyAudio(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyAudio &&
        other.id == id &&
        other.order == order &&
        other.name == name &&
        other.tagline == tagline &&
        other.color == color &&
        other.desc == desc &&
        other.url == url &&
        other.category == category &&
        other.icon == icon &&
        other.image == image &&
        other.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        color.hashCode ^
        desc.hashCode ^
        url.hashCode ^
        category.hashCode ^
        icon.hashCode ^
        image.hashCode ^
        lang.hashCode;
  }
}
