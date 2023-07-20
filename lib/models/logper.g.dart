// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogperAdapter extends TypeAdapter<Logper> {
  @override
  final int typeId = 1;

  @override
  Logper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Logper(
      uid: fields[0] as String?,
      email: fields[1] as String?,
      photoURL: fields[2] as String?,
      fcmToken: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Logper obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.photoURL)
      ..writeByte(3)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
