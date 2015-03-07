using Gtk;


public class Application : Window {
	private Gtk.Menu popmenu;

	public Application (){
		this.title = "Gtk PopMenu";
		this.border_width = 10;
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(350, 350);
		this.destroy.connect(Gtk.main_quit);

		Box vbox = new Box(Orientation.VERTICAL, 0);
		this.add(vbox);

		MenuBar bar = new MenuBar();
		vbox.pack_start(bar, false, false, 0);
	
		Gtk.MenuItem item_file = new Gtk.MenuItem.with_label("File");
		bar.add(item_file);
		
		popmenu = new Gtk.Menu();
		var menuitem = new Gtk.MenuItem.with_label("新建");
		popmenu.append(menuitem);

		menuitem = new Gtk.MenuItem.with_label("打开");
		popmenu.append(menuitem);

		menuitem = new Gtk.MenuItem.with_label("保存");
		popmenu.append(menuitem);

		menuitem = new Gtk.MenuItem.with_label("退出");
		popmenu.append(menuitem);

		item_file.set_submenu(popmenu);

		this.button_press_event.connect(on_button_pressed);
	}
	private bool on_button_pressed(Widget source, Gdk.EventButton button) {
		
		if (button.button == 3) {
			this.popmenu.popup(null, null, null, button.button, button.time);
		}
		return true;
	}
}

public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Application();
	window.show_all();

	Gtk.main();
    return 0;
}
