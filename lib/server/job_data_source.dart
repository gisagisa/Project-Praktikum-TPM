import 'package:job/server/base_network.dart';

class JobDataSource {
  static JobDataSource instance = JobDataSource();
  Future<List<dynamic>> loadJob() {
    return BaseNetwork.get("jobList");
  }
}