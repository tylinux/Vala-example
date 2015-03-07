using GLib;

enum WindowType {
	TOPLEVEL = 1,
	POPUP = 3,
}

public static int main(string[] args) {
	var enum_test = WindowType.POPUP;
	stdout.printf("%d\n", enum_test);
    return 0;
}
