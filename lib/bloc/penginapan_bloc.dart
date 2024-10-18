import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/penginapan.dart';  // Update the import to use the Penginapan model

class PenginapanBloc {
  static Future<List<Penginapan>> getPenginapan() async {
    String apiUrl = ApiUrl.listPenginapan; // Update to use the new penginapan API
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listPenginapan = (jsonObj as Map<String, dynamic>)['data'];
    List<Penginapan> penginapans = [];

    for (int i = 0; i < listPenginapan.length; i++) {
      penginapans.add(Penginapan.fromJson(listPenginapan[i])); // Use the Penginapan model
    }

    return penginapans;
  }

  static Future<bool> addPenginapan({required Penginapan penginapan}) async {
    String apiUrl = ApiUrl.createPenginapan; // Update to use the new penginapan API
    var body = {
      "accommodation": penginapan.accommodation,
      "room": penginapan.room,
      "rate": penginapan.rate.toString(), // Ensure data is formatted correctly
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updatePenginapan({required Penginapan penginapan}) async {
    String apiUrl = ApiUrl.updatePenginapan(penginapan.id!); // Update to use the new penginapan API
    var body = {
      "accommodation": penginapan.accommodation,
      "room": penginapan.room,
      "rate": penginapan.rate,
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deletePenginapan({required int id}) async {
    String apiUrl = ApiUrl.deletePenginapan(id); // Update to use the new penginapan API
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['status']; // Ensure the response structure matches
  }
}
