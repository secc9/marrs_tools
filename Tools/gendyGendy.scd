//
// Title - a Gendy oscillator
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S
// date 05/02/2025



/*

a Gendy Synth which uses 2D Sliders for the minfreq and maxfreq


*/

s.scope

s.quit
s.boot;
s.meter
(
var power, gen, freqs, volume,ampDistortion, durDistortion, adparam, durDistribution, aScale, dScale, knumb, knobSize, knobX, knobY, fontX;
(
SynthDef(\gendy, {
	arg out=0, vol=0, gate=1, ampDist=1, durDist=0.0,adParam=1.0,ddParam=1.0,minFreq=30,maxFreq=30,ampScale=0.5,durScale=0.5,initCP=12,kNum=0;
	var src, env;
	env = EnvGen.kr(Env.asr(1,1,1),gate, doneAction:2);
	src = Gendy1.ar(ampDist,durDist,adParam,ddParam,minFreq,maxFreq,ampScale,durScale,initCP,kNum,1);
	Out.ar(out, Pan2.ar(src*env,0.0, vol));
}).add;
);

// a=Synth(\gendy)
// a.set(\minFreq, 200, \maxFreq,400)
// a.set(\ampDist, 4)
// a.set(\durDist, 1)
// a.set(\adParam, 0.0001)
// a.set(\ddParam, 0.1)
// a.set(\ampScale, 0.5)


//======GUI

w=Window.new("GendyGendy", Rect(1000, 700, 500, 500),false)
.background_(Color(0.1,0.4,0.6, 0.9))
.alwaysOnTop_(true)
.front;


//====Power
power = Button.new(w, Rect(10, 10, 30, 30))
.states_([
	["On", Color.black, Color.red],
	["Off", Color.black, Color.green]
])
.action_({
	arg power;
	if(
		power.value == 1,
		{gen=Synth(\gendy)},
		{gen.set(\gate,0)}
	)
});

knobSize = 30;
knobX = 95;
knobY = 150;
y = 40;
f = Font.sansSerif(12);
fontX = 30;



// ampDistortion
ampDistortion = ListView(w, Rect(150, 10, 200, 110))
.items_(["LINEAR", "CAUCHY", "LOGIST", "HYPERBCOS", "ARCSINE", "EXPON", "SINUS"])
.background_(Color.cyan)
.hiliteColor_(Color(1,0.4, 0))
.action_({
	arg ampDis;
	var value = ampDis.value;
	value.postln;
	if(gen.notNil, {
		gen.set(\ampDist, value)
	});
});



// DurationDistortion
durDistortion = Knob.new(w, Rect(knobX, knobY, knobSize, knobSize))
.action_({
	arg durD;
	gen.set(\durDist, durD.value.linlin(0, 1, 0.0,10.0));
});
StaticText.new(w,Rect(fontX, 155, 60, 30))
.string_("duration distortion")
.font_(f);


// adparam
adparam = Knob.new(w, Rect(knobX, knobY+y, knobSize, knobSize))
.action_({
	arg adPara;
	gen.set(\adParam, adPara.value.linlin(0, 1, 0.0001, 1));
})
.value_(1.0);
StaticText.new(w,Rect(fontX, 190, 75, 30))
.string_("amplitude distrubution")
.font_(f);


//durDistribution
durDistribution = Knob.new(w, Rect(knobX, knobY+(y*2), knobSize, knobSize))
.action_({
	arg ddPara;
	gen.set(\ddParam, ddPara.value.linlin(0, 1, 0.0001, 1))
})
.value_(1);
StaticText.new(w,Rect(fontX, 230, 75, 30))
.string_("duration distrubution")
.font_(f);



// 2d slider for the mina nd max freq
freqs = Slider2D.new(w, Rect(150, 150, 200, 200))
.x_(0.0)
.y_(0.0)
.action_({
	|sl|
	var minF = sl.x.linexp(0, 1, 30, 3000); // Scale x from 0-1 to 200-800 Hz
	var maxF = sl.y.linexp(0, 1, 30, 3000); // Scale y from 0-1 to 200-800 Hz
	gen.set(\minFreq, minF, \maxFreq, maxF);
});
StaticText.new(w, Rect(200, 355, 200, 15))
.string_("MinFreq / MaxFreq ");


//ampScale
aScale = Slider.new(w,Rect(150, 390, 200, 30))
.action_({
	arg aScale;
	gen.set(\ampScale, aScale.value.linlin(0, 1, 0, 1));
})
.value_(0.5);
StaticText.new(w, Rect(220, 420, 100, 20))
.string_("amp scale");

//Duration Scale
dScale = Slider.new(w, Rect(150, 440, 200, 30))
.action_({
	arg dScale;
	gen.set(\durScale, dScale.value.linlin(0, 1, 0, 1));
})
.value_(0.5);
StaticText.new(w, Rect(210, 470, 100, 20))
.string_("duration scale");

// Knum
knumb = Knob.new(w, Rect(45, 300, knobSize+30,knobSize+30))
.action_({
	arg knumb;
	gen.set(\kNum, knumb.value.linlin(0, 1, 0, 14) );
})
.value_(0.6);
StaticText.new(w, Rect(57, 365, 50, 10))
.string_("knum");

// Volume
volume = Slider.new(w, Rect(370, 150, 30, 200))
.action_({
	arg vol;
	gen.set(\vol, vol.value.linlin(0,1,0,0.7));
});
StaticText.new(w, Rect(360, 355, 50, 15))
.string_("volume");

w.onClose_({gen.free});
);



