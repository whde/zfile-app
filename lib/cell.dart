import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Cell extends StatefulWidget {
  const Cell({
    Key? key,
    required this.img,
    required this.originUrl,
    this.name,
  }) : super(key: key);

  final String img;
  final String originUrl;
  final String? name;

  @override
  CellState createState() => CellState();
}

class CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 42,
                height: 53,
                child: widget.img.contains('http')
                    ? CachedNetworkImage(
                        imageUrl: widget.img,
                        errorWidget: (context, url, error) => CachedNetworkImage(
                            imageUrl: widget.originUrl
                        ),
                      )
                    : Image.asset(widget.img),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name != null ? widget.name! : "未知磁盘",
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'PingFangSC-Medium',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          const Divider(
            height: 1.0,
            indent: 50.0,
          ),
        ]));
  }
}
