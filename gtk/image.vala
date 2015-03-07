using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk Header Bar";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	var vbox = new Box(Orientation.VERTICAL, 0);
	window.add(vbox);
	
	var image = new Image();
	vbox.pack_start(image, true, false, 0);
	var button_load = new Button.with_label("Load...");
	button_load.clicked.connect(() => {
			var chooser = new FileChooserDialog(
				"choose image", window, FileChooserAction.OPEN,
				"_Cancel",
				Gtk.ResponseType.CANCEL,
				"_Open",
				Gtk.ResponseType.ACCEPT
				);
			var filter = new FileFilter();
			chooser.set_filter(filter);
			filter.add_mime_type("image/jpeg");
			if (chooser.run() == Gtk.ResponseType.ACCEPT) {
				string path = chooser.get_uri().substring(7);
				image.set_from_file(path);
			}
			chooser.close();
		});
	vbox.pack_start(button_load, false, false, 0);
	
	
	window.show_all();
	Gtk.main();
    return 0;
}
