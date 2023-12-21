
import 'package:culture/models/SearchResultsTopAlbumsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var apiKey = 'ed2b1a71584e47c237a2bc6f207540cd';

Future<SearchResultsTopAlbums> getTopAlbums(String genre) async {
  final response = await http.post(
    Uri.parse(
        'http://ws.audioscrobbler.com/2.0/?method=tag.gettopalbums&tag=$genre&api_key=$apiKey&format=json&limit=50'),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return SearchResultsTopAlbums.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to get topAlbums');
  }
}
