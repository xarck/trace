import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/media_controller.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  fetchResults() async {
    MediaController mc = Provider.of<MediaController>(context, listen: false);
    await mc.fetchRecentlyPlayed();
    await mc.fetchCurrentlyPlaying();
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
          title: Text('History'),
        ),
        body: Consumer<MediaController>(
          builder: (context, data, child) {
            return Column(
              children: [
                CurrentlyPlayingView(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.recentlyPlayed?.items?.length,
                  itemBuilder: (context, index) {
                    var item = data.recentlyPlayed?.items?[index];
                    return Text('${item?.track?.name}');
                  },
                )
              ],
            );
          },
        ));
  }
}

class CurrentlyPlayingView extends StatefulWidget {
  const CurrentlyPlayingView({Key? key}) : super(key: key);

  @override
  State<CurrentlyPlayingView> createState() => _CurrentlyPlayingViewState();
}

class _CurrentlyPlayingViewState extends State<CurrentlyPlayingView> {
  @override
  Widget build(BuildContext context) {
    return Text('Hello');
    // return Consumer<MediaController>(
    //   builder: (context, data, child) {
    //     String? albumName = data.currentlyPlaying?.item?.album?.name;

    //     return data.currentlyPlaying == null
    //         ? Text("No Song is Playing")
    //         : Text('${data.currentlyPlaying?.item?.album?.name}');
    //   },
    // );
  }
}
