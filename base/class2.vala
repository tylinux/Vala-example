using GLib;

class SuperClass : Object {
	public virtual void method_1() {
		stdout.printf("SuperClass.method_1()\n");
	}
}

class SubClass : SuperClass {
	public override void method_1() {
		base.method_1();
		stdout.printf("SubClass.method_1()\n");
	}
}

class Super1 : Object {
	public void method_1() {
		stdout.printf("Super1.method_1()\n");
	}
}

class Sub1 : Super1 {
	public new void method_1() {
		stdout.printf("Sub1.method_1()\n");
	}
}

public static int main(string[] args) {
    SubClass o1 = new SubClass();
	o1.method_1();
	SuperClass o2 = o1;
	o2.method_1();

	stdout.printf("----------------\n");
	Sub1 o3 = new Sub1();
	o3.method_1();
	Super1 o4 = o3;
	o4.method_1();
	(o4 as Sub1).method_1();

	stdout.printf("%s\n", (o4 is Sub1).to_string());
    return 0;
}
