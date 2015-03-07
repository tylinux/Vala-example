using GLib;

public static int main(string[] args) {
    int j = 0;
	while (j < 20) {
		stdout.printf("%d\n", j);
		j++;
	}
	for (int i = 20; i < 40; i++) {
		stdout.printf("%d\n", i);
	}
	int[] a = {41, 42, 43, 44, 45, 46, 47, 48, 49, 50};
	foreach (int b in a) {
		stdout.printf("%d\n", b);
	}
    return 0;
}
