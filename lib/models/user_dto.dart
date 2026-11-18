// lib/models/user_dto.dart
// DTO = Data Transfer Object = bean, pojo

class UserDto {

  final String username;
  final String password;

  // construtor de UseDTO
  UserDto({required this.username, required this.password});
  // final guilherme = UserDTO(usurname: 'guilherme', password: 'adc')

  Map<String, dynamic> tojson() => 
  {'username': username, "password": password};
  
  // factory = Design Paterns = padrões de projeto 
  factory UserDto.fromjson(Map<String, dynamic> value) => 
    UserDto(username: value['username'], password: value['password']);
}