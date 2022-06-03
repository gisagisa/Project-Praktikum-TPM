import 'package:hive_flutter/hive_flutter.dart';
import 'package:job/models/Job.dart';

class HiveDatabase {
  Box<Job> localDBBox = Hive.box<Job>("jobdb");

  // void initDB() async{
  //   await Hive.initFlutter();
  //   Hive.registerAdapter(JobAdapter());
  //   await Hive.openBox("jobdb");
  // }

  void addData(Job note) {
    localDBBox.add(note);
  }

  Job? getJobAt(int position) {
    return localDBBox.getAt(position);
  }


  void deleteAt(int position) {
    localDBBox.deleteAt(position);
  }

  void putNoteAt(int position, Job value) {
    localDBBox.putAt(position, value);
  }

  int getLength() {
    return localDBBox.length;
  }
}
