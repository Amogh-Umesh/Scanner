List<dynamic> getUrls(String input) {
  RegExp regExp = RegExp(
    r"""\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))""",
    caseSensitive: false,
    multiLine: false,
  );
  List<dynamic> urlS = [];
  List<RegExpMatch> a = regExp.allMatches(input).toList();
  for (int i = 0; i < a.length; i++) {
    String str = a[i].group(0).toString();
    if (str.length > 6) {
      if (str.substring(0, 6) == 'https:' || str.substring(0, 5) == 'http:') {

      }else{
        str = 'https:' + str;
      }
    } else {
      str = 'https:' + str;
    }
    str.toLowerCase();

    UrlLink temp = UrlLink(str);
    urlS.add(temp);
  }
  return urlS;
}

List<dynamic> getPhone(String input) {
  RegExp regExp = RegExp(
    r"(?:\s+|)((0|(?:(\+|)91))(?:\s|-)*(?:(?:\d(?:\s|-)*\d{9})|(?:\d{2}(?:\s|-)*\d{8})|(?:\d{3}(?:\s|-)*\d{7}))|\d{10})(?:\s+|)",
    caseSensitive: false,
    multiLine: false,
  );
  List<dynamic> phoneNumbers = [];
  List<RegExpMatch> a = regExp.allMatches(input).toList();
  for (int i = 0; i < a.length; i++) {
    String str = a[i].group(1).toString();

    if (str.substring(0, 3) == '+91' || str.substring(0, 5) == '(+91)') {


    }else{
      str = '+91 '+ str;
    }

    PhoneNumber temp = PhoneNumber(str);
    phoneNumbers.add(temp);
  }
  return phoneNumbers;
}

class UrlLink {
  late String url;
  UrlLink(this.url);
}

class PhoneNumber {
  late String phoneNumber;
  PhoneNumber(this.phoneNumber);
}

List<dynamic> getScannedData(String input) {
  List<dynamic> links = getUrls(input);
  List<dynamic> numbers = getPhone(input);
  links.addAll(numbers);
  return links;
}
