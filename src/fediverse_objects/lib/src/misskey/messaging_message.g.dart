// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messaging_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MisskeyMessagingMessage _$MisskeyMessagingMessageFromJson(
    Map<String, dynamic> json) {
  return MisskeyMessagingMessage(
    id: json['id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    userId: json['userId'] as String,
    user: json['user'] == null
        ? null
        : MisskeyUser.fromJson(json['user'] as Map<String, dynamic>),
    text: json['text'] as String,
    fileId: json['fileId'] as String,
    file: json['file'] == null
        ? null
        : MisskeyDriveFile.fromJson(json['file'] as Map<String, dynamic>),
    recipientId: json['recipientId'] as String,
    recipient: json['recipient'] == null
        ? null
        : MisskeyUser.fromJson(json['recipient'] as Map<String, dynamic>),
    groupId: json['groupId'] as String,
    group: json['group'] == null
        ? null
        : MisskeyUserGroup.fromJson(json['group'] as Map<String, dynamic>),
    isRead: json['isRead'] as bool,
    reads: (json['reads'] as List)?.map((e) => e as String),
  );
}

Map<String, dynamic> _$MisskeyMessagingMessageToJson(
        MisskeyMessagingMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'userId': instance.userId,
      'user': instance.user,
      'text': instance.text,
      'fileId': instance.fileId,
      'file': instance.file,
      'recipientId': instance.recipientId,
      'recipient': instance.recipient,
      'groupId': instance.groupId,
      'group': instance.group,
      'isRead': instance.isRead,
      'reads': instance.reads?.toList(),
    };
