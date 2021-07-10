class Comum {
  
  static String getPorId(int id, String tabela) {
    return "SELECT * FROM $tabela where id='$id'";
  }

  static String getAll(String tabela) {
    return "SELECT * FROM $tabela";
  }

  static String removeId(int id, String tabela) {
    return "DELETE FROM $tabela where id='$id'";
  }

  static String removeAll(String tabela) {
    return "DELETE FROM $tabela";
  }
}

//fazer das outras classes.