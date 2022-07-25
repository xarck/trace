import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/basic_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/enums/time_period.dart';
import 'package:trace/enums/top_target.dart';
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
        Consumer<BasicController>(
          builder: (context, data, child) {
            return data.topTarget == TopTarget.LIST
                ? Container(
                    padding: EdgeInsets.only(bottom: 35),
                    child: ListView.builder(
                        itemCount: widget.topTracks.items?.length,
                        itemBuilder: (context, index) {
                          Items? currItem = widget.topTracks.items?[index];
                          index++;
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${currItem?.album?.images?[0].url}",
                                    height: 60,
                                    width: 60,
                                    placeholder: (context, url) => Container(
                                      padding: EdgeInsets.all(10),
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    "#$index  ${currItem?.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                    overflow: TextOverflow.fade,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                : Container(
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
                              child: CachedNetworkImage(
                                imageUrl: "${track.album?.images?[0].url}",
                                height: 120,
                                width: 120,
                                placeholder: (context, url) => Container(
                                  padding: EdgeInsets.all(30),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "$index. ",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Flexible(
                                  child: Text(
                                    "${track.name}",
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  );
          },
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
                  child: Text(
                    "4 Weeks",
                    style: TextStyle(
                      color: convertTermToTimePeriod('short_term') == mc?.tp
                          ? Colors.blue
                          : Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await mc?.fetchTracks(range: 'medium_term');
                  },
                  child: Text(
                    "6 Months",
                    style: TextStyle(
                      color: convertTermToTimePeriod('medium_term') == mc?.tp
                          ? Colors.blue
                          : Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await mc?.fetchTracks(range: 'long_term');
                  },
                  child: Text(
                    "All Time",
                    style: TextStyle(
                      color: convertTermToTimePeriod('long_term') == mc?.tp
                          ? Colors.blue
                          : Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
