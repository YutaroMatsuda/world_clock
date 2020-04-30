import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag; // url to as asset flag icon
  String url; // a part of url to get json data for api endpoint
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // get property from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create DataTime object
      DateTime utc = DateTime.parse(datetime);
      DateTime now = utc.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 18? true : false;
      this.time = DateFormat.jm().format(now);
    } catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }

}