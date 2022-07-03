import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/videoModel.dart';

class VideoServices {
  static late List<VideoModel> videos;
  static Future<List<VideoModel>> getVideos() async {
    try {
      String response = await rootBundle.loadString("lib/dataset/dataset.json");
      List data = jsonDecode(response);
      List<VideoModel> videoData =
          data.map<VideoModel>((e) => VideoModel.fromJson(e)).toList();
      videos = videoData;
      return videoData;
    } catch (e) {
      log(e.toString(), name: "Error");
      return [];
    }
  }
}
