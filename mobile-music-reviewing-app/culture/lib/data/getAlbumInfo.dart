import 'package:culture/models/GetAlbumInfoModels/AlbumInfoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var apiKey = 'ed2b1a71584e47c237a2bc6f207540cd';
String artist = 'Cher';
String album = "Believe";

Future<AlbumInfo> getAlbumInfo(String artist, String album) async {
  final response = await http.post(
    Uri.parse(
        'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=$apiKey&artist=$artist&album=$album&format=json'),
    //http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=ed2b1a71584e47c237a2bc6f207540cd&artist=Cher&album=Believe&format=json
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return AlbumInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to get Album Info');
  }
}
