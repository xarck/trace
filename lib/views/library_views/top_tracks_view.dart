import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/models/track_model.dart';

class TopTracksView extends StatefulWidget {
  final TopTracks topTracks;
  TopTracksView({
    Key? key,
    required this.topTracks,
  }) : super(key: key);

  @override
  State<TopTracksView> createState() => _TopTracksViewState();
}

class _TopTracksViewState extends State<TopTracksView> {
  MediaController? mc;
  @override
  void initState() {
    super.initState();
    mc = Provider.of<MediaController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 35),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            physics: ClampingScrollPhysics(),
            children: widget.topTracks.items!.map<Widget>((track) {
              index++;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "${track.album?.images?[0].url}",
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$index. ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Flexible(
                        child: Text(
                          "${track.name}",
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }).toList(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    await mc?.fetchTracks(range: 'short_term');
                  },
                  child: Text("4 Weeks"),
                ),
                TextButton(
                  onPressed: () async {
                    await mc?.fetchTracks(range: 'medium_term');
                  },
                  child: Text("6 Months"),
                ),
                TextButton(
                  onPressed: () async {
                    await mc?.fetchTracks(range: 'long_term');
                  },
                  child: Text("All Time"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
