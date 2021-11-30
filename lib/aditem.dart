part of 'mbads.dart';

class AdItem{
  /*
  * 代码位
  * */
  late String codeNo;

  /*
  * ios代码位(可以为空,空的时候用codeNo)
  * */
  String iosCodeNo = "";
  /*
  *  平台
  *   1:穿山甲
  * */
  late int plat;


  AdItem(this.codeNo, this.iosCodeNo, this.plat);

  Map toJson() {
    Map map = {};
    map["codeNo"] = codeNo;
    map["iosCodeNo"] = iosCodeNo;
    map["plat"] = plat;
    return map;
  }

}