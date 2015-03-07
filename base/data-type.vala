using GLib;

public static int main(string[] args) {
	stdout.printf("char:%lu\n", sizeof(char));
	stdout.printf("int:%lu\n", sizeof(int));
	stdout.printf("short:%lu\n", sizeof(short));
	stdout.printf("long:%lu\n", sizeof(long));
	stdout.printf("size_t:%lu\n", sizeof(size_t));
	stdout.printf("ssize_t:%lu\n", sizeof(ssize_t));
	stdout.printf("int8:%lu\n", sizeof(int8));
	stdout.printf("int16:%lu\n", sizeof(int16));
	stdout.printf("int32:%lu\n", sizeof(int32));
	stdout.printf("int64:%lu\n", sizeof(int64));
	stdout.printf("bool:%lu\n", sizeof(bool));
	stdout.printf("float:%lu\n", sizeof(float));
	stdout.printf("double:%lu\n", sizeof(double));
	stdout.printf("unichar:%lu\n", sizeof(unichar));
	return 0;
}