import 'package:flutter/material.dart';
import 'package:practice4/models/webtoon_detail_model.dart';
import 'package:practice4/models/webtton_episode_model.dart';
import 'package:practice4/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String thumb, title, id;

  const DetailScreen({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> webtoonEpisodes;

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonDetailById(id: widget.id);
    webtoonEpisodes = ApiService.getLatestEpisodesById(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(widget.thumb)),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: webtoonDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${snapshot.data!.genre}  |  ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
