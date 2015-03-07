public class PopMenu : Gtk.Window {
	public PopMenu () {
		this.title = "My Gtk.Window";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.set_default_size (350, 70);
		this.hide_titlebar_when_maximized = false;

		this.destroy.connect (() => {
			stdout.printf ("Bye!\n");
			Gtk.main_quit ();
		});

		var popwin = new Gtk.Window();
		popwin.add (new Gtk.Label ("This is a pop menu"));
		popwin.set_visible(false);
		var button = new Gtk.Button.with_label("hello");
		this.add(button);
		button.clicked.connect(() => {
				popwin.set_visible(true);
			});
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		PopMenu app = new PopMenu ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
