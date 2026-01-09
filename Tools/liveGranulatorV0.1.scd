

// Title - Live Granular input
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S



/*

What am I?

A granular synth that processes a live input


1 - make a synthdef
    1.1 needs
    1.2 Audio in
    1.3 MonoGrain

2 - build a gui
    2.1 power button - done
    2.2 winsize slider
    2.3 grain rate slider
    2.4 randomness slider
    2.5 volume
    2.6 a live audio input waveform window
TODO
1 - look at static text box sizes

*/


s.boot;
s.quit;

(
var power, liveGran, winSize, grainrate, winrandpct, vol, move;
(
SynthDef(\liveGranulator, {
	arg out = 0, gate=1,wSize=0.01,gRate=1,winRand=0, amp = 1;

	var src, env;
	env = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);

	src = SoundIn.ar(0, 0.5);
	src = MonoGrain.ar(src, wSize,gRate,winRand,amp);

	Out.ar(out, Pan2.ar(src*env, 0.0,amp));
}).add;
);

/*
//test
a = Synth(\liveGranulator)
a.set(\wSize, 0.4)
a.set(\gRate, 6)
a.set(\winRand, 1)
a.set(\wSize, 0.1)
*/

//gui

(

// Window.closeAll;
// s.meter;
w = Window.new("liveGranulator", Rect(250,100, 300,300)).front
.background_(Color.new255(0, 100, 255, 120))
.alwaysOnTop_(true);


//power button

power = Button.new(w, Rect(250, 10, 40, 30))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
])
.action_({
	arg view;
	if(
		view.value == 1,
		{liveGran = Synth(\liveGranulator)},
		{liveGran.set(\gate, 0)}
	);
});

move = 60;



// 2.2 winsize slider
winSize = Slider.new(w, Rect(10, 10, 40, 200))
.action_({
	arg view;
	view.value.postln;
	liveGran.set(\wSize, view.value.linlin(0,1,0.01,0.6))
});
StaticText.new(w, Rect(10,200, 40, 80))
.string_("win size")
.align_(\center)
.stringColor_(Color.white);



// 2.3 grain rate slider
grainrate = Slider.new(w, Rect(10+move, 10, 40, 200))
.action_({
	arg view;
	view.value.postln;
	liveGran.set(\gRate, view.value.linlin(0,1,1,20))
});
StaticText.new(w, Rect(10+move,200, 40, 80))
.string_("grain rate")
.align_(\center)
.stringColor_(Color.white);


// 2.4 randomness slider
winrandpct = Slider.new(w, Rect(10+(move*2), 10, 40, 200))
.action_({
	arg view;
	view.value.postln;
	liveGran.set(\winRand, view.value.linlin(0,1,0,2))
});
StaticText.new(w, Rect(10+(move*2),200, 50, 80))
.string_("window random")
.align_(\center)
.stringColor_(Color.white);


// 2.5 volume
vol = Slider.new(w, Rect(10+(move*3), 10, 40, 200))
.action_({
	arg view;
	view.value.postln;
	liveGran.set(\amp, view.value.linlin(0,1,0,10))
});
StaticText.new(w, Rect(10+(move*3),200, 50, 80))
.string_("volume")
.align_(\center)
.stringColor_(Color.white);


// 2.6 a live audio input waveform window
);


w.onClose_({liveGran.release(2)});
)
