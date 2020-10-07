class Client {
  final int id;
  final String fullName;
  final String userName;

  Client({this.id, this.fullName, this.userName});

  factory Client.fromMap(Map<String, dynamic> data){
    /*
    {id: 1, full_name: Bicho, username: bicho19, password: wqxscv19}
     */
    return Client(
      id: data['id'],
      fullName: data["full_name"],
      userName: data['username'],
    );
  }
}