import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trace/controllers/media_controller.dart';
import 'package:trace/models/currently_playing_model.dart';
import 'package:trace/models/recently_played_model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  fetchResults() async {
    MediaController mc = Provider.of<MediaController>(context, listen: false);
    await mc.fetchCurrentlyPlaying();
    await mc.fetchRecentlyPlayed();
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
      body: SingleChildScrollView(
        child: Consumer<MediaController>(builder: (context, data, child) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                CurrentlyPlayingView(
                  currentSong: data.currentlyPlaying,
                ),
                RecentlyPlayedView(recentlyPlayed: data.recentlyPlayed)
              ],
            ),
          );
        }),
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
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Currently Playing"),
                    Row(
                      children: [
                        Image.network(
                          "${widget.currentSong?.item?.album?.images?[0].url}",
                          height: 130,
                          width: 130,
                        ),
                        Spacer(),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${widget.currentSong?.item?.name}"),
                            Text("${widget.currentSong?.item?.album?.name}"),
                            Text(
                                "${widget.currentSong?.item?.artists?[0].name}")
                          ],
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
    // print(DateTime.parse("${widget.recentlyPlayed?.items?[0].playedAt}"));
    return widget.recentlyPlayed == null
        ? CircularProgressIndicator()
        : Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Recently Played",
                ),
              ),
              ListView.builder(
                itemCount: widget.recentlyPlayed?.items?.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          "${widget.recentlyPlayed?.items?[index].track?.album?.images?[0].url}",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            Text(
                              "${widget.recentlyPlayed?.items?[index].track?.name}",
                            ),
                            Text(
                              "${widget.recentlyPlayed?.items?[index].track?.artists?[0].name}",
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          );
  }
}
