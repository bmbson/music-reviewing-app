import 'package:http/http.dart' as http;
import 'dart:convert';

Future<RequestAccessTokenReponseSpotify> requestAccessTokenSpotify() async {
  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: jsonEncode(<String, String>{
      'body':
          'grant_type=client_credentials&client_id=eed858d1297648c19cb86190a923431a&client_secret=d492f4f0b44641d3bef2fdd5e2dbd735'
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return RequestAccessTokenReponseSpotify.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to get access token.');
  }
}

class RequestAccessTokenReponseSpotify {
  final String accessToken;
  final String tokenType;
  final String expiration;

  const RequestAccessTokenReponseSpotify({
    required this.accessToken,
    required this.tokenType,
    required this.expiration,
  });

  factory RequestAccessTokenReponseSpotify.fromJson(Map<String, dynamic> json) {
    return RequestAccessTokenReponseSpotify(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiration: json['expires_in'],
    );
  }
}
