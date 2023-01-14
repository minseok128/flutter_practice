import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice4/models/webtoon.dart';
import 'package:practice4/models/webtoon_detail_model.dart';

class ApiService {
  static List<WebtoonModel> toonInstances = [];
  static String baseURL = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static String today = "today";

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

  static Future<WebtoonDetailModel> getToonDetailById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final toonDetailInstance =
          WebtoonDetailModel.fromJson(jsonDecode(response.body));
      return toonDetailInstance;
    }
    throw Error();
  }
}
