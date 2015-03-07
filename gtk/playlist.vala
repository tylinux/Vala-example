using Gtk;

public class PlayList : Window {
	private TreeView list;
	public PlayList () {
		this.title = "PlayList";
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(600, 400);
		this.border_width = 5;
		this.destroy.connect (Gtk.main_quit);

		var vbox = new Box(Orientation.VERTICAL, 0);
		list = new TreeView();
		var hbox = new Box(Orientation.HORIZONTAL, 0);
		var button = new Button.with_label("Loading...");
		var button1 = new Button.with_label("Clear");
		hbox.pack_start(button, true, false, 10);
		hbox.pack_start(button1, true, false, 10);
		button.clicked.connect(this.on_laod_clicked);
		button1.clicked.connect(() => {
				this.list.model.clear();
			});
		vbox.pack_start(list, true, true, 0);
		vbox.pack_start(button, false, false, 0);
		this.add(vbox);
	}

	void on_laod_clicked(Button button) {
		var file_dialog = new FileChooserDialog (
			"Select Your Files",
			this,
			FileChooserAction.OPEN,
			"_Cancel",
			ResponseType.CANCEL,
			"_Open",
			ResponseType.ACCEPT);
		file_dialog.select_multiple = true;
		var filter = new FileFilter();
		filter.add_mime_type("audio/mp3");
		file_dialog.set_filter (filter);
		SList<string> uris;

		var listmodel = new ListStore(2, typeof(string), typeof(string));
		list.set_model(listmodel);
		list.insert_column_with_attributes (-1, "Path", new CellRendererText(), "text", 0);
		list.insert_column_with_attributes (-1, "Name", new CellRendererText(), "text", 1);

		if (file_dialog.run() == ResponseType.ACCEPT) {
			uris = file_dialog.get_uris();
			listmodel.clear();
			TreeIter iter;
			foreach (unowned string uri in uris) {
				listmodel.append(out iter);
				string[] strs = Uri.unescape_string(uri).split("/");
				listmodel.set (iter, 0, Uri.unescape_string(uri), 1, strs[strs.length-1]);
			}

		}
		file_dialog.close();
	}
}

public static int main(string[] args) {
    Gtk.init(ref args);
	var window = new PlayList();
	window.show_all();
	Gtk.main();
    return 0;
}
