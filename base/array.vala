using GLib;

public static int main(string[] args) {
    int[] a = new int[10];
	int[] b = {2, 3, 4, 6};
	int[] c = b[1 : 3];
	int[,] d = new int[10, 20];

	int r = d.length[0];
	int s = d.length[1];

	stdout.printf("%d -- %d\n", r, s);

	stdout.printf("Array A length: %d\n", a.length);
	a.resize(12);
	stdout.printf("Array A new length: %d\n", a.length);

	if (2 in b) {
		stdout.printf("True\n");
	}
    return 0;
}
