import 'package:mockito/mockito.dart';
import 'package:true_tech_pro_bhargav/db/repository.dart';
import 'package:true_tech_pro_bhargav/models/comment.dart';

class TestRepository extends Mock implements Repository{

  Map<String, dynamic> _map = Map();

  void setMockData(String key, dynamic value){
    _map[key]=value;
  }

  @override
  Future<List<Comment>?> getUserComments() {
    return Future.value(_map['getUserComments']);
  }

}