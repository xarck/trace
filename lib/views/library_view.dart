import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trace/controllers/media_controller.dart';
import 'package:trace/models/artist_model.dart';
import 'package:trace/models/track_model.dart';
import 'package:trace/views/library_views/top_artists_view.dart';
import 'package:trace/views/library_views/top_tracks_view.dart';

class Library extends StatefulWidget {
  Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> with SingleTickerProviderStateMixin {
  String target = "Tracks";
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TabController(length: 3, vsync: this);
    fetchResults();
  }

  void fetchResults() async {
    MediaController mc = Provider.of<MediaController>(context, listen: false);
    await mc.fetchArtists();
    await mc.fetchTracks();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Top $target"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Tracks'),
              Tab(text: "Artists"),
            ],
          ),
        ),
        body: Consumer<MediaController>(
          builder: (context, data, child) {
            return TabBarView(
              children: [
                TopTracksView(topTracks: data.topTracks!),
                TopArtistsView(topArtists: data.topArtists!),
              ],
            );
          },
        ),
      ),
    );
  }
}
