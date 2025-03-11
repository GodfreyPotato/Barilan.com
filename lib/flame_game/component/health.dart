import 'package:barilan/model/playerdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Health extends StatelessWidget {
  const Health({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Playerdata>(
      builder:
          (context, pd, child) => Row(
            children:
                pd.health > 0
                    ? List.generate(pd.health, (d) {
                      return Icon(Icons.favorite);
                    })
                    : List.empty(),
          ),
    );
  }
}
