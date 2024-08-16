import 'dart:ffi';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/resources/colors.dart';
import 'dart:io' show Platform;

class Article extends StatelessWidget {
  final String? imageSrc;
  final String? title;
  final String? author;
  final String? publishedDate;
  final String? url;

  const Article(
      {super.key,
      this.imageSrc,
      this.title,
      this.author,
      this.publishedDate,
      this.url});

  @override
  Widget build(BuildContext context) => Container(
        width: 320,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.09), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 3), // Changes position of shadow
              ),
            ]),
        child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: imageSrc != null && imageSrc!.isNotEmpty
                        ? Image.network(
                            imageSrc!,
                            height: 205,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage(
                                'assets/images/news_placeholder.png'),
                            width: 290,
                            height: 205,
                          )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text("$title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black))),
                const Spacer(),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                            Text(
                              publishedDate ?? '',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: CustomColors.grayTextColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              if (Platform.isAndroid) {
                                var intent = AndroidIntent(
                                  action: 'android.intent.action.SEND',
                                  type: 'text/plain',
                                  arguments: {
                                    'android.intent.extra.TEXT': '$url'
                                  },
                                  flags: <int>[
                                    Flag.FLAG_GRANT_READ_URI_PERMISSION
                                  ],
                                );
                                intent.launchChooser('Sharing link');
                              }
                            },
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.secondaryButtonColor),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/send_icon.svg',
                                  semanticsLabel: 'Send Icon',
                                  width: 18,
                                  height: 18,
                                  colorFilter: const ColorFilter.mode(
                                      CustomColors.buttonColor,
                                      BlendMode.srcIn),
                                ),
                              ),
                            ))
                      ],
                    ))
              ],
            )),
      );
}
