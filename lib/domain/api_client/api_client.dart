import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cinema_app/domain/entity/movie_details.dart';
import 'package:cinema_app/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { network, auth, other, sessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException({required this.type});
}

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '9899cf22595146bb8cdfc17d2bb3eb1b';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? parameters]) async {
    final url = _makeUri(path, parameters);
    //final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(type: ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(type: ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());

      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(type: ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(type: ApiClientExceptionType.other);
    }
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _get(
      '/authentication/token/new',
      parser,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['id'] as int;
      return response;
    }

    final result = _get(
      '/account',
      parser,
      {
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> popularMovies(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/popular',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/search/movie',
      parser,
      {
        'api_key': _apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      '/movie/$movieId',
      parser,
      {
        'append_to_response': 'credits,videos',
        'api_key': _apiKey,
        'language': locale,
      },
    );
    return result;
  }

  Future<bool> isFavoriteMovie(
    int movieId,
    String sessionId,
  ) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = jsonMap['favorite'] as bool;
      return response;
    }

    final result = _get(
      '/movie/$movieId/account_states',
      parser,
      {
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };

    final result = _post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      {'api_key': _apiKey},
    );
    return result;
  }

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    parser(dynamic json) {
      return 1;
    }

    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };

    final result = _post(
      '/account/$accountId/favorite',
      parameters,
      parser,
      {
        'api_key': _apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };

    final result = _post(
      '/authentication/session/new',
      parameters,
      parser,
      {'api_key': _apiKey},
    );
    return result;
  }
}

void _validateResponse(HttpClientResponse response, dynamic json) {
  if (response.statusCode == 401) {
    final status = json['status_code'];
    final code = status is int ? status : 0;
    if (code == 30) {
      throw ApiClientException(type: ApiClientExceptionType.auth);
    } else if (code == 3) {
      throw ApiClientException(type: ApiClientExceptionType.sessionExpired);
    } else {
      throw ApiClientException(type: ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
