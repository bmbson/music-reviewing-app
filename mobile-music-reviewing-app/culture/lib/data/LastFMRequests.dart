import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  var futureAlbum = fetchTopGenreAlbums("rap");

  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: 1000,
              height: 1000,
              child: FutureBuilder(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.albums.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            for (Album album in snapshot.data!.albums) {
                              String imageUrl = album.albumImage;
                            }
                            return Text(snapshot.data!.page.toString());
                          });
                    } else if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                      );
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    ),
  );
}

String apiLastFmApiKey = 'ed2b1a71584e47c237a2bc6f207540cd';

Future<AlbumSearchResults> fetchTopGenreAlbums(String genre) async {
  final response = await http.get(Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=tag.gettopalbums&tag=$genre&api_key=$apiLastFmApiKey&format=json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return AlbumSearchResults.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String albumName;
  final String artistName;
  final String albumImage;
  final String url;

  Album(
      {required this.albumImage,
      required this.artistName,
      required this.albumName,
      this.url = ''});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumName: json['name'],
      artistName: json['artist']['name'],
      albumImage: json['image']['3']['#text'],
      url: json['url'],
    );
  }
}

class AlbumSearchResults {
  final String tag;
  final String page;
  final String total;
  final String perPage;
  final String totalPages;
  List<Album> albums; // Here

  AlbumSearchResults({
    required this.tag,
    required this.page,
    required this.total,
    required this.albums,
    required this.perPage,
    required this.totalPages,
  });

  factory AlbumSearchResults.fromJson(Map<String, dynamic> json) {
    return AlbumSearchResults(
      albums: json['albums']['album'],
      tag: json['albums']['@attr']['tag'],
      page: json['albums']['@attr']['page'],
      total: json['albums']['@attr']['total'],
      perPage: json['albums']['@attr']['perPage'],
      totalPages: json['albums']['@attr']['totalPages'],
    );
  }
}
