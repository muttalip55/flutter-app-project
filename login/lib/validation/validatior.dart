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
