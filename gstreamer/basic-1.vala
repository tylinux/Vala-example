using Gst;


public static int main(string[] args) {
	Gst.init(ref args);

	Gst.Element pipeline;
	try {
		pipeline = Gst.parse_launch("playbin uri=http://docs.gstreamer.com/media/sintel_trailer-480p.webm");
	} catch (Error e) {
		stderr.printf("Error:%s\n", e.message);
		return -1;
	}

	pipeline.set_state (Gst.State.PLAYING);

	Gst.Bus bus = pipeline.get_bus ();
	bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE, Gst.MessageType.ERROR | Gst.MessageType.EOS);

	pipeline.set_state (Gst.State.NULL);
    return 0;
}
