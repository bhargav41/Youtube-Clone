import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/dataset_model.dart';
import 'package:flutter_application_1/Model/videoModel.dart';
import 'package:flutter_application_1/services/video.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';
import 'package:yoyo_player/yoyo_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          actions: [
            SvgPicture.asset(
              "assets/chromecast.svg",
              color: Colors.white,
              width: 25.0,
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SvgPicture.asset(
                "assets/notification.svg",
                color: Colors.white,
                width: 20.0,
                height: 20.0,
              ),
            ),
            SvgPicture.asset(
              "assets/search.svg",
              color: Colors.white,
              width: 20.0,
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 15.0),
              child: const CircleAvatar(
                radius: 13,
                backgroundImage: AssetImage('assets/pfp.jpg'),
              ),
            ),
          ],
          backgroundColor: Colors.grey[900],
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/logo.svg",
                width: 30.0,
                height: 30.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text("Youtube"),
            ],
          ),
        ),
        body: FutureBuilder<List<VideoModel>>(
            future: VideoServices.getVideos(),
            builder: (context, snapshot) {
              log(snapshot.hasData.toString());
              log(snapshot.hasError.toString());
              log(snapshot.data.toString(), name: "Data");
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : InViewNotifierList(
                      isInViewPortCondition: (double deltaTop,
                          double deltaBottom, double viewPortDimension) {
                        return deltaTop < (0.5 * viewPortDimension) &&
                            deltaBottom > (0.5 * viewPortDimension);
                      },
                      itemCount: snapshot.data!.length,
                      builder: (BuildContext context, int index) {
                        return InViewNotifierWidget(
                          id: '$index',
                          builder: (BuildContext context, bool isInView,
                              Widget? child) {
                            return Card(
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey[900],
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    child: !isInView
                                        ? Image.network(
                                            snapshot.data![index].thumbnail)
                                        : YoYoPlayer(
                                            aspectRatio: 16 / 9,
                                            //url ( .m3u8 video streaming link )
                                            //example ( url :"https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8" )
                                            //example ( url :"https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101" )
                                            url: snapshot.data![index].videoUrl,
                                            videoStyle: VideoStyle(),
                                            videoLoadingStyle:
                                                VideoLoadingStyle(
                                              loading: Center(
                                                child: Text("Loading video"),
                                              ),
                                            ),
                                          ),
                                  ),
                                  Container(
                                    color: Colors.grey[900],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0,
                                              left: 15.0,
                                              bottom: 15.0),
                                          child: Text(
                                            snapshot.data![index].title,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 15.0,
                                              top: 15.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              "assets/more_info.svg",
                                              color: Colors.white,
                                              width: 15.0,
                                              height: 15.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
            }));
  }
}
