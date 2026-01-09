//
// Title - vanilla looper
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S
// date 12/02/2025



//IT Broke somehow.....

// try again at some point
// FAK!!!!!!!
/*

build a gui
power button - done
audio file view - done
//----
Need**
    rate
    gate
    startPos
    endPos
    endLoops
    interpolation





*/

s.boot;
s.meter;



(

b = Buffer.read(s,"/Users/ashleysagar/Music/MusicProjects/Ashley_Sagar_solo/samples/heavyTrafficHamburg.wav");
);

b.play
b.free
(

var play, lpPlay, audioView, audioFile,rate,gate, loopPos, interp, volume, bufnum=0;
SynthDef(\looper, {
	arg out = 0, vol = 1, gate=1, rate=0, lGate=1.0, startLoop, endLoop, interp=2;

	var src, env;

	env = EnvGen.kr(Env.asr(1,1,1),gate, doneAction:2);
	src = LoopBuf.ar(2,b,BufRateScale.kr(b)*rate, lGate, 0.0, startLoop, endLoop, interp );

	Out.ar(out, Pan2.ar(src*env, 0, vol))
}).add;


//Tests
// a = Synth(\looper, [\startLoop, 10000, \endLoop, 15000, \rate, 1])
// a.set(\startLoop, 7000)


w = Window.new("looper", Rect(900, 1200, 500, 200),false)
.front
.alwaysOnTop_(true);




play=Button.new(w, Rect(10, 10, 50, 70))
.states_([
	["PLAY", Color.black, Color.red],
	["STOP", Color.black, Color.green]
])
.action_({
	arg btn;
	if(
		btn.value == 1,
		{lpPlay = Synth(\looper,[\out, 0, \bufnum, b, \gate, 1])},
		{lpPlay.free}
	);
});

k = 60;
y = 120;


// rate
rate = Slider.new(w, Rect(80, y+20, 400, 30))
.action_({
	arg rate;
	lpPlay.set(\rate, rate.value.linlin(0, 1, -1, 2))
})
.value_(0.5);
StaticText.new(w, Rect(250, 170, 400, 15))
.string_("rate");


// gate
// gate = Knob.new(w, Rect(140, y, k, k));

// startPosition

// startLoop + endLoop
loopPos = RangeSlider.new(w, Rect(80, 85, 400, 30))
.knobColor_(Color.blue)
.background_(Color.green)
.lo_(0.0)
.hi_(1.0)
.action_({
	arg sl;
	var startLoop, endLoop;
	startLoop = sl.lo * b.duration;
	endLoop = sl.hi * b.duration;
	lpPlay.set(\startLoop, startLoop, \endLoop, endLoop);
});
StaticText.new(w, Rect(180, 115, 400, 15))
.string_("loop start and end points");

// endLoops

// interpolation
interp = ListView.new(w, Rect(10, 90, 20, 50))
.items_(["1", "2", "4"])
.background_(Color.cyan)
.stringColor_(Color(1, 0, 1))
.hiliteColor_(Color(1, 0.4, 0))
.action_({
	arg interp;
	var value = interp.value;
	value.postln;
	if(lpPlay.notNil,
		{lpPlay.set(\interp, value)
		});
});


// volume
volume = Slider.new(w, Rect(40, 90, 20, 80))
.action_({
	arg vol;
	lpPlay.set(\vol, vol.value.linlin(0, 1, 0, 1));
});

// audio file view
audioView = SoundFileView.new(w,Rect(80, 10, 400, 70));

audioFile = SoundFile.new;

audioFile.openRead("/Users/ashleysagar/Music/MusicProjects/Ashley_Sagar_solo/samples/heavyTrafficHamburg.wav");

audioView.soundfile = audioFile;
audioView.readWithTask(0, audioFile.numFrames);


w.onClose({lpPlay.free;b.free});
)
b