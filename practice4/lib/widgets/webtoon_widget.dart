import 'package:flutter/material.dart';

class Webtoon extends StatelessWidget {
  final String thumb, title, id;

  const Webtoon({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 250,
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
            child: Image.network(thumb)),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
