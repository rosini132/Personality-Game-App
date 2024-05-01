// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NodeAdapter extends TypeAdapter<Node> {
  @override
  final int typeId = 0;

  @override
  Node read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Node(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Node obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.option1)
      ..writeByte(2)
      ..write(obj.option2)
      ..writeByte(3)
      ..write(obj.option3)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.button1)
      ..writeByte(6)
      ..write(obj.button2)
      ..writeByte(7)
      ..write(obj.button3)
      ..writeByte(8)
      ..write(obj.audioUrl)
      ..writeByte(9)
      ..write(obj.colour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
