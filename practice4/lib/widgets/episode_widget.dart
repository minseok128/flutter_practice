import 'package:flutter/material.dart';
import 'package:practice4/models/webtton_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  final String toonId;
  const Episode({
    Key? key,
    required this.e,
    required this.toonId,
  }) : super(key: key);

  final WebtoonEpisodeModel e;

  void onButtonTap() async {
    print(toonId);
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$toonId&no=${e.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.green.shade400,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: const Offset(2, 2),
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                e.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
