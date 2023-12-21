import 'package:culture/models/GetAlbumInfoModels/TrackInfoModel.dart';


import 'package:flutter/material.dart';

class AlbumInfo {
  final String albumName;
  final String artistName;
  late final String releaseDate;
  final String albumImageUrl;
  final List<Tag> tags;
  final List<TrackInfo> tracks;

  AlbumInfo(
      {required this.albumName,
      required this.artistName,
      required this.releaseDate,
      required this.albumImageUrl,
      required this.tracks,
      required this.tags});

  factory AlbumInfo.fromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> tracksJson = jsonData['album']['tracks']['track'];
    final List<dynamic> tagsJson = jsonData['album']['tags']['tag'];

    final List<Tag> tags = [];
    final List<TrackInfo> tracks = [];

    try {
      for (var track in tracksJson) {
        tracks.add(TrackInfo.fromJson(track));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      for (var tag in tagsJson) {
        tags.add(Tag.fromJson(tag));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    if (jsonData['album']['wiki']['published'] == null) {
      jsonData['album']['wiki']['published'] = '1999';
    }

    return AlbumInfo(
      albumName: jsonData['album']['name'],
      artistName: jsonData['album']['artist'],
      releaseDate: jsonData['album']['wiki']['published'],
      albumImageUrl: jsonData['album']['image'][3]['#text'],
      tags: tags,
      tracks: tracks,
    );
  }
}

class Tag {
  final String tagName;

  Tag({
    required this.tagName,
  });

  factory Tag.fromJson(Map<String, dynamic> jsonData) {
    return Tag(tagName: jsonData['name']);
  }
}
