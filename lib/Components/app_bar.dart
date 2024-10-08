// Dependencies
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

AppBar myAppBar(BuildContext context, String title, bool share) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    leading: GestureDetector(
        onTap: () => Modular.to.canPop() ? Modular.to.pop() : null,
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        )),
    actions: [
      GestureDetector(
        onTap: () async {
          try{
          final result = await Share.share('check out my website https://example.com');
            if (result.status == ShareResultStatus.success) {
              print('Thank you for sharing my website!');
            }
            if (result.status == ShareResultStatus.dismissed) {
              print('Did you not like the pictures?');
            }
          } catch(e){
            print(e);
          }
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: share
                ? const Icon(Icons.share_outlined,
                    color: Colors.black, size: 20)
                : null),
      )
    ],
  );
}
