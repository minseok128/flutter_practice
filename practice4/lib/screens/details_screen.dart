import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice4/models/webtoon_detail_model.dart';
import 'package:practice4/models/webtton_episode_model.dart';
import 'package:practice4/services/api_service.dart';
import 'package:practice4/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final List<String>? likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      prefs.setStringList('likedToons', []);
    }
  }

  void onPressedLike() async {
    final List<String>? likedToons = prefs.getStringList('likedToons');
    isLiked ? likedToons!.remove(widget.id) : likedToons!.add(widget.id);
    await prefs.setStringList('likedToons', likedToons);
    print(likedToons);
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonDetailById(id: widget.id);
    webtoonEpisodes = ApiService.getLatestEpisodesById(id: widget.id);
    initPrefs();
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
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onPressedLike,
            icon: isLiked
                ? const Icon(Icons.favorite_outlined)
                : const Icon(Icons.favorite_outline_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
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
                      return Column(
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
                      );
                    } else {
                      return const Text('...');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: webtoonEpisodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var e in snapshot.data!)
                            Episode(
                              e: e,
                              toonId: widget.id,
                            ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
