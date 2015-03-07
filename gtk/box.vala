using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk Box";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	var vbox = new Box(Orientation.VERTICAL, 0);
	var button_add = new Button.with_label("添加");
	vbox.pack_start(button_add, true, true, 0);

	var button_clean = new Button.with_label("清空");
	vbox.pack_start(button_clean, true, true, 0);

	var hbox = new Box(Orientation.HORIZONTAL, 0);
	vbox.pack_start(hbox, true, true, 0);

	var button_about = new Button.with_label("关于");
	hbox.pack_start(button_about, true, true, 0);
	var button_quit = new Button.with_label("退出");
	hbox.pack_start(button_quit, true, true, 0);
	
	window.add(vbox);
	window.show_all();
	Gtk.main();
    return 0;
}
