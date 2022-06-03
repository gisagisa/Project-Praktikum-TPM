

class JobsModel {
  List<Jobs>? jobs;
  JobsModel({this.jobs});

  JobsModel.fromJson(List<dynamic> json) {
    if (json != null) {
      jobs = <Jobs>[];
      json.forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
      print("\n\n\n\njobs : ${jobs}");
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    print("\n\n\n\ndata : ${data}");
    return data;
  }
}


class Jobs {
  String? job;
  String? company;
  String? about;
  String? jobdesc;
  List<String>? jobresp;
  String? salary;
  List<String>? tag;
  String? status;
  String? city;
  String? mainCriteria;
  String? id;

  Jobs(
      {this.job,
        this.company,
        this.about,
        this.jobdesc,
        this.jobresp,
        this.salary,
        this.tag,
        this.status,
        this.city,
        this.mainCriteria,
        this.id});

  Jobs.fromJson(Map<String, dynamic> json) {
    job = json['job'];
    company = json['company'];
    about = json['about'];
    jobdesc = json['jobdesc'];
    jobresp = json['jobresp'].cast<String>();
    salary = json['salary'];
    tag = json['tag'].cast<String>();
    status = json['status'];
    city = json['city'];
    mainCriteria = json['mainCriteria'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job'] = this.job;
    data['company'] = this.company;
    data['about'] = this.about;
    data['jobdesc'] = this.jobdesc;
    data['jobresp'] = this.jobresp;
    data['salary'] = this.salary;
    data['tag'] = this.tag;
    data['status'] = this.status;
    data['city'] = this.city;
    data['mainCriteria'] = this.mainCriteria;
    data['id'] = this.id;
    return data;
  }
}