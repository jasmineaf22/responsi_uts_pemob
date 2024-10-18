class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api/pariwisata';
  static const String listPenginapan = baseUrl + '/penginapan';
  static const String createPenginapan = baseUrl + '/penginapan';

  static const String registrasi = 'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';


  static String showPenginapan(int id) {
    return baseUrl + '/penginapan/' + id.toString();
  }

  static String updatePenginapan(int id) {
    return baseUrl + '/penginapan/' + id.toString() + '/update';
  }

  static String deletePenginapan(int id) {
    return baseUrl + '/penginapan/' + id.toString() + '/delete';
  }
}
