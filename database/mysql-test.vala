using Mysql;

public static int main(string[] args) {
    int rc = 0;

	ClientFlag cflag = 0;
	string     host = "127.0.0.1";
	int        port = 3306;
	string     user = "root";
	string     password = "root";
	string     database = "loker";
	string     socket = null;

	Database mysql = new Mysql.Database();
	var isConnected = mysql.real_connect(host, user, password, database, port, socket, cflag);

	if (!isConnected ) {
		rc = 1;
		stdout.printf("ERROR %u: Connection failed: %s\n", mysql.errno(), mysql.error());
		return rc;
	}

	stdout.printf("Connected to MySQL server version: %s (%lu)\n",
				  mysql.get_server_info(),
				  (ulong) mysql.get_server_version());
	//string sql = ""
    return 0;
}
