class Util {
  static String sprintf(String template, List<dynamic> values) {
    for (var value in values) {
      template = template.replaceFirst(RegExp(r'%s|%d|%f'), value.toString());
    }
    return template;
  }
}
