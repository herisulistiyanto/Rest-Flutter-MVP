import 'package:example_flutter/data/FetchDataException.dart';
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
      child: new Padding(
        padding: EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                itemCount: _hotels.length,
                itemBuilder: (BuildContext context, int index) {
                  final Hotel hotel = _hotels[index];
                  return _getCardItemUi(context, hotel);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getCardItemUi(BuildContext context, Hotel hotel) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: new CachedNetworkImage(
                imageUrl: hotel.background,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Center(child: new Icon(Icons.error)),
              ),
            ),
            subtitle: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: new Text(
                  hotel.name,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                )),
            isThreeLine: true,
            onTap: () {
              final snackBar =
                  new SnackBar(content: new Text("Tap : ${hotel.name}"));
              Scaffold.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }

  @override
  void onError(FetchDataException e) {
    print(e.toString());
  }

  @override
  void onSuccess(List<Hotel> items) {
    setState(() {
      _hotels = items;
      _isLoading = false;
    });
  }
}
