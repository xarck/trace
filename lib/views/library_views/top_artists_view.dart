import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/basic_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:trace/enums/time_period.dart';
import 'package:trace/enums/top_target.dart';
import 'package:trace/models/artist_model.dart';
import 'package:trace/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

class TopArtistsView extends StatefulWidget {
  final TopArtists topArtists;
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
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 5,
                            ),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: hexToColor("3F4E4F"),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Uri url = Uri.parse(widget
                                            .topArtists
                                            .items?[index]
                                            .externalUrls
                                            ?.spotify ??
                                        "");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode
                                            .externalNonBrowserApplication,
                                      );
                                    } else {
                                      throw "Could not launch $url";
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: "${currItem?.images?[0].url}",
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
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "#$index  ${currItem?.name}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
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
                      crossAxisCount: 4,
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
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: "${artist.images?[0].url}",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
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
            color: hexToColor("3F4E4F"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    await mc?.fetchArtists(range: 'short_term');
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
                    await mc?.fetchArtists(range: 'medium_term');
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
                    await mc?.fetchArtists(range: 'long_term');
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
