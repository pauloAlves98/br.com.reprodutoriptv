import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//realizar leitura de arquivo txt.
//import 'SQLUtil.dart';

class SqlHelper {
  static const String NOME_BASE_DADOS = "iptv.db";
  static final SqlHelper _instance =  SqlHelper._internal();//Singleton
  static String? databasecaminho;
  factory SqlHelper() => _instance;
  
  SqlHelper._internal();
  Database? _db;
  
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDd();
    }
    return _db;
  }
  Future<Database> initDd() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, NOME_BASE_DADOS);
    print("Caminho Db "+ path.toString());
    databasecaminho = path;
    return await openDatabase(path,
        version: 1, onCreate: create, onUpgrade: update);
  }

  void create(Database db, int newVersion) async {
    print("CREATE ");
    //  await db.execute(TabelaUsuario.createTable);
    //  await db.execute(TabelaFicha.createTable);
    //  await db.execute(TabelaPagamento.createTable);
    //  await db.execute(TabelaDebito.createTable);
    // await db.execute(TabelaEndereco.createTable);
    // await db.execute(TabelaPaciente.createTable);
  }

  void update(Database db, int oldVersion, int newVersion) async {
    print("UPDATE");
    //await db.execute(TabelaPagamento.createTable);
    //  await db.execute(TabelaDebito.createTable);
//    await db.execute(TabelaUsuario.createTable);
  }
}