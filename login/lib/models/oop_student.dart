class Student{
  int id = 0;
  String firstName = "";
  String lastName = "";
  int grade = 0;
  String _status ="";
  String avatarURL = "";

  Student.withId(int id, String firstName, String lastName, int grade, String avatarURL){
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
    this.avatarURL = avatarURL;
  }

  Student( String firstName, String lastName, int grade, String avatarURL){
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
    this.avatarURL = avatarURL;
  }
  Student.withoutInfo(){

  }
  String get getFirstName{
    return "OGR - " + this.firstName;
  }

  void set setFirstName(String value){
    this.firstName = value;
  }

  String get getStatus{
    String message = "";
    if (this.grade >= 50) {
      message = "Gecti";
    }
    else if (this.grade >= 40) {
      message = "Butunlemeye Kaldi";
    }
    else {
      message = "Kaldi";
    }
    return message;
  }
}