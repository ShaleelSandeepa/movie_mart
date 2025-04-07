class CompanyModel {
  int? id;
  String? logoPath;
  String? name;

  String? originCountry;

  CompanyModel({
    this.id,
    required this.logoPath,
    required this.name,
    this.originCountry,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      logoPath: json['logo_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['logo_path']}"
          : "https://cdn-icons-png.flaticon.com/512/2399/2399925.png",
      name: json["name"],
    );
  }
}
