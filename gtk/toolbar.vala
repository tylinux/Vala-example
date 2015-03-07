using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk ToolBar";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	Box vbox = new Box(Orientation.VERTICAL, 0);
	window.add(vbox);

	var bar = new Toolbar();
	vbox.pack_start(bar, false, false, 0);


// Toolbar content:
	Gtk.Image img = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.SMALL_TOOLBAR);
	Gtk.ToolButton button1 = new Gtk.ToolButton (img, null);
	button1.clicked.connect (() => {
			stdout.printf ("Button 1\n");
		});
	bar.add (button1);

	img = new Gtk.Image.from_icon_name ("window-close", Gtk.IconSize.SMALL_TOOLBAR);
	Gtk.ToolButton button2 = new Gtk.ToolButton (img, null);
	button2.clicked.connect (() => {
			stdout.printf ("Button 2\n");
		});
	bar.add (button2);
	
	window.show_all();
	Gtk.main();
    return 0;
}
