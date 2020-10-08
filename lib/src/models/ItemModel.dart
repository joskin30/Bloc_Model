//Modelo de Items
class ItemModel {
  String _nama;
  double _latitude;
  double _longitude;
  String _alamat;
  String _telepon;

  //Deserializar el Json
  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _nama = parsedJson['nama'];
    _latitude = parsedJson['latitude'];
    _longitude = parsedJson['longitude'];
    _alamat = parsedJson['alamat'];
    _telepon = parsedJson['telepon'];
  }

  //Serializar el Json
  Map<String, dynamic> toJson() => {
    "_nama": _nama,
    "latitude": latitude,
    "longitude": longitude,
    "alamat": alamat,
    "telepon": telepon,
  };
  
  //Obtener Valor de cada atributo
  String get name => _nama;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get alamat => _alamat;
  String get telepon => _telepon;
}
