import 'package:flutter/material.dart';
import 'package:job/constants.dart';
import 'package:job/models/job_models.dart';

class CompanyTab extends StatefulWidget {
  final Jobs? job;
  CompanyTab({this.job});

  @override
  State<CompanyTab> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<CompanyTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            "About Company",
            style: kTitleStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
          Text(
            widget.job!.about!,
            style: kSubtitleStyle.copyWith(
              fontWeight: FontWeight.w300,
              height: 1.5,
              color: Color(0xFF5B5B5B),
            ),
          ),
        ],
      ),
    );
  }
}
