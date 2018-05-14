import 'dart:async';

class Hotel {
  String id;
  String name;
  String description;
  String background;

  Hotel({this.id, this.name, this.description, this.background});

  Hotel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        background = map['background'];
}

abstract class HotelRepository {
  Future<List<Hotel>> fetchHotels();
}

class DataHotels {
  List<dynamic> data;
  String message;
  int status;

  DataHotels({this.data, this.message, this.status});

  DataHotels.fromMap(Map<String, dynamic> map)
      : data = map['data'],
        message = map['message'],
        status = map['status'];
}
