import 'dart:async';
import 'dart:convert';
import 'package:example_flutter/data/FetchDataException.dart';
import 'package:http/http.dart' as http;

import 'package:example_flutter/data/HotelData.dart';

class HotelNetworkRepository implements HotelRepository {
  String url = "http://private-b8cf44-androidcleancode.apiary-mock.com/v1/city";
  
  @override
  Future<List<Hotel>> fetchHotels() async {
    http.Response response = await http.get(url);
    final statusCode = response.statusCode;
    final Map responseBody = json.decode(response.body);
    final DataHotels _dataHotels = new DataHotels.fromMap(responseBody);

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }

    return _dataHotels.data.map((hotels) => new Hotel.fromMap(hotels)).toList();
  }

}