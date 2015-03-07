using Mysql;

int main (string[] args)
{

	int rc = 0;

	ClientFlag cflag    = 0;
	string     host     = "127.0.0.1";
	string     user     = "root";
	string     password = "root";
	string     database = "loker";
	int        port     = 3306;
	string     socket   = null;

	Database mysql = new Mysql.Database ();

	var isConnected = mysql.real_connect(host, user, password, database, port, socket, cflag);

	if ( ! isConnected ) {

		rc = 1;
		stdout.printf("ERROR %u: Connection failed: %s\n", mysql.errno(), mysql.error());
		return rc;
	}

	stdout.printf("Connected to MySQL server version: %s (%lu)\n"
				  , mysql.get_server_info()
				  , (ulong) mysql.get_server_version());

	string sql = "SELECT * FROM users LIMIT 10";
	rc = mysql.query(sql);
	if ( rc != 0 ) {

		stdout.printf("ERROR %u: Query failed: %s\n", mysql.errno(), mysql.error());
		return rc;
	}

	Result ResultSet = mysql.use_result();

	string[] MyRow;

	while ( (MyRow = ResultSet.fetch_row()) != null ) {

		stdout.printf("id: %s | data: %s | ts: %s\n", MyRow[0], MyRow[1], MyRow[2]);
	}
	// free_result is called automatically

	// mysql_close is called automatically
	return rc;
}