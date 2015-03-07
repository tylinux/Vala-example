using GLib;

void method_1(int x, ...) {
	var l = va_list();
	while (true) {
		string? key = l.arg();
		if (key == null) {
			break;
		}
		double val = l.arg();
		stdout.printf("%s: %g\n", key, val);
	}
}

public static int main(string[] args) {
    method_1(42, "foo", 0.75, "bar", 0.25, "baz", 0.32);
    return 0;
}
