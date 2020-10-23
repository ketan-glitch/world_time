import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location for ui
  String time; //time of location
  String url; //url to asset flag icon
  String flag; //location url for api endpoint
  bool isDaytime; //true or false day or night
  WorldTime ({this.location, this.url, this.flag});

  Future<void> getTime() async{

    try {
      //make a request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsethrs = data['utc_offset'].substring(1,3);
      String offsetmins = data['utc_offset'].substring(4,6);

      //Create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours : int.parse(offsethrs), minutes : int.parse(offsetmins)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('Caught a error $e');
      time = 'Could not get Time';
    }

  }
}
