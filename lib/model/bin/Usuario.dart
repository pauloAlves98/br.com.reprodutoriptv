
abstract class Usuario{
 
  int? _id;// ? indica que pode ser null
  String _nome = ""; //tem que inicializar.
  String _codigo = "";
  String _login = "";
  String _senha = "";
  String _status = "ATIVO";
  String _urlFoto = "";
  
 

  //Usuario(this._id, this._nome, this._codigo, this._login, this._senha);
  
  get getUrlFoto => this._urlFoto;
  set setUrlFoto(String urlFoto) => this._urlFoto = urlFoto;

  get id => this._id;
  set id( value) => this._id = value;
  
  get nome => this._nome;
  set nome( value) => this._nome = value;

  get codigo => this._codigo;
  set codigo( value) => this._codigo = value;

  get login => this._login;
  set login( value) => this._login = value;

  get senha => this._senha;
  set senha( value) => this._senha = value;

  get status => this._status;
  set status( value) => this._status = value;
}  