import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/video.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, []);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    log(query);
    return ListView.builder(
      itemCount: query == ""
          ? VideoServices.videos
              .where((element) =>
                  element.title.toLowerCase().contains(query.toLowerCase()))
              .length
          : VideoServices.videos.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(query == ""
            ? VideoServices.videos
                .where((element) =>
                    element.title.toLowerCase().contains(query.toLowerCase()))
                .toList()[index]
                .title
            : VideoServices.videos[index].title),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: VideoServices.videos
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .length,
      itemBuilder: (context, index) => ListTile(
        title: Text(VideoServices.videos
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList()[index]
            .title),
      ),
    );
  }
}
