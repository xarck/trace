import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/media_controller.dart';

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
          print(data.currentlyPlaying?.item?.name);
          return Container();
        }),
      ),
    );
  }
}
