// Title - Sine tone generator
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S


s.quit
s.boot

/*
This is a sine tone generator

Maybe completely rewrite this from the ground up.

use the layout, but put volumes on each osc



*/


(
/*Window.closeAll;*/

g = Group.new;

////////////
//Synths


a = {
	var sig1;
	sig1 = Pan2.ar(SinOsc.ar(\freqA.kr(20).lag(0.1)),\pan.kr(0.0),\amp.kr(0.1));
}.play(target:g);

b = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

c = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

d = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

e = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

f = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

h = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

i = {
	var sig1;
	sig1 = SinOsc.ar(\freqA.kr(20).lag(0.1), mul:0.1!2);
}.play(target:g);

//window stuff
w = Window("SineWaves", Rect(400, 400, 300, 500)).front;
w.alwaysOnTop_(true);
w.onClose_({g.freeAll});





//GUI actions

~freq1 = Slider.new();
~freq1.action_({arg v;
	a.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

/*~pan1=Knob.new();
~pan1.action_({arg v;
	a.set(\pan, v.value.linexp(0,1,-1,1).postln)});

~amp1=Knob.new();
~amp1.action_({arg v;
	a.set(\amp, v.value.linexp(0,1,0,1).postln)});*/

~freq2 = Slider.new();
~freq2.action_({arg v;
	b.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq3 = Slider.new();
~freq3.action_({arg v;
	c.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq4 = Slider.new();
~freq4.action_({arg v;
	d.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq5 = Slider.new();
~freq5.action_({arg v;
	e.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq6 = Slider.new();
~freq6.action_({arg v;
	f.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq7 = Slider.new();
~freq7.action_({arg v;
	h.set(\freqA, v.value.linexp(0,1,20,20000).postln)});

~freq8 = Slider.new();
~freq8.action_({arg v;
	i.set(\freqA, v.value.linexp(0,1,20,20000).postln)});




w.layout_(HLayout(~freq1, ~freq2, ~freq3,~freq4,~freq5,~freq6,~freq7,~freq8 ));
s.meter;
s.scope;

)



s.meter
