import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job/constants.dart';
import 'package:job/views/job_detail.dart';
import 'package:job/widgets/company_card.dart';
import 'package:job/widgets/company_card2.dart';
import 'package:job/widgets/recent_job_card.dart';
import 'package:flutter/widgets.dart';
import 'package:job/models/job_models.dart';
import 'package:job/server/job_data_source.dart';
import 'package:job/data/shared_pref.dart';
import 'package:job/views/login_page.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            top: 12.0,
            bottom: 12.0,
            right: 12.0,
          ),
          // child: SvgPicture.asset(
          //   "assets/drawer.svg",
          //   color: kBlack,
          // ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
          SizedBox(width: 18.0)
        ],
      ),

      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: FutureBuilder<String>(
                  future: SharedPref().getUsername(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Text(
                      "Hi ${snapshot.data}, \nFind your Dream Job",
                      style: kPageTitleStyle,
                    );
                  },
                ),
                // child: Text(
                //   "Hi Robert,\nFind your Dream Job",
                //   style: kPageTitleStyle,
                // ),
              ),
              SizedBox(height: 25.0),
              Container(
                width: double.infinity,
                height: 50.0,
                margin: EdgeInsets.only(right: 18.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          child: TextField(
                            cursorColor: kBlack,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                                size: 25.0,
                                color: kBlack,
                              ),
                              border: InputBorder.none,
                              hintText: "Search for job title",
                              hintStyle: kSubtitleStyle.copyWith(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        color: kBlack,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        FontAwesomeIcons.slidersH,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35.0),

              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  "Popular Company",
                  style: kTitleStyle,
                ),
              ),
              SizedBox(height: 15.0),
              
              Container(
                  width: double.infinity,
                  height: 190.0,
                  child: FutureBuilder(
                      future: JobDataSource.instance.loadJob(),
                      //debugPrint("\n\n\n\ndata : ${JobDataSource.instance.loadJob()}");
                      builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                          ) {
                          if (snapshot.hasError) {
                            debugPrint("\n\n\n\nhasError: ${snapshot}");
                            return _buildErrorSection();
                          }
                          if (snapshot.hasData) {
                            debugPrint("\n\n\n\nini bisa");
                            JobsModel jobsModel =
                            JobsModel.fromJson(snapshot.data);
                            debugPrint("\n\n\n\nini hasData : ${snapshot.data}");
                            return _buildSuccessSection(jobsModel);
                          }
                          return _buildLoadingSection();
                        },
                      ),
                ),


              SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  "All Jobs",
                  style: kTitleStyle,
                ),
              ),
              Container(
                child: FutureBuilder(
                  future: JobDataSource.instance.loadJob(),
                  //debugPrint("\n\n\n\ndata : ${JobDataSource.instance.loadJob()}");
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                      ) {
                    if (snapshot.hasError) {
                      debugPrint("\n\n\n\nhasError: ${snapshot}");
                      return _buildErrorSection();
                    }
                    if (snapshot.hasData) {
                      debugPrint("\n\n\n\nini bisa");
                      JobsModel jobsModel =
                      JobsModel.fromJson(snapshot.data);
                      debugPrint("\n\n\n\nini hasData : ${snapshot.data}");
                      return _recentSuccessSection(jobsModel);
                    }
                    return _buildLoadingSection();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
        child: Text("API Error")
    );
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  Widget _recentSuccessSection(JobsModel data){
    return ListView.builder(
      itemCount: data.jobs?.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        var recent = data.jobs?[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetail(
                  job: recent,
                ),
              ),
            );
          },
          child: RecentJobCard(job: recent),
        );
      },
    );
  }


  Widget _buildSuccessSection(JobsModel data) {
    debugPrint("\n\n\n\nfilter: ${data.jobs}");
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: data.jobs?.length,
        itemBuilder: (BuildContext context, int index) {
          var job = data.jobs?[index];
          //return _buildItemCountries("${data.jobs?[index].job}");
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetail(
                    job: job,
                  ),
                ),
              );
            },
            child: index == 0
                ? CompanyCard(job: job)
                : CompanyCard2(job: job),
          );
        },
      ),
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}

