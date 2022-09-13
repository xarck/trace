import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trace/controllers/media_controller.dart';
import 'package:trace/models/currently_playing_model.dart';
import 'package:trace/models/recently_played_model.dart';
import 'package:trace/utils/dimension.dart';
import 'package:trace/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Consumer<MediaController>(
          builder: (context, data, child) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  CurrentlyPlayingView(
                    currentSong: data.currentlyPlaying,
                    freshSongPlaying: data.freshSongPlaying,
                  ),
                  RecentlyPlayedView(
                    recentlyPlayed: data.recentlyPlayed,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CurrentlyPlayingView extends StatefulWidget {
  final CurrentlyPlayingModel? currentSong;
  final bool freshSongPlaying;
  CurrentlyPlayingView(
      {Key? key, required this.currentSong, required this.freshSongPlaying})
      : super(key: key);

  @override
  State<CurrentlyPlayingView> createState() => _CurrentlyPlayingViewState();
}

class _CurrentlyPlayingViewState extends State<CurrentlyPlayingView> {
  @override
  Widget build(BuildContext context) {
    return widget.currentSong == null && widget.freshSongPlaying != true
        ? CircularProgressIndicator()
        : widget.currentSong?.isPlaying == false ||
                widget.freshSongPlaying == true
            ? Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.shade800,
                ),
                child: Text(
                  "You aren't playing any song right now",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
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
                        GestureDetector(
                          onTap: () async {
                            Uri url = Uri.parse(widget
                                    .currentSong?.item?.externalUrls?.spotify ??
                                "");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            } else {
                              throw "Could not launch $url";
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${widget.currentSong?.item?.album?.images?[0].url}",
                              height: 130,
                              width: 130,
                              placeholder: (context, url) => Container(
                                padding: EdgeInsets.all(30),
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
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
                        color: hexToColor("3F4E4F"),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Uri url = Uri.parse(widget
                                      .recentlyPlayed
                                      ?.items?[index]
                                      .track
                                      ?.externalUrls
                                      ?.spotify ??
                                  "");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode:
                                      LaunchMode.externalNonBrowserApplication,
                                );
                              } else {
                                throw "Could not launch $url";
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${widget.recentlyPlayed?.items?[index].track?.album?.images?[0].url}",
                                height: 50,
                                width: 50,
                                placeholder: (context, url) => Container(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: getSize(context).width / 1.5,
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${widget.recentlyPlayed?.items?[index].track?.name}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
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
