using Gtk;
public class FileManger : Window {
	private Entry entry_path;
	private Button btn_back;
	private Treeview dir_list;
	private string path;
	
	public FileManger() {
		this.title = "FileManger";
		this.border_width = 10;
		this.window_position = WindowPosition.CENTER;
		this.set_default_size (800, 600);
		this.destroy.connect (this.on_window_destroy);

		var scrolled_window = new ScrolledWindow(null, null);
		this.add (scrolled_window);
		
		var hbox = new Box(Orientation.HORIZONTAL, 0);
		var lbl_path = new Label("Path");
		hbox.pack_start(lbl_path, false, false, 10);
		entry_path = new Entry();
		hbox.pack_start(entry_path, true, true, 10);
		btn_back = new Button.with_label("<<");
		hbox.pack_start (btn_back, false, false, 10);

		var vbox = new Box(Orientation.VERTICAL, 0);
		vbox.pack_start(hbox, false, false, 0);
		dir_list = new TreeView();
		this.set_dir_list(dir_list);

		vbox.pack_start(dir_list, true, true, 0);

		scrolled_window.add(vbox);

		this.path = "./";
	}

	public void set_dir_list(TreeView dir_list) {
		var dir = Dir.open(this.path);
	}
	public void on_window_destroy() {
		Gtk.main_quit();
	}
}

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new FileManger();
	window.show_all();
	Gtk.main();
    return 0;
}
