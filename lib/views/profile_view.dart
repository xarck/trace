import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trace/controllers/auth_controller.dart';
import 'package:trace/controllers/media_controller.dart';

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
          return data.profile == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
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
                          children: [
                            Text(
                              "Name - ${data.profile?.displayName}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              "Followers - ${data.profile?.followers?.total}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              "Country - ${data.profile?.country}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        ac.logout();
                      },
                      child: Text("Logout"),
                    )
                  ],
                );
        },
      ),
    );
  }
}
