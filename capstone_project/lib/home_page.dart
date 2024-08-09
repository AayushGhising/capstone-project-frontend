import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       decoration:
      //           BoxDecoration(color: const Color.fromARGB(255, 180, 177, 243)),
      //     ),
      //     Container(
      //       decoration:
      //           BoxDecoration(color: const Color.fromARGB(255, 242, 247, 250)),
      //     )
      //   ],
      // ),
      body: Container(
        color: const Color.fromARGB(255, 242, 247, 250),
        child: Stack(
          children: [
            Container(
              height: 400,
              color: const Color.fromARGB(255, 180, 177, 243),
            ),
            Column(
              children: [
                const SizedBox(height: 200),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 242, 247, 250),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 186, 186, 186),
                            offset: Offset(0, -2),
                            blurRadius: 10.0,
                          )
                        ]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
