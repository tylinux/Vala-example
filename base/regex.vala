using GLib;

public static int main(string[] args) {
    string email = "liuliu036@gmail.com";
	if (/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.match(email)) {
		stdout.printf("Valid email address\n");
	}
    return 0;
}
