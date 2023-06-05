import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/modules/backend/article/article_data.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:http/http.dart' as http;

class ArticleCard extends StatefulWidget {
  const ArticleCard({
    super.key,
    required this.articleData,
    required this.height,
    required this.width,
  });

  final ArticleData articleData;
  final double height;
  final double width;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  Uint8List? _imageByte;

  @override
  Widget build(BuildContext context) {
    if (_imageByte == null && widget.articleData.imageUrl != "") {
      http
          .get(Uri.parse(widget.articleData.imageUrl))
          .timeout(const Duration(seconds: 5))
          .then((response) => setState(() => _imageByte = response.bodyBytes))
          .catchError((_) => setState(() => _imageByte = null));
    }

    return InkWell(
      onTap: () =>
          context.push("/${MyRouter.articles}/${widget.articleData.id}"),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: const Color(0xFFf5f5f5),
          elevation: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: widget.width,
                    height: widget.height * 0.6,
                    child: Card(
                      elevation: 0,
                      color: const Color.fromARGB(243, 255, 255, 255),
                      child: _imageByte != null
                          ? Image.memory(_imageByte!, fit: BoxFit.cover)
                          : null,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 25, bottom: 25, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.articleData.title,
                          style: const TextStyle(
                              color: Color(0xFF1f1f1f),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: widget.width,
                          child: Text(widget.articleData.introduction)),
                          
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          for (String i in widget.articleData.tags) Text("#$i")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
