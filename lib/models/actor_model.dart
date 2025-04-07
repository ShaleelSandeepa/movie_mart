class ActorModel {
  String? name;
  String? image;
  String? charactor;
  double? popularity;

  ActorModel({
    this.name,
    this.image,
    this.charactor,
    this.popularity,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      name: json["name"],
      image: json["profile_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["profile_path"]}"
          : "https://icons.iconarchive.com/icons/icons-land/vista-people/256/Occupations-Actor-Male-Light-icon.png",
      charactor: json["character"],
      popularity: json["popularity"].toDouble() ?? 0.0,
    );
  }
}
