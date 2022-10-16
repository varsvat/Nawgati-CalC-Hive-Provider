// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HisModelAdapter extends TypeAdapter<HisModel> {
  @override
  final int typeId = 0;

  @override
  HisModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HisModel()
      ..res = fields[0] as String
      ..calculations = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, HisModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.res)
      ..writeByte(1)
      ..write(obj.calculations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HisModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
