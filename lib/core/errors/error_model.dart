
class ErrorModel {
  final bool success ;
  final String errorMessage;
  ErrorModel({
    required this.success,
    required this.errorMessage,
  });
 factory ErrorModel.fromjson(Map <String,dynamic> json){
  return ErrorModel(success: json['success'], errorMessage:json["error"] );
 }
}
