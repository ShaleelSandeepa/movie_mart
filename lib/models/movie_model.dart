class MovieModel {
  int? id;
  String? backdropPath;
  String? posterPath;
  String? title;

  double? voteAverage;

  MovieModel({
    this.id,
    this.backdropPath,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      id: map["id"],
      backdropPath: "https://image.tmdb.org/t/p/w500${map["backdrop_path"]}",
      posterPath: "https://image.tmdb.org/t/p/w500${map["poster_path"]}",
      title: map["title"],
      voteAverage: map["vote_average"].toDouble(),
    );
  }
}
