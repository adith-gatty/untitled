import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/utils/constants.dart';
class Api{
  Future<Map> fetchDataA() async{
    try {
      Response response = await get(Uri.parse(
          "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=${API_KEY}"),
      );

      Map data=jsonDecode(response.body);

      return data;
    }
    catch(e)
    {
      print(e);
    }
    return({});

  }
  Future<Map> fetchDataB(int id) async{
    Response response= await get(Uri.parse("https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=${API_KEY}"));
    Map data=jsonDecode(response.body);
    return data;
  }
  Future<Map> fetchDataC(int id) async{
    Response response= await get(Uri.parse("https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=${API_KEY}"));
    Map data=jsonDecode(response.body);
    return data;
  }
}