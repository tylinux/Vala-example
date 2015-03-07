public static int main(string[] args) {
    List<int> test = new List<int>();
	for (int i = 0; i < 10; i++) {
		test.append(i);
	}
	stdout.printf("%u\n", test.length());
    return 0;
}
