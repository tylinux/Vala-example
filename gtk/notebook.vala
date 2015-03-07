using Gtk;

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Window();
	window.title = "Gtk Notebook";
	window.border_width = 10;
	window.window_position = WindowPosition.CENTER;
	window.set_default_size(350, 350);
	window.destroy.connect(Gtk.main_quit);

	var notebook = new Notebook();
	window.add(notebook);

	var title = new Label("Title 1");
	var content =new Label("Content 1");
	notebook.append_page(title, content);

	title = new Label("Title 2");
	content = new Label("Content 2");
	notebook.append_page(title, content);

	window.show_all();
	Gtk.main();
    return 0;
}
