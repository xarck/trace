import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/media_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late MediaController mc;
  late AuthController ac;
  @override
  void initState() {
    super.initState();
    mc = Provider.of<MediaController>(context, listen: false);
    ac = Provider.of<AuthController>(context, listen: false);
    fetchProfile();
  }

  fetchProfile() async {
    await mc.fetchProfile();
    await mc.fetchUsersPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: Consumer<MediaController>(
        builder: (context, data, child) {
          return data.profile == null || data.playlists == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "User",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.profile?.images?.length != 0
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "${data.profile?.images?[0].url}",
                                  ),
                                  maxRadius: 45,
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: Colors.white30,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${data.profile?.displayName?[0]}",
                                      style: TextStyle(
                                        fontSize: 66,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : ${data.profile?.displayName}",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                "Followers : ${data.profile?.followers?.total}",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                "Country : ${data.profile?.country}",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Playlists",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Container(
                        height: 150,
                        child: ListView.builder(
                            itemCount: data.playlists?.items?.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Container(
                                width: 110,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Uri url = Uri.parse(data
                                                .playlists
                                                ?.items?[index]
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
                                          imageUrl: data
                                                  .playlists
                                                  ?.items?[index]
                                                  .images?[0]
                                                  .url ??
                                              "https://community.spotify.com/t5/image/serverpage/image-id/25294i2836BD1C1A31BDF2?v=v2",
                                          height: 110,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            padding: EdgeInsets.all(10),
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${data.playlists?.items?[index].name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ac.logout();
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
