using GLib;

[DBus(name = "org.example.DemoService")]
public class DemoService : Object {
	int counter;

	public int status;

	public int something {get; set;}

	public signal void sig1();

	public void some_method() {
		counter++;
		stdout.printf("heureka! counter = %d\n", counter);
		sig1();
	}

	public void some_method_sender(string message, GLib.BusName sender) {
		counter++;
		stdout.printf("heureka! counter = %d, '%s' message from sender %s\n", counter, message, sender);
	}
}

void on_bus_aquired (DBusConnection conn) {
	try {
		var service = new DemoService();
		conn.register_object("/org/example/demo", service);
	} catch (IOError e) {
		stderr.printf("Could not register service: %s\n", e.message);
	}
}

public static int main(string[] args) {
    Bus.own_name(BusType.SESSION, "org.example.DemoService",
				 BusNameOwnerFlags.NONE,
				 on_bus_aquired,
				 () => {},
				 () => stderr.printf("Could not aquired name\n"));
	new MainLoop().run();
    return 0;
}
