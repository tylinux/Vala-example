using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk MenuBar";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	Box vbox = new Box(Orientation.VERTICAL, 0);
	window.add(vbox);

	MenuBar bar = new MenuBar();
	vbox.pack_start(bar, false, false, 0);
	
	Gtk.MenuItem item_file = new Gtk.MenuItem.with_label("File");
	bar.add(item_file);
	Gtk.Menu filemenu = new Gtk.Menu();

	Gtk.MenuItem item_open = new Gtk.MenuItem.with_label("Open");
	item_open.activate.connect(() => {
			Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog(
				"Select File", window, Gtk.FileChooserAction.OPEN,
				"_Cancel",
				Gtk.ResponseType.CANCEL,
				"_Open",
				Gtk.ResponseType.ACCEPT
				);
			chooser.run();
			chooser.close();
		});
	filemenu.add(item_open);

	Gtk.MenuItem item_exit = new Gtk.MenuItem.with_label("Exit");
	item_exit.activate.connect(Gtk.main_quit);
	filemenu.add(item_exit);
	
	item_file.set_submenu(filemenu);

	window.show_all();
	Gtk.main();
    return 0;
}
