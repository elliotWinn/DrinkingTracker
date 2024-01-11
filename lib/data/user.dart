class User {
  late String name;
  late DateTime dob;
  late double weight;
  late bool male;

  User({required this.name, required this.dob, required this.weight, required this.male});

  int get age => (DateTime.now().difference(dob).inDays)~/365;
}