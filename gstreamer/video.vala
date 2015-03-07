//# Copyright (c) 2008 Carnegie Mellon University.
//#
//# You may modify and redistribute this file under the same terms as
//# the CMU Sphinx system.  See
//# http://cmusphinx.sourceforge.net/html/LICENSE for more information.

// valac --pkg gstreamer-0.10 --pkg gtk+-2.0 shpinx_livedemo.vala
using Gtk;
using Gst;


public class DemoApp : GLib.Object {
    private Gtk.Window window;
    private Gtk.TextBuffer textbuf;
    private dynamic Gst.Element asr;
    private dynamic Gst.Pipeline pipeline;
    private Gst.Element vader;
    private Gtk.TextView text;
    private Gtk.ToggleButton button;
    
    ////GStreamer/PocketSphinx Demo Application//
    public DemoApp() {
        ////Initialize a DemoApp object//
        this.init_gui();
        this.init_gst();
    }

    private void init_gui() {
        ////Initialize the GUI components//
        this.window = new Gtk.Window();
        this.window.delete_event.connect( () => { Gtk.main_quit(); 
												  return false; });
        this.window.set_default_size(400,200);
        this.window.set_border_width(10);
        
        var vbox        = new Gtk.VBox(false, 0);
        this.textbuf    = new Gtk.TextBuffer(null);
        
        text            = new Gtk.TextView.with_buffer(this.textbuf);
        text.set_wrap_mode(WrapMode.WORD);
        
        vbox.pack_start(text, true, true, 0);
        
        button = new Gtk.ToggleButton.with_label("Speak");
        button.clicked.connect(this.button_clicked);
        
        vbox.pack_start(button, false, false, 5);
        
        this.window.add(vbox);
        this.window.show_all();
    }

    private void init_gst() {
        ////Initialize the speech components//
        try {
            this.pipeline =
            (Gst.Pipeline) Gst.parse_launch("gconfaudiosrc ! 
audioconvert ! audioresample ! vader name=vad auto-threshold=true ! 
pocketsphinx name=asr !                      fakesink");
        }
        catch(Error e) {
            print("%s\n", e.message);
        }
        this.asr = this.pipeline.get_by_name("asr");
        this.asr.partial_result.connect(this.asr_partial_result);
        this.asr.result.connect(this.asr_result);
        this.asr.set_property("configured", true);
        
        var bus = this.pipeline.get_bus();
        bus.add_signal_watch();
        bus.message.connect(this.application_message);
//        bus.message.connect(this.application_message);
        this.pipeline.set_state(Gst.State.PAUSED);
    }

    private void asr_partial_result(Gst.Element sender, string text, 
									string uttid) {
        //Forward partial result signals on the bus to the main thread.//
			var gststruct = new Gst.Structure.empty("partial_result");
        gststruct.set_value("hyp", text);
        gststruct.set_value("uttid", uttid);
        asr.post_message(new Gst.Message.application(this.asr, 
													 gststruct));
    }

    private void asr_result(Gst.Element sender, string text, string 
							uttid) {
        //Forward result signals on the bus to the main thread.//
        var gststruct = new Gst.Structure.empty("result");
        gststruct.set_value("hyp", text);
        gststruct.set_value("uttid", uttid);
        asr.post_message(new Gst.Message.application(this.asr, 
													 gststruct));
    }

    private void application_message(Gst.Bus bus, Gst.Message msg) {
        //Receive application messages from the bus.//
        if(msg.type != Gst.MessageType.APPLICATION)
            return;
        if(msg.get_structure() == null)
            return;
        string msgtype = msg.get_structure().get_name();
        if(msgtype == "partial_result") {
            GLib.Value hy = msg.get_structure().get_value("hyp");
            GLib.Value ut = msg.get_structure().get_value("uttid");
            this.partial_result(hy, ut);
        }
        else if(msgtype == "result") {
            GLib.Value hy = msg.get_structure().get_value("hyp");
            GLib.Value ut = msg.get_structure().get_value("uttid");
            this.final_result(hy, ut);
            this.pipeline.set_state(Gst.State.PAUSED);
            this.button.set_active(false);
        }
    }

    private void partial_result(GLib.Value hyp, GLib.Value uttid) {
        //Delete any previous selection, insert text and select it.//
        // All this stuff appears as one single action
        this.textbuf.begin_user_action();
        this.textbuf.delete_selection(true, this.text.get_editable());
        this.textbuf.insert_at_cursor((string)hyp, 
									  ((string)hyp).length);
        var ins     = this.textbuf.get_insert();
        Gtk.TextIter iter;
        this.textbuf.get_iter_at_mark(out iter, ins);
//        var iter    = this.textbuf.get_iter_at_mark(ins);
        iter.backward_chars(((string)hyp).length);
        this.textbuf.move_mark(ins, iter);
        this.textbuf.end_user_action();
    }

    private void final_result(GLib.Value hyp, GLib.Value uttid) {
        //Insert the final result.//
        // All this stuff appears as one single action
        this.textbuf.begin_user_action();
        this.textbuf.delete_selection(true, this.text.get_editable());
        this.textbuf.insert_at_cursor(((string)hyp), 
									  ((string)hyp).length);
        this.textbuf.end_user_action();
    }

    private void button_clicked(Gtk.Widget sender) {
        //Handle button presses.//
        if(((ToggleButton)sender).get_active()) {
            ((ToggleButton)sender).set_label("Stop");
            this.pipeline.set_state(Gst.State.PLAYING);
        }
        else {
            ((ToggleButton)sender).set_label("Speak");
            vader = this.pipeline.get_by_name("vad");
            vader.set_property("silent", true);
        }
    }
}


void main(string[] args) {
    Gtk.init(ref args);
    Gst.init(ref args);
    
    var app = new DemoApp();
    Gtk.main();
}
