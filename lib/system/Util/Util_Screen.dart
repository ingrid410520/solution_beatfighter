
import 'package:flutter/material.dart';

class Util_Screen extends StatelessWidget {
  Util_Screen({super.key});
  ScreenSize _ScreenSize = new ScreenSize();
  ScreenSize Screen(context){
    _ScreenSize.width = MediaQuery.of(context).size.width;
    _ScreenSize.height = MediaQuery.of(context).size.height;
    return _ScreenSize;
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class ScreenSize
{
  double width = 0.0;
  double height = 0;
}