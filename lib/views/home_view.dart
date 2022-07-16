import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trace/controllers/media_controller.dart';
import 'package:trace/models/currently_playing_model.dart';
import 'package:trace/models/recently_played_model.dart';
import 'package:trace/utils/dimension.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  fetchResults() async {
    MediaController mc = Provider.of<MediaController>(context, listen: false);
<<<<<<< HEAD
    await mc.fetchArtists();
    await mc.fetchTracks();
=======
    await mc.fetchCurrentlyPlaying();
    await mc.fetchRecentlyPlayed();
>>>>>>> building
  }

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
<<<<<<< HEAD
      body: Consumer<MediaController>(
        builder: (context, data, child) {
          return data.topArtists == null
              ? LinearProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.topArtists?.items?.length,
                  itemBuilder: (context, index) {
                    var item = data.topArtists?.items?[index];
                    return Text('${item?.name} - ${item?.popularity}');
                  },
                );
        },
=======
      body: SingleChildScrollView(
        child: Consumer<MediaController>(
          builder: (context, data, child) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CurrentlyPlayingView(
                    currentSong: data.currentlyPlaying,
                  ),
                  RecentlyPlayedView(
                    recentlyPlayed: data.recentlyPlayed,
                  )
                ],
              ),
            );
          },
        ),
>>>>>>> building
      ),
    );
  }
}

class CurrentlyPlayingView extends StatefulWidget {
  final CurrentlyPlayingModel? currentSong;
  CurrentlyPlayingView({
    Key? key,
    required this.currentSong,
  }) : super(key: key);

  @override
  State<CurrentlyPlayingView> createState() => _CurrentlyPlayingViewState();
}

class _CurrentlyPlayingViewState extends State<CurrentlyPlayingView> {
  @override
  Widget build(BuildContext context) {
    return widget.currentSong == null
        ? CircularProgressIndicator()
        : widget.currentSong?.isPlaying == false
            ? Text("You aren't playing any song right now")
            : Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Currently Playing on Spotify",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${widget.currentSong?.item?.album?.images?[0].url}",
                            height: 130,
                            width: 130,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: getSize(context).width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.currentSong?.item?.name}",
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Text(
                                "${widget.currentSong?.item?.album?.name}",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Text(
                                "${widget.currentSong?.item?.artists?[0].name}",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
  }
}

class RecentlyPlayedView extends StatefulWidget {
  final RecentlyPlayed? recentlyPlayed;
  RecentlyPlayedView({
    Key? key,
    this.recentlyPlayed,
  }) : super(key: key);

  @override
  State<RecentlyPlayedView> createState() => _RecentlyPlayedViewState();
}

class _RecentlyPlayedViewState extends State<RecentlyPlayedView> {
  @override
  Widget build(BuildContext context) {
    return widget.recentlyPlayed == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Recently Played on Spotify",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListView.builder(
                  itemCount: widget.recentlyPlayed?.items?.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade800,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${widget.recentlyPlayed?.items?[index].track?.album?.images?[0].url}",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: getSize(context).width / 1.5,
                            height: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${widget.recentlyPlayed?.items?[index].track?.name}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                // Spacer(),
                                Text(
                                  "${widget.recentlyPlayed?.items?[index].track?.artists?[0].name}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
  }
}
