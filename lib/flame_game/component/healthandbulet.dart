import 'package:barilan/model/playerdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HealthAndBullet extends StatelessWidget {
  const HealthAndBullet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Playerdata>(
      builder:
          (context, pd, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  "Score: ${Provider.of<Playerdata>(context, listen: false).currentScore}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      pd.health > 0
                          ? List.generate(pd.health, (d) {
                            return Icon(Icons.favorite, color: Colors.red);
                          })
                          : List.empty(),
                ),
                Text(
                  "Bullet: ${pd.bullet}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
    );
  }
}
