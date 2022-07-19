import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/basic_controller.dart';

import 'package:trace/controllers/media_controller.dart';
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
  late BasicController bc;
  @override
  void initState() {
    super.initState();
    bc = Provider.of<BasicController>(context, listen: false);
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
          leading: IconButton(
            icon: Icon(Icons.grid_3x3),
            onPressed: () {
              bc.setTopTarget();
            },
          ),
          title: Text("Top $target"),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelStyle: Theme.of(context).textTheme.displayLarge,
            indicatorColor: Colors.green,
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
                data.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : TopTracksView(topTracks: data.topTracks!),
                data.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : TopArtistsView(topArtists: data.topArtists!),
              ],
            );
          },
        ),
      ),
    );
  }
}
