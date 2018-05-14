import 'package:example_flutter/data/HotelData.dart';
import 'package:example_flutter/data/NetworkService.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();
  
    factory Injector() {
      return _singleton;
    }
  
    Injector._internal();

  HotelRepository get hotelRepository => new HotelNetworkRepository();
}
