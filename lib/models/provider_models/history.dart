import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class HisModel extends HiveObject {
  @HiveField(0)
  late String res;
  @HiveField(1)
  late String calculations;
}