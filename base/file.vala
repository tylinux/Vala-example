using GLib;

public static int main (string[] args) {
	// Opens "foo.txt" for reading ("r")
	FileStream stream = FileStream.open ("filestream.vala", "r");
	assert (stream != null);

	// buffered:
	char buf[100];
	while (stream.gets (buf) != null) {
		stdout.puts ((string) buf);
	}
	stdout.printf("\n");
	string content;
	try {
		FileUtils.get_contents("file.vala", out content);
		stdout.printf("%s\n", content);
	} catch (FileError e) {
		stdout.printf("%s\n", e.message);
	}

	return 0;
}