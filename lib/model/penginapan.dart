class Penginapan {
  int? id;
  String? accommodation;
  String? room;
  int? rate;

  Penginapan({this.id, this.accommodation, this.room, this.rate});

  factory Penginapan.fromJson(Map<String, dynamic> obj) {
    return Penginapan(
      id: obj['id'],
      accommodation: obj['accommodation'],
      room: obj['room'],
      rate: obj['rate'] is String
          ? int.tryParse(obj['rate']) // Convert String to int safely
          : obj['rate'], // Keep it as int if it's already int
    );
  }
}
