

bool textLangArabic(String value) {
  var english = RegExp(r'[a-zA-Z]');
  var arabic = RegExp(r'[\u0750-\u077F]');

  if (arabic.hasMatch(value)) {
    return true;
  } else {
    return false;
  }
}


bool validateEmail(String value) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  if (emailRegex.hasMatch(value)) {
    return true;
  } else {
    return false;
  }
}

bool validateNumbersOnly(String value) {
  final numbersRegex = RegExp(r'^[0-9]+$');
  return numbersRegex.hasMatch(value);
}


bool isInteger(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  if (value == "0")
  {
    return true;
  }
  if (value.startsWith("0") || value.startsWith("-0")) {
    return false;
  }
  return int.tryParse(value) != null;
}


bool isValidValue(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  }

  // إذا كانت القيمة هي "0" أو "-0" فهي غير صالحة
  if (value == "0" || value == "-0") {
    return false;
  }

  // إذا كانت القيمة تبدأ بصفر مثل "05" أو "-05" إلخ، فهي غير صالحة
  if (value.startsWith("0") || value.startsWith("-0")) {
    return false;
  }

  return int.tryParse(value) != null;
}


String convertDayToArabic(String englishDay) {
  switch (englishDay.toLowerCase()) {
    case 'monday':
      return 'الاثنين';
    case 'tuesday':
      return 'الثلاثاء';
    case 'wednesday':
      return 'الأربعاء';
    case 'thursday':
      return 'الخميس';
    case 'friday':
      return 'الجمعة';
    case 'saturday':
      return 'السبت';
    case 'sunday':
      return 'الأحد';
    default:
      return englishDay;
  }
}
