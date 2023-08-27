class CardDto {
  final int id;
  final String pan;

  CardDto({
    required this.id,
    required this.pan,
  });

  factory CardDto.fromJson(Map<String, dynamic> json) {
    return CardDto(
      id: json['id'],
      pan: json['pan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pan': pan,
    };
  }
}