import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/basic_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/enums/top_target.dart';
import 'package:trace/models/artist_model.dart';

class TopArtistsView extends StatefulWidget {
  late TopArtists topArtists;
  TopArtistsView({
    Key? key,
    required this.topArtists,
  }) : super(key: key);

  @override
  State<TopArtistsView> createState() => _TopArtistsViewState();
}

class _TopArtistsViewState extends State<TopArtistsView> {
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
                        itemCount: widget.topArtists.items?.length,
                        itemBuilder: (context, index) {
                          Items? currItem = widget.topArtists.items?[index];
                          return Row(
                            children: [
                              Image.network(
                                "${currItem?.images?[0].url}",
                                height: 60,
                                width: 60,
                              ),
                              Text("${currItem?.name}")
                            ],
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
                      children: widget.topArtists.items!.map<Widget>((artist) {
                        index++;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "${artist.images?[0].url}",
                                height: 120,
                                width: 120,
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
                                    "${artist.name}",
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
