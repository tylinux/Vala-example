using Gtk;


public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "GTK Basic!";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 70);
	window.destroy.connect(Gtk.main_quit);

	try {
		window.icon = new Gdk.Pixbuf.from_file("icon.png");
	} catch (Error e) {
		stderr.printf("%s\n",e.message);
	}

	var button = new Button.with_label("点我点我!");
	button.clicked.connect(() => {
			button.label = "啦啦啦!";
		});
	window.add(button);
	window.show_all();

	Gtk.main();
    return 0;
}
