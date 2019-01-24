import 'package:flutter/material.dart';
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final String iconText;
  final double size;

  const CircleButton(
      {Key key, this.onTap, this.iconData, this.iconText, this.size})
      : assert(onTap != null),
        assert(iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkResponse(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          new Container(
            width: size != null ? size : 64.0,
            height: size != null ? size : 64.0,
            decoration: new BoxDecoration(
              color: Theme.myColor[50],
              shape: BoxShape.circle,
            ),
            child: new Icon(
              iconData,
              size: iconText != null ? 36.0 : 48.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          iconText != null
              ? Text(
                  iconText,
                  style: TextStyle(color: Colors.black,fontSize: 18.0),
                )
              : SizedBox(height: 0.0),
        ],
      ),
    );
  }
}
