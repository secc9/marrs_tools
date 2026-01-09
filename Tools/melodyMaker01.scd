s.boot
s.quit

/*what do I want to do??
I want to make a synth that plays random melodies at the press of a button.
1.press a button and a melody plays
2.press a rand button and it randomizes the order of tones played
3. prss a button and it can invert, retrograde, invert retrogade.
4. have a neat little gui
5. choose different synthdefs
6. coin flip
7. dice roll
8. note input box => use NumberBox


// thingds to do...
1 Make a basic synthdef
2 make a coin flip rand heads or tails and add in a seq
3 make gui window
4. add in a button that triggers coin flip

*/




(

var coin, dice, coinOff, diceOff, coinNotes;
(
SynthDef(\beep1, {
	arg out = 0, freq = 4400, amp=1;

	var sig, env;
	env = EnvGen.kr(Env.linen(0.01, 0.04, 0.1), doneAction:2);
	sig = SinOsc.ar(freq+1, 0.0, 0.1)+SinOsc.ar(freq+1, 0.0, 0.1);
	Out.ar(out, Pan2.ar(sig*env,0.0, amp));
}).add;

SynthDef(\beep2, {
	arg out = 0, freq = 660, amp=1;

	var sig, env;
	env = EnvGen.kr(Env.linen(0.01, 0.04, 0.1), doneAction:2);
	sig = SinOsc.ar(freq, 0.0, 0.1);
	Out.ar(out, Pan2.ar(sig*env,0.0, amp));
}).add;
);

(
//build the gui
// Window.closeAll;
// s.meter;
w = Window.new("melodie maker", Rect(200, 0, 400, 400),false).front
.background_(Color.new255(100, 200, 10, 130))
.alwaysOnTop_(true);



// coin flip to play an either or sequence

// build the coin flip note input box
coinNotes = NumberBox.new(w, Rect(10, 30, 100, 32));
coinNotes.value = 200;
coinNotes.action = {arg numb; n.set};


//coin flip button
coin = Button.new(w, Rect(300, 20, 50, 50))
.states_([
	["flip", Color.black, Color.red]
])
.action_({
	(
if(
	([0,1].choose == 1) && ([0,1].choose == 1),
	{Pdef(\seq1, Pbind(\instrument, \beep1,
				\note, Pseq([0,1,2,3], inf),
	\dur, 0.25,
	\amp, 1

			)).play.quant_(4);
		"Heads".postln
	},
	{Pdef(\seq1, Pbind(\instrument, \beep1,
		\note, Pseq([0, 1, 2, 3].reverse+2, inf),
	\dur, 0.25,
	\amp, 1
			)).play.quant_(4);
		"at least one tails".postln;

			}
);
)
});

// turn the coin flip off
coinOff = Button.new(w, Rect(360, 40, 30, 30))
.states_([
	["off", Color.black, Color.yellow]
])
.action_({
	arg view;
	if(view.value == 0)
	{	Pdef(\seq1).stop.quant_(4);
		Pdef(\seq2).stop.quant_(4);
	}
});


// dice roll button to choose one of 6 sequence variations
dice = Button.new(w, Rect(300, 100, 50, 50))
.states_([
	["roll", Color.black, Color.white]
])
.action_({

		var roll = rrand(1, 6), d = 0.25;
case(
	{roll == 1}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7]+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\original.postln},

	{roll == 2}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7].reverse+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\reverse.postln},

	{roll == 3}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7].scramble+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\scramble.postln},

	{roll == 4}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7].stutter(2)+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\stutter.postln},

	{roll == 5}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7].scramble.stutter+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\scrambleStutter.postln},
	{roll == 6}, {
			Pdef(\seq3,Pbind(\instrument,\beep1,
				\note, Pseq([1, 2, 3, 4, 5, 6, 7].pyramid+12, inf),
				\dur, d,
				\amp,1
			)).play.quant_(4);
			\pyramid.postln}
);
});

// turn the dice roll off
diceOff = Button.new(w, Rect(360, 120, 30, 30))
.states_([
	["off", Color.black, Color.yellow]
])
.action_({
	arg view;
	if(view.value == 0)
	{	Pdef(\seq3).stop.quant_(4);

	}
});




);
w.onClose_({\seq1.free;\seq2.free}); //make work?????
)






