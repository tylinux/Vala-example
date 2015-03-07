using GLib;

public class Wrapper<G> : Object {
	private G data;
	public new void set_data(G data) {
		this.data = data;
	}
	public new G get_data() {
		return this.data;
	}
}

public class GOConstruct : Object {
	public int a {get; construct;}
	public double b {get; construct set;}
	public GOConstruct(int a) {
		Object(a : a, b : 10.5);
	}
	public GOConstruct.with_b(int a, double b) {
		Object(a : a, b : b);
	}
	construct {
		stdout.printf("Construction done!\n");
	}
}

public static int main(string[] args) {
    var wrapper = new Wrapper<string>();

	wrapper.set_data("test");
	stdout.printf("%s\n", wrapper.get_data());

	GOConstruct test = new GOConstruct(10);
	stdout.printf("%d -- %lf\n", test.a, test.b);
	GOConstruct test1 = new GOConstruct.with_b(10, 20.4);
	stdout.printf("%d -- %lf\n", test1.a, test1.b);
    return 0;
}
