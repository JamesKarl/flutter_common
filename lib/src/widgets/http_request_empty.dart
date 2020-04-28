import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String description;
  final String imageName;
  final bool showImage;

  const NoDataWidget(
      {Key key, this.description, this.imageName, this.showImage = true})
      : super(key: key);

  const NoDataWidget.noSearchResult() : this(description: "没有匹配的结果, 请修改关键重新搜索");

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child: buildNoDataSection(),
        ),
      ],
    );
  }

  Column buildNoDataSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        showImage
            ? Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Align(
                  alignment: Alignment(0, -0.4),
                  child: Image.asset(
                    imageName != null
                        ? "assets/icons/" + imageName + ".png"
                        : "assets/icons/" + "ico_no_data" + ".png",
                    height: 135,
                    width: 135,
                  ),
                ),
              )
            : Offstage(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment(0, 0),
            child: Text(
              description != null ? description : "暂无数据",
              style: TextStyle(fontSize: 14, color: Color(0xFFBFBFBF)),
            ),
          ),
        ),
      ],
    );
  }
}
