import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice4/models/webtoon.dart';
import 'package:practice4/models/webtoon_detail_model.dart';
import 'package:practice4/models/webtton_episode_model.dart';

class ApiService {
  static List<WebtoonModel> toonInstances = [];
  static String baseURL = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static String today = "today";
  static String episodes = "episodes";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        toonInstances.add(toon);
      }
      return toonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonDetailById(
      {required String id}) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final toonDetailInstance =
          WebtoonDetailModel.fromJson(jsonDecode(response.body));
      return toonDetailInstance;
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      {required String id}) async {
    List<WebtoonEpisodeModel> toonEpisodesInstances = [];
    final url = Uri.parse('$baseURL/$id/$episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodeJson = jsonDecode(response.body);
      for (var e in episodeJson) {
        final episode = WebtoonEpisodeModel.fromJson(e);
        toonEpisodesInstances.add(episode);
      }
      return toonEpisodesInstances;
    }
    throw Error();
  }
}
