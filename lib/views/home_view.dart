import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/media_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  fetchResults() async {
    MediaController mc = Provider.of<MediaController>(context, listen: false);
    await mc.fetchArtists();
    await mc.fetchTracks();
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
      ),
    );
  }
}
