using GLib;

public static int main(string[] args) {
    string str1 = "Yang Xibin ";
	string str2 = "is a good boy\n";
	stdout.puts(str1 + str2);

	string str3 = @"$str1$str2";
	stdout.puts(str3);

	string str4 = str3;
	stdout.printf("str3:%p -- str4:%p\n", str3, str4);

	if (str3 == str4){
		stdout.printf("True!\n");
	} else {
		stdout.printf("False\n");
	}

	string str5 = """Yang xibin is a good boy?
Yes!
""";
	stdout.puts(str5);

	if ("Hello" > "world") {
		stdout.printf("%s\n", "Hello");
	} else {
		stdout.printf("%s\n", "World");
	}

	string switch_test = "vala";
	switch (switch_test) {
	case "vala":
		stdout.printf("Get it!\n");
		break;
	case "java":
		assert_not_reached();
	}
	
	string formatted = "PI\'s value is %g, not %g.".printf(Math.PI, 3.14);
	stdout.printf("%s\n", formatted);


	var builder = new StringBuilder ();
    builder.append ("built ");
    builder.prepend ("String ");
    builder.append ("StringBuilder");
    builder.append_unichar ('.');
    builder.insert (13, "by ");
	stdout.printf("%s\n", builder.str);
	
    return 0;
}
