import 'package:flutter/material.dart';
import 'package:practice4/models/webtoon.dart';
import 'package:practice4/services/api_service.dart';
import 'package:practice4/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Today's Toons",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } else {
            return const LoadingScene();
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        //print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: index.toString(),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}

class LoadingScene extends StatelessWidget {
  const LoadingScene({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 30,
          ),
          Text('Loading...'),
        ],
      ),
    );
  }
}
