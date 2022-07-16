import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:trace/models/artist_model.dart';
import 'package:trace/models/currently_playing_model.dart';
<<<<<<< HEAD
import 'package:trace/models/profile_model.dart';
=======
>>>>>>> building
import 'package:trace/models/recently_played_model.dart';
import 'package:trace/models/track_model.dart';

import '../models/profile_model.dart';

class MediaController extends ChangeNotifier {
  TopArtists? topArtists;
  TopTracks? topTracks;
  RecentlyPlayed? recentlyPlayed;
  CurrentlyPlayingModel? currentlyPlaying;
  Profile? profile;
<<<<<<< HEAD
=======
  bool isLoading = true;
>>>>>>> building

  fetchTracks(
      {int limit = 50, int offset = 0, String range = 'long_term'}) async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/top/tracks?limit=$limit&offset=$offset&time_range=$range',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      topTracks = TopTracks.fromJson(response.data);
<<<<<<< HEAD
=======
      isLoading = false;
>>>>>>> building
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  fetchArtists(
      {int limit = 50, int offset = 0, String range = 'long_term'}) async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
<<<<<<< HEAD
        'https://api.spotify.com/v1/me/top/artists?time_range=$range&limit=$limit&offset=$offset',
=======
        'https://api.spotify.com/v1/me/top/artists?limit=$limit&offset=$offset&time_range=$range',
>>>>>>> building
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      topArtists = TopArtists.fromJson(response.data);
<<<<<<< HEAD
=======
      isLoading = false;
>>>>>>> building
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

<<<<<<< HEAD
  fetchRecentlyPlayed() async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/player/recently-played',
=======
  fetchRecentlyPlayed({int limit = 50}) async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/player/recently-played?limit=$limit',
>>>>>>> building
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      recentlyPlayed = RecentlyPlayed.fromJson(response.data);
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  fetchCurrentlyPlaying() async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me/player/currently-playing',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      currentlyPlaying = CurrentlyPlayingModel.fromJson(response.data);
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  fetchProfile() async {
    try {
      String token = Hive.box('auth').get('access_token');
      Response response = await Dio().get(
        'https://api.spotify.com/v1/me',
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
      );
      profile = Profile.fromJson(response.data);
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }
}
