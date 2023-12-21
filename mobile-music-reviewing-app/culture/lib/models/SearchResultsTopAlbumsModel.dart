import 'package:culture/models/GenreSearchModels/AlbumModel.dart';
import 'package:flutter/material.dart';


class SearchResultsTopAlbums {
  final String tag;
  final String page;
  final String total;
  List<Album> albums;
  final String totalPages;

  SearchResultsTopAlbums({
    required this.tag,
    required this.page,
    required this.albums,
    required this.total,
    required this.totalPages,
  });

  factory SearchResultsTopAlbums.fromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> albumList = jsonData['albums']['album'];
    final List<Album> albums = [];

    try {
      for (var album in albumList) {
        albums.add(Album.fromJson(album));
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return SearchResultsTopAlbums(
      tag: jsonData['albums']['@attr']['tag'],
      albums: albums,
      page: jsonData['albums']['@attr']['page'],
      total: jsonData['albums']['@attr']['total'],
      totalPages: jsonData['albums']['@attr']['totalPages'],
    );
  }
}
