// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      json['rating'],
      json['genres'],
      json['title'],
      json['casts'],
      json['durations'],
      json['collect_count'],
      json['mainland_pubdate'],
      json['has_video'],
      json['original_title'],
      json['subtype'],
      json['directors'],
      json['pubdates'],
      json['year'],
      json['images'],
      json['alt'],
      json['id']);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'rating': instance.rating,
      'genres': instance.genres,
      'title': instance.title,
      'casts': instance.casts,
      'durations': instance.durations,
      'collect_count': instance.collect_count,
      'mainland_pubdate': instance.mainland_pubdate,
      'has_video': instance.has_video,
      'original_title': instance.original_title,
      'subtype': instance.subtype,
      'directors': instance.directors,
      'pubdates': instance.pubdates,
      'year': instance.year,
      'images': instance.images,
      'alt': instance.alt,
      'id': instance.id
    };
