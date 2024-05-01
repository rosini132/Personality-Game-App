import 'package:hive/hive.dart';
part 'node.g.dart';

@HiveType(typeId: 0)
class Node {
  @HiveField(0)
  int iD;

  @HiveField(1)
  int option1;

  @HiveField(2)
  int option2;

  @HiveField(3)
  int option3;

  @HiveField(4)
  String description;

  @HiveField(5)
  String button1;

  @HiveField(6)
  String button2;

  @HiveField(7)
  String button3;

  @HiveField(8)
  String audioUrl;

  @HiveField(9)
  int colour;

  Node(this.iD, this.option1, this.option2, this.option3, this.description,
      this.button1, this.button2, this.button3, this.audioUrl, this.colour);
}
