import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:barilan/screen/homeScreen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(Baril());
}

class Baril extends StatelessWidget {
  const Baril({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Playerdata(),
      child: MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false),
    );
  }
}
