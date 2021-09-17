import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _navigatorValue = 0;
  get navigatorValue => _navigatorValue;
  // Widget _currentScreen = HomeView();

  // get currentScreen => _currentScreen;
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;

    update();
  }
}
