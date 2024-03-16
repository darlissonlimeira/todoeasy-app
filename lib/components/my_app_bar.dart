import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? action;

  const MyAppBar({super.key, this.leading, this.action});

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).viewPadding.top;

    return PreferredSize(
      preferredSize: Size((MediaQuery.of(context).size.width), 85),
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            leading ??
                const SizedBox(
                  width: 40,
                  height: 40,
                ),
            const Expanded(
              flex: 1,
              child: Text(
                "TodoEasy",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            action ??
                const SizedBox(
                  width: 40,
                  height: 40,
                ),
          ]),
        ),
      ),
    );
  }

  // IconButton _accountMenuBtn(Function()? onPressed) {
  //   return IconButton.filled(
  //       icon: SvgPicture.asset(
  //         "assets/icons/profile.svg",
  //         height: 18,
  //         width: 18,
  //       ),
  //       onPressed: onPressed,
  //       style: const ButtonStyle(

  //           // padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
  //           //     EdgeInsets.all(15)),
  //           backgroundColor: MaterialStatePropertyAll<Color>(
  //               Color.fromARGB(150, 200, 191, 255))));
  // }
}
