// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Sizing {
  Sizing._();

  static void init(BuildContext context, [double? base, double? vbase]) {
    var v = View.of(context);
    screenSize = v.physicalSize / v.devicePixelRatio;
    if (kDebugMode) print('Screen size: $screenSize');
    if (base != null) Sizing.base = base;
    if (vbase != null) Sizing.vbase = vbase;
  }

  static double base = 390.0;

  static double vbase = 812.0;

  static late Size screenSize;

  static get coef => screenSize.width / base;

  static get vcoef => screenSize.height / vbase;

  static double getWidthScaled(double width) {
    return width * coef;
  }

  static double width(double width) => getWidthScaled(width);

  static double getHeightScaled(double height) {
    return height * vcoef;
  }

  static double height(double height) => getHeightScaled(height);

  static Widget verticalSpacer(double spacing) {
    return SizedBox(height: getWidthScaled(spacing));
  }

  static Widget horizontalSpacer(double spacing) {
    return SizedBox(width: getWidthScaled(spacing));
  }

  static Widget spacer(double spacing) {
    return SizedBox(
        height: getWidthScaled(spacing), width: getWidthScaled(spacing));
  }

  static EdgeInsets edgeInsets({
    double? t,
    double? b,
    double? l,
    double? r,
    double? x,
    double? tx,
    double? bx,
    double? y,
    double? ly,
    double? ry,
    double? all,
  }) {
    if (t != null) t = getWidthScaled(t);
    if (b != null) b = getWidthScaled(b);
    if (l != null) l = getWidthScaled(l);
    if (r != null) r = getWidthScaled(r);
    if (x != null) x = getWidthScaled(x);
    if (tx != null) tx = getWidthScaled(tx);
    if (bx != null) bx = getWidthScaled(bx);
    if (y != null) y = getWidthScaled(y);
    if (ly != null) ly = getWidthScaled(ly);
    if (ry != null) ry = getWidthScaled(ry);
    if (all != null) all = getWidthScaled(all);
    return EdgeInsets.only(
      top: t ?? tx ?? y ?? ly ?? ry ?? all ?? 0,
      bottom: b ?? bx ?? y ?? ly ?? ry ?? all ?? 0,
      left: l ?? ly ?? x ?? tx ?? bx ?? all ?? 0,
      right: r ?? ry ?? x ?? tx ?? bx ?? all ?? 0,
    );
  }

  static Radius radius(double width) {
    return Radius.circular(Sizing.getWidthScaled(width));
  }

  static Radius get radiusInf {
    return const Radius.circular(999999999);
  }

  static BorderRadius borderRadius({
    double? tl,
    double? tr,
    double? bl,
    double? br,
    double? t,
    double? b,
    double? l,
    double? r,
    double? all,
  }) {
    Radius? _tl = tl == null ? null : radius(tl);
    Radius? _tr = tr == null ? null : radius(tr);
    Radius? _bl = bl == null ? null : radius(bl);
    Radius? _br = br == null ? null : radius(br);
    Radius? _t = t == null ? null : radius(t);
    Radius? _b = b == null ? null : radius(b);
    Radius? _l = l == null ? null : radius(l);
    Radius? _r = r == null ? null : radius(r);
    Radius? _all = all == null ? null : radius(all);
    return BorderRadius.only(
      topLeft: _tl ?? _t ?? _l ?? _all ?? Radius.zero,
      topRight: _tr ?? _t ?? _r ?? _all ?? Radius.zero,
      bottomLeft: _bl ?? _b ?? _l ?? _all ?? Radius.zero,
      bottomRight: _br ?? _b ?? _r ?? _all ?? Radius.zero,
    );
  }

  static BorderRadius get borderRadiusInf {
    return BorderRadius.all(radiusInf);
  }

  static Size size({double? width, double? height}) =>
      Size(getWidthScaled(width ?? 0), getWidthScaled(height ?? 0));
  static Size sizeOrInf({double? width, double? height}) => Size(
      width == null ? double.infinity : getWidthScaled(width),
      height == null ? double.infinity : getWidthScaled(height));

  static Offset offset({double? x, double? y}) =>
      Offset(getWidthScaled(x ?? 0), getWidthScaled(y ?? 0));
}
