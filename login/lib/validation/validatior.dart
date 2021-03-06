class LoginValidationMixin {
  String? validateFirstName(String? value) {
    if (value == null) return "İsim boş olamaz!";

    if (value.length < 2) {
      return "İsim en az iki karakter olmalıdır";
    }
    return null;
  }

  String? validateEmailName(String? value) {
    if (value == null) return "Email boş olamaz!";

    if (value.length < 2) {
      return "Email en az iki karakter olmalıdır";
    }
    return null;
  }

  String? validatePassword(String? value){
    if (value == null) return "Şifre boş olamaz!";

    if (value.length < 8) {
      return "Şifre en az sekiz karakter olmalıdır";
    }
    return null;
  }

  String? validateRepeatPassword(String? value,String? password){
    if (value == null) return "Şifre boş olamaz!";

    else if (value.length < 8) {
      return "Şifre en az sekiz karakter olmalıdır";
    }
    else if (value != password){
      return 'Girdiğiniz şifreler uyuşmuyor lütfen kontrol edin';
    }
    return null;
  }
}

class StudentValidationMixin {
  String? validateFirstName(String? value) {
    if (value == null) return "İsim boş olamaz!";

    if (value.length < 2) {
      return "İsim en az iki karakter olmalıdır";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null) return "Soyisim boş olamaz!";

    if (value.length < 2) {
      return "Soyisim en az iki karakter olmalıdır";
    }
    return null;
  }

  String? validateGrade(String? value){
    if (value == null) return "Not boş olamaz!";
    if(int.parse(value)<0 || int.parse(value)>100){
      return "0 ile 100 arası not girişi yapınız";
    }
  }
}

