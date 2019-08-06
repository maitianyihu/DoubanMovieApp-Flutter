// import 'package:json_annotation/json_annotation.dart';
// import 'package:build_runner_core/build_runner_core.dart';
part 'Movie.g.dart';

// @JsonSerializable()
 //数据模型
  class  Movie {
       Map rating;// 电影名
       List genres; // 电影类型
       String title; // 电影名称
       List casts; // 演员
       List durations;//时长
       int collect_count;
       String mainland_pubdate;//上映时间
       bool has_video;
       String original_title;//原版名称
       String subtype;//类型 Movie
       List directors;//导演
       List pubdates;//上映地点
       String year;//年代
       Map images;//图片
       String alt;//详情介绍
       String id;// 电影id

      //构造函数
       Movie(this.rating,this.genres,this.title,this.casts,this.durations,this.collect_count,this.mainland_pubdate,this.has_video,this.original_title,this.subtype,this.directors,this.pubdates,this.year,this.images,this.alt,this.id,);

      // factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
      // Map<String, dynamic> toJson() => _$MovieToJson(this);
  }
