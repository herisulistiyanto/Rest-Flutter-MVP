import 'package:example_flutter/data/FetchDataException.dart';
import 'package:example_flutter/data/HotelData.dart';
import 'package:example_flutter/deps/di.dart';

abstract class HotelListViewContract {
  void onSuccess(List<Hotel> items);
  void onError(FetchDataException e);
}

class HotelPresenter {
  HotelListViewContract _view;
  HotelRepository _repository;

  HotelPresenter(this._view) {
    _repository = new Injector().hotelRepository;
  }

  void loadHotels() {
    _repository
        .fetchHotels()
        .then((data) => _view.onSuccess(data))
        .catchError((e) => _view.onError(new FetchDataException(e.toString())));
  }
}
