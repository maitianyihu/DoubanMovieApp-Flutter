class MovieDetailModel {
   Map rating;
   int wish_count;
   String original_title;
   List blooper_urls;
   int collect_count;
   Map images;
   String year;
   List popular_comments;
   String alt;
   String id;
   String mobile_url;
   int photos_count;
   String pubdate;
   String title;
   String share_url;
   List languages;
   String  schedule_url;
   List writers;
   List pubdates;
   List tags;
   List durations;
   List genres;
   List trailers;
   List trailer_urls;
   List bloopers;
   List casts;
   List countries;
   String mainland_pubdate;
   List photos;
   String summary;
   String subtype;
   List directors;
   int comments_count;
   List popular_reviews;
   int ratings_count;
   List aka;

   MovieDetailModel({
     this.rating,
     this.wish_count,
     this.original_title,
     this.blooper_urls,
     this.collect_count,
     this.images,
     this.year,
     this.popular_comments,
     this.alt,
     this.id,
     this.mobile_url,
     this.photos_count,
     this.pubdate,
     this.title,
     this.share_url,
     this.languages,
     this.schedule_url,
     this.writers,
     this.pubdates,
     this.tags,
     this.durations,
     this.genres,
     this.trailers,
     this.trailer_urls,
     this.bloopers,
     this.casts,
     this.countries,
     this.mainland_pubdate,
     this.photos,
     this.summary,
     this.subtype,
     this.directors,
     this.comments_count,
     this.popular_reviews,
     this.ratings_count,
     this.aka,


   });

    factory MovieDetailModel.fromJson(Map<String,dynamic> json){
        return MovieDetailModel(
          rating: json['rating'],
          wish_count: json['wish_count'],
          original_title: json['original_title'],
          blooper_urls: json['blooper_urls'],
          collect_count: json['collect_count'],
          images: json['images'],
          year: json['year'],
          popular_comments: json['popular_comments'],
          alt: json['alt'],
          id: json['id'],
          mobile_url: json['mobile_url'],
          photos_count: json['photos_count'],
          pubdate: json['pubdate'],
          title: json['title'],
          share_url: json['share_url'],
          languages: json['languages'],
          schedule_url: json['schedule_url'],
          writers: json['writers'],
          pubdates: json['pubdates'],
          tags: json['tags'],
          durations: json['durations'],
          genres: json['genres'],
          trailers: json['trailers'],
          bloopers: json['bloopers'],
          casts: json['casts'],
          countries: json['countries'],
          mainland_pubdate: json['mainland_pubdate'],
          photos: json['photos'],
          summary: json['summary'],
          subtype: json['subtype'],
          directors: json['directors'],
          comments_count: json['comments_count'],
          popular_reviews: json['popular_reviews'],
          ratings_count: json['ratings_count'],
          aka: json['aka'],


        );
    }


}
