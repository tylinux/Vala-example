using Gtk;

public class FileManager : Gtk.Window {
	
	public FileManager() {
		this.title = "Gtk File Manager";
		this.border_width = 10;
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(800, 600);
		this.destroy.connect(Gtk.main_quit);

		// Address field
		var hbox = new Box(Orientation.HORIZONTAL, 0);

		var btn_home = new Gtk.Button.from_icon_name("go-home", Gtk.IconSize.BUTTON);
		btn_home.clicked.connect(() => {

			});
		hbox.pack_start(btn_home, false, false, 0);

		var ety_address = new Gtk.Entry();
		ety_address.set_text(this.get_home_directory());
		hbox.pack_start(ety_address, true, true, 0);
		
		var btn_go = new Gtk.Button.with_label(" >> ");
		btn_go.clicked.connect(() => {
				
			});
		hbox.pack_start(btn_go, false, false, 0);
		
		// Show Area
		// TODO

		var vbox = new Box(Orientation.VERTICAL, 0);
		vbox.pack_start(hbox, false, false, 0);

		this.add(vbox);
	}

	public void load_icon() {
		
	}

	public string get_home_directory() {
		return Environment.get_variable("HOME");
	}
}


public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new FileManager();
	window.show_all();
	Gtk.main();
    return 0;
}
