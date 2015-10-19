using Gst;

public static int main(string[] args) {
	Gst.Element source;
	Gst.Element slink;
	Gst.Pipeline pipeline;
	Gst.Element decoder;
	
	// init
    Gst.init(ref args);

	source = Gst.ElementFactory.make("filesrc", "disk_source");
	decoder = Gst.ElementFactory.make("mad", "decoder");
	slink = Gst.ElementFactory.make("autoaudiosink", "play_audio");
	pipeline = new Gst.Pipeline("audio-player");

	if (source == null || decoder == null ||
		slink == null || pipeline == null) {
		stderr.printf("Not all element can be created!\n");
		return -1;
	}

	source.set("location", args[1]);
	pipeline.add_many (source, decoder, slink);
	pipeline.set_state (Gst.State.PLAYING);
	Gst.Bus bus = pipeline.get_bus();
	bus.timed_pop_filtered (Gst.CLOCK_TIME_NONE, Gst.MessageType.ERROR | Gst.MessageType.EOS);

	pipeline.set_state (Gst.State.NULL);
    return 0;
}
