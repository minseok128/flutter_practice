import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice4/models/webtoon.dart';

class ApiService {
  List<WebtoonModel> toonInstances = [];
  final String baseURL = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
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
}
