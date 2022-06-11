class Subject {
  String? subjectId;
  String? subjectName;
  String? subjectDescription;
  String? subjectPrice;
  String? subjectrating;
  String? subjectsessions;

  Subject({
    this.subjectId,
    this.subjectName,
    this.subjectDescription,
    this.subjectPrice,
    this.subjectrating,
    this.subjectsessions,
  });

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    subjectDescription = json['subject_description'];
    subjectPrice = json['subject_price'];
    subjectsessions = json['subject_sessions'];
    subjectrating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['subject_description'] = subjectDescription;
    data['subject_price'] = subjectPrice;
    data['subject_sessions'] = subjectsessions;
    data['subject_rating'] = subjectrating;
    return data;
  }
}
