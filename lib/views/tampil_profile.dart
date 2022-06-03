import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job/data/hive_database.dart';
import 'package:job/data/shared_pref.dart';
import 'package:job/models/Job.dart';
import 'package:job/views/login_page.dart';
import 'package:job/views/register_page.dart';
import 'package:job/views/job_detail.dart';

class TampilUser extends StatefulWidget {
  const TampilUser({Key? key}) : super(key: key);

  @override
  State<TampilUser> createState() => _TampilUserState();
}

class _TampilUserState extends State<TampilUser> {
  HiveDatabase _hd = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JobDetail()));
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ValueListenableBuilder(
          valueListenable: _hd.localDBBox.listenable(),
          builder: (BuildContext context, Box<dynamic> value, Widget? child) {
            if (value.isEmpty) {
              return Text("Data Kosong");
            } else {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return _cardItemList(index);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _cardItemList(int index) {
    Job? job = _hd.getJobAt(index);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegisterPage(
                job: job,
                index: index,
              );
            }));
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          "${job?.username}",
                        ),
                        Text("${job?.email}"),
                        Text("${job?.password}"),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _hd.deleteAt(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
