// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DogListModelAdapter extends TypeAdapter<DogListModel> {
  @override
  final int typeId = 0;

  @override
  DogListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DogListModel(
      breedName: fields[0] as String?,
      breedImage: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DogListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.breedName)
      ..writeByte(1)
      ..write(obj.breedImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DogListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
