import 'package:get/get.dart';

import 'state.dart';

class AppScreenLogic extends GetxController {
  final AppScreenState state = AppScreenState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  setBillAmount(double value) {
    state.billAmount.value = value;
  }

  decreasePerson() {
    var persons = state.personCounter.value;
    if (persons > 1) {
      persons--;
    }
    state.personCounter.value = persons;
  }

  increasePerson() {
    state.personCounter.value++;
  }

  setTipPercentage(double value) {
    state.tipPercentage.value = value.round();
  }

  calculateTotalPerPerson() {
    var totalPerPerson =
        (calculateTotalTip() + state.billAmount.value.toInt()) /
            state.personCounter.value.toInt(); // splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip() {
    double totalTip = 0.0;
    if (state.billAmount.value.toInt() < 0 ||
        state.billAmount.value.toString().isEmpty ||
        state.billAmount.value == null) {
    } else {
      totalTip =
          (state.billAmount.value.toInt() * state.tipPercentage.value.toInt()) /
              100;
    }
    return totalTip;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
