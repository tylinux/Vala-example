using Gtk;
using GLib;
using Alsa;

public class MyFrame : Gtk.Window {
	private Alsa.Mixer mixer;
	
	public MyFrame() {
		
		// Set Alsa
		Alsa.CardInfo info;
		Alsa.Card card;
		Alsa.Card.open(out card);
		Alsa.CardInfo.alloc(out info);
		card.card_info(info);
		
		Alsa.Mixer.open(out this.mixer);
		this.mixer.attach();
		this.mixer.register();
		this.mixer.load();

		// Set Main Window
		this.title = "ALSA Example";
		this.border_width = 10;
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(200, 100);

		var hbox = new Box(Orientation.VERTICAL, 0);

		var vbox = new Box(Orientation.HORIZONTAL, 5);
		var lbl_master = new Label("Master : ");
		vbox.pack_start(lbl_master, false, false, 0);
		var scale_master = new Gtk.Scale.with_range(Orientation.HORIZONTAL, 0, 100, 1);
		scale_master.value_changed.connect(() => {
				this.set_master_vol((long) scale_master.get_value());
			});
		vbox.pack_start(scale_master, true, true, 0);

		hbox.pack_start(vbox, false, false, 0);

		vbox = new Box(Orientation.HORIZONTAL, 5);
		var lbl_pcm = new Label("PCM :      ");
		vbox.pack_start(lbl_pcm, false, false, 0);
		var scale_pcm = new Gtk.Scale.with_range(Orientation.HORIZONTAL, 0, 100, 1);
		scale_pcm.value_changed.connect(() => {
				this.set_pcm_vol((long) scale_pcm.get_value());
			});
		vbox.pack_start(scale_pcm, true, true, 0);
		hbox.pack_start(vbox, false, false, 0);
		
		// Set default value
		scale_master.set_value(this.get_master_vol());
		scale_pcm.set_value(this.get_pcm_vol());

		this.add(hbox);
		this.destroy.connect(Gtk.main_quit);

		
		
	}

	public long get_master_vol() {
		var pcm_vol = mixer.first_elem();
		pcm_vol.set_playback_volume_range(0, 100);

		long lvol, rvol;
		pcm_vol.get_playback_volume(Alsa.SimpleChannelId.FRONT_LEFT, out lvol);
		pcm_vol.get_playback_volume(Alsa.SimpleChannelId.FRONT_RIGHT, out rvol);
		return (lvol + rvol) >> 1;
	}

	public void set_master_vol(long vol) {
		var pcm_vol = mixer.first_elem();
		pcm_vol.set_playback_volume_range(0, 100);
		pcm_vol.set_playback_volume(Alsa.SimpleChannelId.FRONT_LEFT, vol);
		pcm_vol.set_playback_volume(Alsa.SimpleChannelId.FRONT_RIGHT, vol);		
	}

	public long get_pcm_vol() {
		var pcm_vol = mixer.first_elem();
		pcm_vol = pcm_vol.next();
		pcm_vol = pcm_vol.next();
		pcm_vol = pcm_vol.next();
		pcm_vol.set_playback_volume_range(0, 100);

		long lvol, rvol;
		pcm_vol.get_playback_volume(Alsa.SimpleChannelId.FRONT_LEFT, out lvol);
		pcm_vol.get_playback_volume(Alsa.SimpleChannelId.FRONT_RIGHT, out rvol);
		return (lvol + rvol) >> 1;
	}

	public void set_pcm_vol(long vol) {
		var pcm_vol = mixer.first_elem();
		pcm_vol = pcm_vol.next();
		pcm_vol = pcm_vol.next();
		pcm_vol = pcm_vol.next();
		pcm_vol.set_playback_volume_range(0, 100);
		pcm_vol.set_playback_volume(Alsa.SimpleChannelId.FRONT_LEFT, vol);
		pcm_vol.set_playback_volume(Alsa.SimpleChannelId.FRONT_RIGHT, vol);		
	}
}


public static int main(string[] args) {
    Gtk.init(ref args);
	var window = new MyFrame();
	window.show_all();
	Gtk.main();	
    return 0;
}
