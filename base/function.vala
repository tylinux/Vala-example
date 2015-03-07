using GLib;

void f(int a, int b = 10, char c = 'A') {
	stdout.printf("a:%d b:%d c:%c\n", a, b, c);
}

// 委托
delegate void DelegateType(int a); 

void f1(int a) {
	stdout.printf("%d\n", a);
}

void f2(DelegateType d, int a) {
	d(a);
}

delegate void PrintIntFunc(int a);

public static int main(string[] args) {
    f(5);
	f(5, 11);
	f(5, 12, 'B');
	f2(f1, 5);
	PrintIntFunc p1 = (a) => {
		stdout.printf("%d\n", a);
	};
	p1(10);
	return 0;
}
