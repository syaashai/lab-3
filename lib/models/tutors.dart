class tutor {
  String? tutorId;
  String? tutoremail;
  String? tutorphone;
  String? tutorname;
  String? tutordescription;
  String? tutordatereg;

  tutor({
    this.tutorId,
    this.tutoremail,
    this.tutorphone,
    this.tutorname,
    this.tutordescription,
    this.tutordatereg,
  });

  tutor.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutor_id'];
    tutoremail = json['tutor_email'];
    tutorphone = json['tutor_phone'];
    tutorname = json['tutor_name'];
    tutordescription = json['tutor_description'];
    tutordatereg = json['tutor_datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorId;
    data['tutor_email'] = tutoremail;
    data['tutor_phone'] = tutorphone;
    data['tutor_name'] = tutorname;

    data['tutor_description'] = tutordescription;
    data['tutor_datereg'] = tutordatereg;

    return data;
  }
}
