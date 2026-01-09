// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S
// Crackle and Dust


// this is a crackle and dust generator


/*
list of things to do

1 - Build a synthdef with --

    1.1 - dust ugen
    1.2 - crackle ugen
    1.3 - a RLPF ugen
    1.4 - reverb
    1.5 - delay

2 - make the reverb work on a bus.
3 - make the dalay work on a bus

4 - build a gui
    4.1 - window - done
    4.2 - power - done
    4.3 - dust knob - done
    4.4 - crackle knob -done
    4.5 - crackle amp - done
    4.6 - dust amp - done
    4.7 - filter cut - done
    4.8 - filter rez - done


TODO
 add in a modulator to modulate all parameters


// need to learn how to use 2d slider.

maybe 2 x 2d sliders for the dust crackle and the filter cut and rez

*/


s.boot
s.meter
s.options.memSize_(65536 * 4);
s.reboot;

(
var power, cNd, crackSld,cAmpSld, dDensSlid, dAmpSlid, filtSld, cutSlid, rzSlid;
var sldSrt = 20;
var sldLen = 370;
var txtSrt = 400;
(
SynthDef(\crackleNdust, {
	arg out = 0,
	cut=10000,      // filter cutoff
	rez=0.1,       // filter resonence
	cAmp=0.0,        // crackle amp
	dAmp=0.0,        // dust amp
	gate=1,        // env gate
	dDensity=0.0,  // dust density
	cChaos=0.9,    // crackle chaos

	/*
	reverb arguments
	time = 1.0,    // verb time
	damp = 0.0,    // damping
	size = 1.0,    // size
	eDiff = 0.707, // shape of early reflections
	modD = 0.1,    // depth of delay modulation
	modF = 2.0,    //freq of modulation
	low = 1.0,     //mul of low
	mid = 1.0,     // mul of mid
	hi = 1.0,      // mul of mid
	loCut = 500.0, // crossover of low and mid
	hiCut = 2000.0,// crossover at mid and hi
	*/

	vol=1;         // pan2 volume

	var env, crc, dst, filt, verb, delay;

	env = EnvGen.kr(Env.asr(1, 1, 1), gate, doneAction:2);
	crc = Crackle.ar(cChaos, cAmp);
	dst = Dust.ar(dDensity, dAmp);
	filt = RLPF.ar(crc+dst,cut,rez);
	// verb = JPverb.ar(filt, time, damp, size, eDiff, modD,modF,low,mid,hi,loCut,hiCut);

	Out.ar(out, Pan2.ar(filt*env, 0,vol))

}).add;
);


/*
Tests
a = Synth(\crackleNdust)
a.set(\cAmp,0.2, \cChaos, 1)
a.set(\dAmp, 1, \dDensity, 3)
a.set(\time, 3)
a.set(\damp, 0.6)
a.set(\size, 5)
a.set(\low, 0.0, \mid, 0.0, \hi, 1.0)
a.set(\cut, 1000)
a.free
*/
(

// Window.closeAll;
// s.meter;
w = Window.new("crackleNdust", Rect(0, 0, 500, 400)).front
.alwaysOnTop_(true);

// power on and off
power = Button.new(w, Rect(10, 360, 480, 30))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
])
.action_({
	arg view;
	if(
		view.value == 1,
		{cNd = Synth.new(\crackleNdust)},
		{cNd.set(\gate,0)}
	)
});

//  slider for the crackle
crackSld = Slider.new(w, Rect(sldSrt, 10, sldLen, 30))
.action_({
	arg view;
	view.value.postln;
	cNd.set(\cChaos, view.value.linlin(0, 1, 0.9, 2.0));
});
StaticText.new(w, Rect(txtSrt, 10, 50, 30))
.string_("Crackle");

//crackle amp slider
cAmpSld = Slider.new(w, Rect(sldSrt, 50, sldLen, 30), 0.0)
.action_({
	arg view;
	view.value.postln;
	cNd.set(\cAmp, view.value.linlin(0,1,0,1));
});
StaticText.new(w, Rect(txtSrt, 50, 50, 30))
.string_("Crackle Amp");

// dust density slider
dDensSlid = Slider.new(w, Rect(sldSrt, 100, sldLen, 30))
.action_({
	arg view;
	view.value.postln;
	cNd.set(\dDensity, view.value.linlin(0,1,0.1, 100));
});

StaticText.new(w, Rect(txtSrt, 100, 50, 30))
.string_("Dust Density");

// dust amp slider
dAmpSlid = Slider.new(w, Rect(sldSrt, 140, sldLen, 30))
.action_(
	{
		arg view;
		view.value.postln;
		cNd.set(\dAmp, view.value.linlin(0, 1, 0, 1))
	});
StaticText.new(w, Rect(txtSrt, 140, 50, 30))
.string_("Dust Amp");

// Filter Cutoff
cutSlid = Slider.new(w, Rect(sldSrt, 190, sldLen, 30))
.value_(10000)
.action_({
	arg view;
	view.value.postln;
	cNd.set(\cut, view.value.linlin(0, 1, 100, 10000))
});
StaticText.new(w, Rect(txtSrt, 190, 50, 30))
.string_("Cutoff");

// resonance slider
rzSlid = Slider.new(w, Rect(sldSrt, 230, sldLen, 30))
.value_(1.0)
.action_({
	arg view;
	view.value.postln;
	cNd.set(\rez, view.value.linlin(0, 1, 0, 1))
});
StaticText.new(w, Rect(txtSrt, 230, 70, 30))
.string_("Resonance");
)

)