/* Using Poppler for PDF rendering in Vala sample code */

using Cairo;
using Gtk;

public class PopplerSample : Window {

    // To store the document and the current page
    private Poppler.Document document;
    private Context context;
    private Image image;
    private int width = 800;
    private int height = 600;
    private int index = 0;

    // To create an application object with the name of the file to display
    public PopplerSample (string file_name) {
        try {
            this.document = new Poppler.Document.from_file (Filename.to_uri (file_name), "");
        } catch (Error e) {
            error ("%s", e.message);
        }

        // Create an image and render first page to image
        var surface = new ImageSurface (Format.ARGB32, this.width, this.height);
        this.context = new Context (surface);
        var pixbuf = new Gdk.Pixbuf (Gdk.Colorspace.RGB, false, 8, this.width, this.height);
        this.image = new Image.from_pixbuf (pixbuf);
        render_page ();

        add (this.image);

        this.key_press_event.connect (on_key_pressed);
        this.destroy.connect (Gtk.main_quit);
    }

    private bool on_key_pressed (Widget source, Gdk.EventKey key) {
        // If the key pressed was q, quit, else show the next page
        if (key.str == "q") {
            Gtk.main_quit ();
        }

        // Render the next page, or the first if we were at the last
        this.index++;
        this.index %= this.document.get_n_pages ();
        render_page ();

        return false;
    }

    private void render_page () {
        // Clear the Cairo surface to white
        this.context.set_source_rgb (255, 255, 255);
        this.context.paint ();
        // Output the PDF page to the Cairo surface,
        // then get a pixbuf, then an image, from this surface
        var pixbuf = this.image.get_pixbuf ();
        var page = this.document.get_page (this.index);
        page.render (this.context);
        pixbuf = Gdk.pixbuf_get_from_surface (this.context.get_target (),
                                              0, 0, this.width, this.height);
        this.image.set_from_pixbuf (pixbuf);
    }

    public static int main (string[] args) {
        if (args.length != 2) {
            stderr.printf ("Usage: %s /full/path/to/some.pdf\n", args[0]);
            return 1;
        }

        Gtk.init (ref args);

        var sample = new PopplerSample (args[1]);
        sample.show_all ();

        Gtk.main ();
        return 0;
    }
}
