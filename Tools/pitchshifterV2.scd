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

***TODO for V2

1 - dry out level - done
2 - wet out level -done
3 - move around the sliders - done
4 - fixed the dry output problem.


*/



s.boot

s.meter
s.quit
(
var power, pitchshifter, lIn, dryVol, pR, pD, tD, fxVol, filter;
(
SynthDef(\pitchshifter, {
	arg out=0, levelIn = 0, wSize=1, pRatio=0.000001, pDisp = 0.0, tDisp = 0.0, gate = 1, cutoff=20000, q=1, dryAmp=0,fxAmp=0, pan=0.0;

	var src,filt, fx, env;
	env = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	src = SoundIn.ar(0) * levelIn;
	filt = RLPF.ar(src,cutoff, q);
	fx = PitchShift.ar(src, wSize, pRatio, pDisp, tDisp);
	Out.ar(out, Pan2.ar(fx*env, pan, fxAmp));
	Out.ar(out, Pan2.ar(filt*env, pan, dryAmp));
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

y = 50;
// Window.closeAll;
// s.meter;
w=Window.new("Pitchshifter", Rect(100, 100, 600, 300)).front
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



// dry Volume slider
// maybe this is something that needs a hard set????
dryVol = Slider.new(w, Rect(10, 170, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\dryAmp, view.value.linlin(0,1,0,1));
});

StaticText.new(w, Rect(215, 170, 80, 30))
.string_("dry amp")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


//Pitch ratio slider

pR = Slider.new(w, Rect(10, 50, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\pRatio, view.value.linlin(0,1,0.000001,4));
});

StaticText.new(w, Rect(215, 50, 80, 30))
.string_("pitchRatio")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);


//Pitch Dispersion

pD = Slider.new(w, Rect(10, 90, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\pDisp, view.value.linlin(0, 1, 0, 10))
});

StaticText.new(w, Rect(215, 90, 80, 30))
.string_("Pitch Dispersion")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);



//Time Dispersion

tD = Slider.new(w, Rect(10, 130, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\tDisp, view.value.linlin(0, 1, 0, 1));
});

StaticText.new(w, Rect(215, 130, 80, 30))
.string_("Time Dispersion")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);



// filter 2d slider

filter = Slider2D.new(w, Rect(300, 10, 290, 280))
.x_(1.0)
.y_(1.0)
.action_({
	|sl|
	var cutoffVal = sl.x.linlin(0, 1, 20, 20000); // Map x from 20 Hz to 20 kHz
	var qVal = sl.y.linlin(0, 1, 0.1, 1); // Map y from 0.1 to 10 for resonance
	pitchshifter.set(\cutoff, cutoffVal, \q, qVal);
	cutoffVal.postln; // Debugging
	qVal.postln; // Debugging
	// pitchshifter.set(\cutoff,sl.x , \q, sl.y);
})
.front;




// fx vol
fxVol = Slider.new(w, Rect(10, 210, 200, 30))
.action_({
	arg view;
	view.value.postln;
	pitchshifter.set(\fxAmp, view.value.linlin(0, 1, 0, 4))
});

StaticText.new(w, Rect(215, 210, 80, 30))
.string_("fx amp")
.stringColor_(Color.white)
.background_(Color.gray)
.align_(\center);




w.onClose_({pitchshifter.free})
);
)

