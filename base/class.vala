using GLib;

class class_test {
	public int a;
	public char c;

	public class_test() {
		this.a = 10;
		this.c = 'C';
	}
}

class class2 : class_test {
	public double b;

	// Signal
	public signal void sig_1(int a);

	public class2() {
		base();
		this.b = 10.5;
	}
	public class2.with_init(int a, double b, char c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}

	public int age {get; set; default = 15;}

	~class2() {
		stdout.printf("Destruction!\n");
	}
}

public abstract class Animal : Object {
	public void eat() {
		stdout.printf("*chomp, chomp*\n");
	}
	public abstract void say_hello();
}

public class Tiger : Animal {
	public override void say_hello() {
		stdout.printf("*roar*\n");
	}
}

public class Duck : Animal {
	public override void say_hello() {
		stdout.printf("*quack*\n");
	}
}

// Interface

public interface ITset : Object {
	public abstract int data_1 {get; set;}
	public abstract void method_1();
}

public class Test1 : Object, ITset {
	public int data_1 {get; set;}
	public void method_1() {
		stdout.printf("Method_1\n");
	}
}

public static int main(string[] args) {
    class_test myclass = new class_test();
	stdout.printf("%d -- %c\n", myclass.a, myclass.c);
	class2 myclass2 = new class2();
	stdout.printf("%d -- %c -- %lf\n", myclass2.a, myclass2.c, myclass2.b);
	class2 myclass3 = new class2.with_init(20, 20.5, 'A');
	stdout.printf("%d -- %c -- %lf\n", myclass3.a, myclass3.c, myclass3.b);

	myclass3.sig_1.connect((t, a) => {
			stdout.printf("Sig : %d\n", a);
		});
	myclass3.sig_1(5);
	stdout.printf("Age: %d\n", myclass3.age++);

	stdout.printf("---------------------------------\n");
	var tiger = new Tiger();
	tiger.say_hello();
	var duck = new Duck();
	duck.say_hello();

	stdout.printf("---------------------------------\n");
	var test1 = new Test1();
	test1.method_1();

	
	stdout.printf("---------------------------------\n");
    return 0;
}
