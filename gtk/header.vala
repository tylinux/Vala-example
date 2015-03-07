using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk Header Bar";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	var header = new HeaderBar();
	window.set_titlebar(header);

	var switcher = new Switch();
	header.pack_end(switcher);
	header.set_title("Gtk HeaderBar");
	
	window.show_all();
	Gtk.main();
    return 0;
}
