class Hadith {
  final String arabic;
  final String translation;

  Hadith({required this.arabic, required this.translation});

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      arabic: json["arabic"] ?? "",
      translation: json["translation"] ?? "",
    );
  }
}
