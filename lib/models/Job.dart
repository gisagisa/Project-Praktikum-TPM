import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'Job.g.dart';

@HiveType(typeId: 1)
class Job extends HiveObject {

  @HiveField(0)
  String email;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  Job({required this.email, required this.username, required this.password});
}
