using Gtk;

public class Application : Window {
	private Window subwindow;
	private bool ishide = false;
	
	public Application() {
		this.title = "Multi-Window";
		this.border_width = 10;
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(350, 350);
		this.destroy.connect(Gtk.main_quit);

		var hbox = new Box(Orientation.HORIZONTAL, 0);
		this.add(hbox);
		var btn_show = new Button.with_label("Show");
		btn_show.clicked.connect(() => {
				if (this.ishide == false) {
					this.subwindow.deiconify();
				} else {
					this.subwindow.show_all();
					this.ishide = false;
				}
			});
		hbox.pack_start(btn_show, true, true, 0);
		var btn_hide = new Button.with_label("Hide");
		btn_hide.clicked.connect(() => {
				this.subwindow.iconify();
			});
		hbox.pack_start(btn_hide, true, true, 0);
	}

	Window create_sub_window() {
		Window sub_window = new Window();
		subwindow.title = "Sub Window";
		subwindow.border_width = 10;
		subwindow.window_position = WindowPosition.CENTER;
		subwindow.set_default_size(100, 100);
		subwindow.show_all();
		subwindow.delete_event.connect(() => {
				subwindow.hide();
				this.ishide = true;
			});
		return subwindow;
	}
}


public static int main(string[] args) {
    Gtk.init(ref args);

	var window = new Application();
	window.show_all();
	var subwindow = create_sub_window();
	subwindow.show_all();

	Gtk.main();
    return 0;
}
