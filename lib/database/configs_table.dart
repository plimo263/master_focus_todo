class ConfigsTable {
  final String columnId = 'id';
  final String columnKey = 'key';
  final String columnValue = 'value';
  final String tableName = 'configs';

  static final ConfigsTable instance = ConfigsTable._();

  ConfigsTable._();

  factory ConfigsTable() => instance;

  String get createTableQuery => '''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnKey TEXT NOT NULL UNIQUE,
      $columnValue TEXT NOT NULL
    )
  ''';

  String get dropTableQuery => '''
    DROP TABLE IF EXISTS $tableName
  ''';

  String get selectAllQuery => '''
    SELECT * FROM $tableName
  ''';

  String selectByKeyQuery(String key) => '''
    SELECT * FROM $tableName WHERE $columnKey = '$key'
  ''';

  String upInsertByKeyQuery(String key, String value) => '''
    INSERT OR REPLACE INTO $tableName (
      $columnKey,
      $columnValue
    ) VALUES (
      '$key',
      '$value'
    )
  ''';
}
