import 'package:example_flutter/data/HotelData.dart';
import 'package:example_flutter/deps/modules/HotelPresenter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements HotelListViewContract {
  HotelPresenter _presenter;
  List<Hotel> _hotels;
  bool _isLoading;

  _HomePageState() {
    _presenter = new HotelPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadHotels();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Hotel App'),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : _hotelWidget(),
    );
  }

  Widget _hotelWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _hotels.length,
              itemBuilder: (BuildContext context, int index) {
                final Hotel hotel = _hotels[index];
                return _getListItemUi(hotel);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile _getListItemUi(Hotel hotel) {
    return new ListTile(
      title: new CachedNetworkImage(
        imageUrl: hotel.background,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Center(child: new Icon(Icons.error)),
      ),
      subtitle: new Text(hotel.name),
      isThreeLine: true,
    );
  }

  @override
  void onError() {
    //TODO
    print('ERROR CUK');
  }

  @override
  void onSuccess(List<Hotel> items) {
    setState(() {
      _hotels = items;
      _isLoading = false;
    });
  }
}
