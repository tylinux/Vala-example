using Gst;

public static int main(string[] args) {
	private Gst.Element source;
	private GSt.Element slink;
	private Gst.Pipeline pipeline;
	private Gst.Element decoder;
	
	// init
    Gst.init(ref args);

	source = new Gst.ElementFactory.make("filesrc", "disk_source");
	decoder = new Gst.ElementFactory.make("mad", "decoder");
	slink = new Gst.ElementFactory.make("audioslink", "play_audio");
	pipeline = new Gst.Pipeline("audio-player");

	if (source == null || decoder == null ||
		slink == null || pipeline == null) {
		stderr.printf("Not all element can be created!\n");
		return -1;
	}

	
	
    return 0;
}
