import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AppScreenPage extends StatefulWidget {
  const AppScreenPage({Key? key}) : super(key: key);

  @override
  State<AppScreenPage> createState() => _AppScreenPageState();
}

class _AppScreenPageState extends State<AppScreenPage> {
  final logic = Get.put(AppScreenLogic());
  final state = Get.find<AppScreenLogic>().state;

  final Color _purple = const Color.fromRGBO(105, 8, 214, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: Get.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              width: Get.width - 100,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1), //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Per Person',
                      style: TextStyle(
                        color: _purple,
                        fontSize: 15.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(() {
                        return Text(
                          '\$ ${logic.calculateTotalPerPerson()}',
                          style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: _purple,
                      ),
                      decoration: const InputDecoration(
                        prefixText: "Bill Amount ",
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String value) {
                        try {
                          logic.setBillAmount(double.parse(value));
                        } catch (e) {
                          logic.setBillAmount(0.0);
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              logic.decreasePerson();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            return Text(
                              state.personCounter.value.toString(),
                              style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              logic.increasePerson();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Obx(() {
                          return Text(
                            "\$ ${(logic.calculateTotalTip()).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          );
                        }),
                      ),
                    ],
                  ),
                  //Slider
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Text(
                          '${state.tipPercentage.value}%',
                          style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        );
                      }),
                      Obx(() {
                        return Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          //divisions: 20,
                          value: state.tipPercentage.value.toDouble(),
                          onChanged: (double value) {
                            logic.setTipPercentage(value);
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<AppScreenLogic>();
    super.dispose();
  }
}
