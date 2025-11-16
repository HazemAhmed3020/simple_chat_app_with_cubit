
class Messages {
 final String message;
  final String id;

  Messages({required this.message, required this.id});

  factory Messages.fromJson(json){
    return Messages(message: json['message'], id: json['id']);

  }

}