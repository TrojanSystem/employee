import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class DropDownMenuButton extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final Function button_1;

  final Function button_3;

  final Color primaryColor;

  DropDownMenuButton({this.button_1, this.button_3, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      // Cannot be `Alignment.center`
      alignment: Alignment.centerRight,
      ringColor: const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.8),
      ringDiameter: 300.0,
      ringWidth: 110.0,
      fabSize: 50.0,
      fabElevation: 8.0,
      fabIconBorder: const CircleBorder(),
      // Also can use specific color based on wether
      // the menu is open or not:
      // fabOpenColor: Colors.white
      // fabCloseColor: Colors.white
      // These properties take precedence over fabColor
      fabColor: primaryColor,
      fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: const Icon(Icons.close, color: Colors.white),
      fabMargin: const EdgeInsets.fromLTRB(16.0, 45, 16, 16),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {},
      children: <Widget>[
        RawMaterialButton(
          fillColor: Colors.green,
          onPressed: () {
            button_1();
            fabKey.currentState.close();
          },
          shape: const CircleBorder(),
          //padding: const EdgeInsets.fromLTRB(24.0, 100, 24, 24),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            button_3();
            fabKey.currentState?.close();
          },
          shape: const CircleBorder(),
          //padding: const EdgeInsets.all(24.0),
          child: const Image(
            image: AssetImage('images/contract.png'),
            width: 50,
          ),
        ),
      ],
    );
  }
}
