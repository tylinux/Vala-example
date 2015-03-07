using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk Gird";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	var frame = new Frame("<b> Gtk Gird</b>");
	(frame.label_widget as Gtk.Label).use_markup = true;

	Gtk.AttachOptions flags = Gtk.AttachOptions.EXPAND | Gtk.AttachOptions.FILL;
	Gtk.Table table = new Gtk.Table (3, 3, true);
	table.attach(new Button.with_label ("1"), 0, 1, 0, 1, flags, flags, 0, 0);
	table.attach(new Button.with_label ("2"), 1, 3, 0, 1, flags, flags, 0, 0);
	table.attach(new Button.with_label ("3"), 0, 1, 1, 3, flags, flags, 0, 0);
	table.attach(new Button.with_label ("4"), 1, 3, 1, 3, flags, flags, 0, 0);
	frame.add(table);

	window.add(frame);
	window.show_all();
	Gtk.main();
    return 0;
}
