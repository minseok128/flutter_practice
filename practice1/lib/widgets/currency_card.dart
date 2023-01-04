import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final bool isInverted;
  final String name;
  final String money;
  final String symbol;
  final IconData icon;
  final int order;
  final Color _blackColor = const Color(0xFF1F2123);

  const CurrencyCard(
      {super.key,
      required this.isInverted,
      required this.name,
      required this.money,
      required this.symbol,
      required this.icon,
      required this.order});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, order * -20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 32,
                    color: isInverted ? _blackColor : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      money,
                      style: TextStyle(
                        fontSize: 24,
                        color: isInverted ? _blackColor : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      symbol,
                      style: TextStyle(
                        fontSize: 18,
                        color: (isInverted ? _blackColor : Colors.white)
                            .withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 2.2,
              child: Transform.translate(
                offset: const Offset(
                  -10,
                  16,
                ),
                child: Icon(
                  icon,
                  color: isInverted ? _blackColor : Colors.white,
                  size: 88,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
