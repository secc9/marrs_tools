// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S
// PitchShifter.



// this should use a pitchshift on an audio input

// think of a name



/*
list of things to do

1 - build a synthdef
    1.1 - need - Audio in
    1.2 - pitchshift

2 - build a gui
    2.1 - window - done
    2.2 - power switch - done
    2.3 - add in sliders for
         - input level - done
         - window size - done
         - pitch ratio - done
         - pitch dispertion - done
         - time Dispertion - done
         - volume - done

3 - Alwasy on top


keep working on stuff.
maybe get rid of the window size and replace with a pan slider

***TODO

1 - dry out level
2 - wet out level



*/



s.boot

s.meter
s.quit
(
var power, pitchshifter, lIn, ws, pR, pD, tD, vol;
(
SynthDef(\pitchshifter, {
	arg out=0, levelIn = 0, wSize=0.1, pRatio=0, pDisp = 0.0, tDisp = 0.0, gate = 1, amp=0, pan=0.0;

	var src, env;
	env = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	src = SoundIn.ar(0,levelIn);
	src = PitchShift.ar(src, wSize, pRatio, pDisp, tDisp);
	Out.ar(out, Pan2.ar(src*env, pan, amp));
}).add;
);


/*
Tests
a = Synth(\pitchshifter)
a.set(\levelIn, 0.3)
a.set(\wSize, 10)
a.set(\pRatio, 8)
a.set(\pDisp, 1)
a.set(\tDisp, 4)
a.free
*/

//gui

(
// Window.closeAll;
// s.meter;
w=Window.new("Pitchshifter", Rect(100, 100, 300, 300)).front
.background_(Color.new255(230, 0, 224, 50))
.alwaysOnTop_(true);



// power button on and off
power = Button.new(w, Rect(10, 250, 280, 30))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
])
.action_({
	arg view;
	if(
		view.value == 1,
		{pitchshifter = Synth.new(\pitchshifter, [\vol, 0])},
		{pitchshifter.set(\gate,0)}
	);
});


// audio level in
//
lIn = Slider.new(w, Rect(10, 10, 200,30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\levelIn, view.value.linlin(0, 1, 0, 3));
});
StaticText.new(w, Rect(230, 10, 50, 30))
.string_("level in")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


// window size slider
// maybe this is something that needs a hard set????
ws = Slider.new(w, Rect(10, 50, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\wSize, view.value.linlin(0,1,0,10));
});

StaticText.new(w, Rect(215, 50, 80, 30))
.string_("window size")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


//Pitch ratio slider

pR = Slider.new(w, Rect(10, 90, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\pRatio, view.value.linlin(0,1,0,4));
});

StaticText.new(w, Rect(215, 90, 80, 30))
.string_("pitchRatio")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


//Pitch Dispersion

pD = Slider.new(w, Rect(10, 130, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\pDisp, view.value.linlin(0, 1, 0, 10))
});

StaticText.new(w, Rect(215, 130, 80, 30))
.string_("Pitch Dispersion")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);



//Time Dispersion

tD = Slider.new(w, Rect(10, 170, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\tDisp, view.value.linlin(0, 1, 0, 1));
});

StaticText.new(w, Rect(215, 170, 80, 30))
.string_("Time Dispersion")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


vol = Slider.new(w, Rect(10, 210, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\amp, view.value.linlin(0, 1, 0, 4))
});

StaticText.new(w, Rect(215, 210, 80, 30))
.string_("volume")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


);
)

