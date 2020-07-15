import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {Key key,
        this.leading,
        @required this.title,
        this.trailing,
        this.subtitle, this.onTap, this.action, this.centerTitle})
      : super(key: key);

  final Widget leading, title, trailing, subtitle;
  final Function onTap;
  final String action;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFD1D1D1), width: action != null ? 1 : 0)
          )
        ),
        child: Row(
          children: <Widget>[
            this.leading ?? Container(),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: centerTitle != null ? 30.w : 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    this.title,
                    this.subtitle == null
                        ? Container()
                        : SizedBox(
                      height: 3.sp,
                    ),
                    this.subtitle ?? Container(),
                  ],
                ),
              ),
            ),
            this.trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
