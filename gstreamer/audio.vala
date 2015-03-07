using Gst;

void main (string[] args) {
    // Initializing GStreamer
    Gst.init (ref args);

    // Creating pipeline and elements
    var pipeline = new Pipeline ("test");
    var src = ElementFactory.make ("audiotestsrc", "my_src");
    var sink = ElementFactory.make ("autoaudiosink", "my_sink");

    // Adding elements to pipeline
    pipeline.add_many (src, sink);

    // Linking source to sink
    src.link (sink);

    // Setting waveform to square
    src.set ("wave", 1);

    // Set pipeline state to PLAYING
    pipeline.set_state (State.PLAYING);

    // Creating and starting a GLib main loop
    new MainLoop ().run ();
}
