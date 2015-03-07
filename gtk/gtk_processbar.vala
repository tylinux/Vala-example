public class Application : Gtk.Window {
	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.ProgressBar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);

		// The ProgressBar:
		Gtk.ProgressBar bar = new Gtk.ProgressBar ();
		this.add (bar);

		// Display text:
		bar.set_show_text (true);
		string info = "1.769512891769414e-02;617.976620674133";
		string[] inf = new string[2];
		inf = info.split(";",2);
		double used = double.parse(inf[0]);
		double total = double.parse(inf[1]);

		string text = "%.2fG / %.2fG".printf(used,total);
		stdout.printf("%lf\n",used);
		bar.set_text(text);
		bar.set_fraction(used / total);
	}
	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}