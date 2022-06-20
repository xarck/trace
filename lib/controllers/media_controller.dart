import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:trace/models/artist_model.dart';
import 'package:trace/models/track_model.dart';

class MediaController extends ChangeNotifier {
  TopArtists? topArtists;
  TopTracks? topTracks;

  fetchTracks() async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/top/tracks',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      topTracks = TopTracks.fromJson(response.data);
    } catch (err) {
      print(err.toString());
    }
    notifyListeners();
  }

  fetchArtists() async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/top/artists',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );

      topArtists = TopArtists.fromJson(response.data);
    } catch (err) {
      print(err.toString());
    }
    notifyListeners();
  }
}
