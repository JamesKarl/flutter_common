import 'dart:ui' show Color;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ui {
  Ui._();

  ///导航栏背景色
  static const Color primaryColor = const Color(0xFF003170);

  ///页面的底色
  static const pageBackground = const Color(0xfff7f7f7);

  ///大部分按钮背景色
  static const Color btnBgColor = const Color(0xffFA8C16);

  ///CheckBox选中时的颜色
  static const Color checkboxActiveColor = const Color(0xffFA8C16);

  ///TabBar
  static const Color tabBarUnselectedLabelColor = const Color(0xff999999);

  static const Color tabBarLabelColor = const Color(0xffFA8C16);

  ///导航文字
  static const Color textColorNavigation = const Color(0xFF252525);

  ///标题文字
  static const Color textColorTitle = const Color(0xFF252525);

  ///正文文字
  static const Color textColorBody = const Color(0xff666666);

  ///提示文字
  static const Color textColorPrompt = const Color(0xFF999999);

  ///链接文字
  static const Color textColorLink = const Color(0xFF1890ff);

  ///警告文字
  static const Color textColorWarning = const Color(0xFFff4d4f);

  ///解释文字
  static const Color textColorExplain = const Color(0xFF666666);

  ///更多按钮颜色
  static const Color _moreIconColor = const Color(0xFF999999);

  ///popMenuBgColor
  static const Color popMenuBgColor = const Color(0xFF999999);

  static const Color lineColor = const Color(0xFFdddddd);

  static const Color maskColor = const Color.fromRGBO(0x0, 0x0, 0x0, 0.3);

  static const Color yellowDarkColor = const Color(0xFFFFA940);
  static const Color yellowLightColor = const Color(0xFFFFF7E6);

  static const Color greenDarkColor = const Color(0xFF36CFC9);
  static const Color greenLightColor = const Color(0xFFE6FFFB);

  static const Color blueDarkColor = const Color(0xFF40A9FF);
  static const Color blueLightColor = const Color(0xFFE6F7FF);

  static const Color pinkDarkColor = const Color(0xFF9254DE);
  static const Color pinkLightColor = const Color(0xFFF9F0FF);

  static const Color chartYellow = const Color(0xFFFADB14);
  static const Color chartRed = const Color(0xFFFF4D4F);
  static const Color chartBlue = const Color(0xFF1890FF);
  static const Color chartGreen = const Color(0xFF2FC25B);

  static const Color paySuccess = const Color(0xFF2BB66B);
  static const Color payFail = const Color(0xFFF55C5E);

  static const double textSizeExplain = 12;

  ///标签文字
  static const Color textColorTag = const Color(0xFF999999);

  ///公司类型标签
  static const Color tagCompanyTextColor = const Color(0xFF97A2B4);
  static const Color tagCompanyBgColor = const Color(0xFFF7FAFF);
  static const companyTypeTagStyle =
      const TextStyle(color: tagCompanyTextColor, fontSize: 11);

  ///导航文字
  static const navigationTextStyle =
      const TextStyle(color: textColorNavigation, fontSize: 24);

  ///标题文字
  static const titleTextStyle =
      const TextStyle(color: textColorTitle, fontSize: 18);

  ///正文文字
  static const bodyTextStyle =
      const TextStyle(color: textColorBody, fontSize: 14);

  ///提示文字
  static const promptTextStyle =
      const TextStyle(color: textColorPrompt, fontSize: 14);

  ///链接文字
  static const linkTextStyle =
      const TextStyle(color: textColorLink, fontSize: 14);

  ///警告文字
  static const warningTextStyle =
      const TextStyle(color: textColorWarning, fontSize: 14);

  ///解释文字
  static const explainTextStyle =
      const TextStyle(color: textColorExplain, fontSize: 12);

  ///标签文字
  static const tagTextStyle =
      const TextStyle(color: textColorTag, fontSize: 14);

  ///下一步/确定按钮
  static const nextOrSureBtnStyle =
      const TextStyle(color: Colors.white, fontSize: 14);

  ///
  static const collectBtnStyle =
      const TextStyle(color: Colors.white, fontSize: 10);

  ///页面底部的Action Button相对于BottomAppBar的padding值
  static const EdgeInsets bottomActionPadding =
      const EdgeInsets.symmetric(horizontal: 12, vertical: 4);

  ///一些[编辑]文本的样式
  static const TextStyle actionTextStyle =
      const TextStyle(color: btnBgColor, fontSize: 14);

  ///日期文本
  static const dateTextColor =
      const TextStyle(color: Color(0xff1890FF), fontSize: 15);

  ///电话号码
  static const phoneTextColor =
      const TextStyle(color: Color(0xff1890FF), fontSize: 14);

  ///必填项目-错误提示文本
  static const requiredTextStyle = const TextStyle(
      color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold);

  ///键值对-键
  static const sectionTextStyle = const TextStyle(
    color: const Color(0xff999999),
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  ///不可编辑
  static const noEditableTextStyle =
      const TextStyle(color: const Color(0xffbbbbbb), fontSize: 14);

  ///加粗显示某些编辑
  static const focusEditableTextStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 14,
      fontWeight: FontWeight.w900);

  ///加粗显示某些编辑
  static const focusEditableLabelStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 14,
      fontWeight: FontWeight.w300);

  ///键值对-键
  static const keyTextStyle =
      const TextStyle(color: const Color(0xff999999), fontSize: 13);

  ///用于控制输入框的文字和label之间的高度
  static const textFormFieldStructStyle = StrutStyle(height: 1.5);

  ///键值对-值
  static const valueTextStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 13);

  ///InputDecoratorLabel默认样式
  static const inputDecoratorLabelStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 13);

  ///输入框字体默认样式
  static const textFieldTextStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 13);

  ///输入框字体默认样式
  static const orderTitleTextStyle =
      const TextStyle(color: const Color(0xff252525), fontSize: 15);

  ///输入框右下角的数字
  static Widget textFieldCounterBuilder(
    BuildContext context, {
    int currentLength,
    @required int maxLength,
    @required bool isFocused,
  }) {
    if (isFocused) {
      return Text(
        "$currentLength/$maxLength",
        style: smallNoteTextStyle,
      );
    } else {
      return null;
    }
  }

  ///隐藏最大支持字符数限制
  static Widget textFieldCounterBuilderNone(
    BuildContext context, {
    int currentLength,
    @required int maxLength,
    @required bool isFocused,
  }) {
    return null;
  }

  ///键值对-键2
  static const sectionLabelTextStyle =
      const TextStyle(color: const Color(0xff999999), fontSize: 15);

  ///键值对-键2
  static const key2TextStyle =
      const TextStyle(color: const Color(0xff999999), fontSize: 14);

  ///键值对-值2
  static const value2TextStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 14);

  static const unitTextStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 13);

  ///disableBtnStyle
  static const disableBtnStyle =
      const TextStyle(color: const Color(0xffBFBFBF), fontSize: 14);

  ///角标
  static const smallNoteTextStyle =
      const TextStyle(color: const Color(0xffBFBFBF), fontSize: 11);

  ///底部小字黑色
  static const smallBotTextStyle =
      const TextStyle(color: const Color(0xff000000), fontSize: 12);

  ///底部小字黑色
  static const titleNameTextStyle =
      const TextStyle(color: const Color(0xff000000), fontSize: 16);

  ///钱相关的数字
  static const moneyTextStyle = const TextStyle(
    color: const Color(0xffFA8C16),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  ///钱相关的数字 加粗
  static const moneyTextBoldStyle = const TextStyle(
      color: const Color(0xffFA8C16),
      fontSize: 18,
      fontWeight: FontWeight.bold);

  ///nameAndPhone
  static const nameTextStyle =
      const TextStyle(color: const Color(0xff252525), fontSize: 15);

  ///nameAndPhone
  static const menuTitleStyle =
      const TextStyle(color: const Color(0xff252525), fontSize: 17);

  ///吨橙色
  static const tonTextStyle = const TextStyle(
      color: const Color(0xffFA8C16),
      fontSize: 15,
      fontWeight: FontWeight.bold);

  ///标题上的日期，黑色粗体
  static const titleDateTextStyle = const TextStyle(
      color: const Color(0xff252525),
      fontSize: 15,
      fontWeight: FontWeight.bold);

  ///标题样式
  static const subjectTextStyle =
      const TextStyle(color: const Color(0xff666666), fontSize: 15);

  ///右导航烂按钮文字
  static const navRightItemStyle =
      const TextStyle(color: const Color(0xffffffff), fontSize: 17);

  ///细节样式
  static const detailTextStyle =
      const TextStyle(color: const Color(0xff999999), fontSize: 13);

  ///popMenu字体样式
  static const popMenuStyle =
      const TextStyle(color: const Color(0xff999999), fontSize: 15);

  ///例如(分享到)
  static const cardSubTextStyle =
      const TextStyle(color: const Color(0xffBFBFBF), fontSize: 13);

  ///例如(取消按钮)
  static const statusBtnStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 14);

  static const arriveTimeStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 13);

  ///例如(已付款)
  static const statusPayStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 13);

  ///成员角色
  static const staffStatusStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 10);

  ///例如(编辑)
  static const optionStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 15);

  ///公司名称按钮
  static const companyNameStyle =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 17);

  static const text11_99 =
      const TextStyle(color: const Color(0xff999999), fontSize: 11);

  static const text15_25 =
      const TextStyle(color: const Color(0xff252525), fontSize: 15);

  static const text14_25 =
      const TextStyle(color: const Color(0xff252525), fontSize: 14);

  static const text13_25 =
      const TextStyle(color: const Color(0xff252525), fontSize: 13);

  static const text15_66 =
      const TextStyle(color: const Color(0xff666666), fontSize: 15);

  static const text15_yellow =
      const TextStyle(color: const Color(0xffFA8C16), fontSize: 15);

  static const text15_bf =
      const TextStyle(color: const Color(0xffbfbfbf), fontSize: 15);

  static const text13_99 =
      const TextStyle(color: const Color(0xff999999), fontSize: 13);

  static const text13_bf =
      const TextStyle(color: const Color(0xffbfbfbf), fontSize: 13);

  static const text14_99 =
      const TextStyle(color: const Color(0xff999999), fontSize: 14);

  static const text14_white =
      const TextStyle(color: const Color(0xffffffff), fontSize: 14);

  static const text14_66 =
      const TextStyle(color: const Color(0xff666666), fontSize: 14);

  static const text16_99 =
      const TextStyle(color: const Color(0xff999999), fontSize: 16);

  static const text16_white =
      const TextStyle(color: const Color(0xffffffff), fontSize: 16);

  static const text15_white =
      const TextStyle(color: const Color(0xffffffff), fontSize: 15);

  static const text14_blue =
      const TextStyle(color: const Color(0xFF1890ff), fontSize: 14);

  static const text15_blue =
      const TextStyle(color: const Color(0xFF1890ff), fontSize: 15);

  static const text14_yellow =
      const TextStyle(color: const Color(0xFFFA8C16), fontSize: 14);

  static const fromText = const Text('起:',
      style: const TextStyle(color: Color(0xff1890FF), fontSize: 15));

  static const toText = const Text('终:',
      style: const TextStyle(color: Color(0xfffa8c16), fontSize: 15));

  ///水平方向的...
  static const moreIcon = const Icon(Icons.more_horiz, color: _moreIconColor);

  ///导航栏...
  static const moreNavIcon = const Icon(Icons.more_horiz, color: Colors.white);

  ///圆角矩形边框
  static const roundedBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)));

  ///卡片圆角
  static const cardBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)));

  ///输入框圆形边框
  static const inputRoundBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)));

  ///带有灰色边框的输入框
  static const inputBorderWithGrayOutline = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: lineColor));

  ///卡片阴影
  static const cardElevation = 0.0;

  ///AppBar右边弹出菜单的偏移量
  static const appBarPopupMenuOffset = const Offset(0, 56);

  ///Car部分的弹出菜单的偏移量
  static const popupMenuOffset = const Offset(0, 40);

  ///BottomSheet 标题样式
  static const bottomSheetTitleTextStyle =
      const TextStyle(color: const Color(0xff252525), fontSize: 18);

  ///BottomSheet 垂直方法的margin值
  static const bottomSheetTitleVerticalMargin = 16.0;

  ///对话框确定按钮的样式
  static const raisedButtonTextStyle =
      const TextStyle(color: Colors.white, fontSize: 16);

  static const flatButtonTextStyle =
      const TextStyle(color: const Color(0xffBFBFBF), fontSize: 14);

  ///页面最顶端的card的margin值
  static const topCardMargin =
      EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 12);

  ///页面最底部的card的margin值
  static const bottomCardMargin =
      EdgeInsets.only(left: 4, right: 4, bottom: 12, top: 4);

  ///Ｃard的Ｐadding
  static const cardPadding = 8.0;

  ///外边距
  static const pagePadding = 8.0;

  ///内容外边距
  static const pageContentPadding = 15.0;

  ///cardTitleHeight card标题高度
  static const cardTitleHeight = 50.0;

  ///cardSpace card间距
  static const cardSpace = 3.5;

  ///cardContentRowHeight card内容row高度
  static const cartContentHeight = 29.0;

  ///cardContentRowHeight2 card内容row高度
  static const cart2ContentHeight = 36.0;
  static const contentMargin = 7.5;

  ///内容顶部距离标题高度
  static const cardContentTopHeight = 9.0;

  ///内容底部距离card高度
  static const cardContentBottomHeight = 5.0;
  static const cardTitleToIconMargin = 10.0;

  ///身份证宽高比．
  static const idCardAspectRatio = 1.6;

  ///ｐop　up menu 宽度
  static const double popupMenuWidth2W = 80;
  static const double popupMenuWidth4W = 110;

  ///CupertinoSegmentedControl 文字大小
  static const segmentedControlTextStyle = const TextStyle(fontSize: 15);

  static const expansionItemHeight = 45.0;

  ///hint 的样式, e.g 搜索框.
  static const hintStyle =
      const TextStyle(color: textColorPrompt, fontSize: 14);

  ///创建一个黄色的竖线
  static Widget createIndicator() => Container(
        color: Ui.btnBgColor,
        height: 15,
        width: 3,
        margin: EdgeInsets.only(right: 10),
      );

  ///创建一个用于BottomSheet的AppBar
  static Widget createAppBarOfBottomSheet(String title) => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfafafa),
        elevation: 0,
        iconTheme: IconThemeData(color: textColorTitle),
        centerTitle: true,
        title: Text(
          title ?? "标题",
          style: TextStyle(color: textColorTitle),
        ),
        actions: <Widget>[CloseButton()],
      );

  ///创建底部大button
  static Widget createBottomButton(String text, VoidCallback onPressed) =>
      RaisedButton(
        color: Ui.btnBgColor,
        disabledColor: const Color(0xffd8d8d8),
        textColor: Colors.white,
        disabledTextColor: const Color(0xffbfbfbf),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(text, style: TextStyle(fontSize: 15)),
      );

  ///card头部尾部间隔
  static EdgeInsets cardMargin(int index) {
    if (index == 0) {
      return EdgeInsets.only(
          top: Ui.cardPadding, left: Ui.cardPadding, right: Ui.cardPadding);
    } else {
      return EdgeInsets.only(
          top: Ui.cardSpace, left: Ui.cardPadding, right: Ui.cardPadding);
    }
  }

  static EdgeInsets cardDefaultMargin =
      EdgeInsets.only(left: 8, right: 8, top: 8);

  static Widget createTrendingIndicator(bool trendingUp) {
    return Container(
      width: 20,
      height: 20,
      color: trendingUp ? const Color(0xfff55c5e) : const Color(0xff52c41a),
      child: Icon(
        trendingUp ? Icons.trending_up : Icons.trending_down,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  ///Widget占位符
  static const Widget zeroWidget = const SizedBox(width: 0, height: 0);

  ///搜索图标
  static const Widget searchIcon = Icon(Icons.search, size: 24);

  ///Fixed size loading
  static const Widget defaultLoading = Align(
    child: SizedBox(
      height: 40,
      width: 40,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CupertinoActivityIndicator(),
      ),
    ),
  );

  static Widget buildWaitingSection(String loadingText) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24),
            CupertinoActivityIndicator(radius: 18),
            SizedBox(height: 12),
            Text(loadingText, style: TextStyle(color: const Color(0xFF999999))),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget buildIconWithCircle(IconData icon) {
    return CircleAvatar(
      maxRadius: 8,
      backgroundColor: Color(0xff999999),
      child: Icon(
        icon,
        color: Colors.white,
        size: 12,
      ),
    );
  }

  static const rightArrow = const Icon(
    Icons.keyboard_arrow_right,
  );

  static const clearIcon = const Icon(
    Icons.clear,
    color: lineColor,
  );

  static const upArrow = const Icon(
    Icons.keyboard_arrow_up,
    color: lineColor,
  );

  static const downArrow = const Icon(
    Icons.keyboard_arrow_down,
    color: Colors.grey,
  );

  static Widget defaultTextFieldWidget() {
    return Container(
      width: 16,
      alignment: Alignment.center,
      child: Text(
        '*',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  static Widget defaultEmptyTextFieldWidget() {
    return Container(width: 16);
  }

  static Widget commonFormField(
    String key,
    String value,
    String hint, {
    bool enable = true,
    String unit,
    bool number = false,
    bool selector = false,
    FormFieldValidator<String> validator,
    GestureTapCallback onTap,
    TextEditingController controller,
  }) {
    final field = TextFormField(
      style: enable || selector ? Ui.valueTextStyle : Ui.cardSubTextStyle,
      strutStyle: Ui.textFormFieldStructStyle,
      enabled: enable && !selector,
      keyboardType: number ? TextInputType.number : null,
      initialValue: controller == null ? value : null,
      controller: controller,
      decoration: InputDecoration(
          labelText: key,
          hintText: hint,
          suffixText: !selector && unit != null ? unit : null,
          suffix: selector ? Ui.rightArrow : null),
      validator: validator,
    );
    return selector ? InkWell(child: field, onTap: onTap) : field;
  }

  static Widget commonInputField(
    String key,
    String value,
    String hint, {
    bool enable = true,
    String unit,
    bool number = false,
    bool selector = false,
    ValueChanged<String> onChanged,
    GestureTapCallback onTap,
    TextEditingController textEditingController,
    int maxLength,
  }) {
    final field = TextField(
      style: enable || selector ? Ui.valueTextStyle : Ui.cardSubTextStyle,
      strutStyle: Ui.textFormFieldStructStyle,
      enabled: enable && !selector,
      keyboardType: number ? TextInputType.number : null,
      maxLength: maxLength,
      controller:
          textEditingController ?? TextEditingController(text: value ?? ""),
      decoration: InputDecoration(
          labelText: key,
          hintText: hint,
          suffixText: !selector && unit != null ? unit : null,
          suffix: selector ? Ui.rightArrow : null,
          counterText: ''),
      onChanged: onChanged,
    );
    return selector ? InkWell(child: field, onTap: onTap) : field;
  }

  static Widget createTag(
    String label,
    bool active, {
    double width = 60,
    double height = 30,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Text(label,
          style: TextStyle(
            color: active ? const Color(0xffFA8C16) : const Color(0xffbfbfbf),
          )),
      decoration: BoxDecoration(
          color: active ? const Color(0xFFFFE7BA) : Colors.white,
          border: Border.all(
              color:
                  active ? const Color(0xffFA8C16) : const Color(0xffDDDDDD)),
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }

  static Widget createLabel(
    String label, {
    Color labelColor = const Color(0xff2BB66B),
    Color bgColor = const Color(0xffECFCE9),
    Color borderColor,
    double labelSize = 13.0,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 28,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(label ?? "",
          style: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          )),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
