
(s.waitForBoot;
SynthDef(\test, {
	arg out=0, vol=0.5, pan=0.0, freq = 440, cut=10000, atk=0.01,rel=0.5;

	var src, env;
	env = EnvGen.kr(Env.perc(atk,rel), doneAction:2);
	src = LFTri.ar(freq,0.0, 0.7)+LFTri.ar(freq+rrand(1, 100), 0, 0.5);
	src = LPF.ar(src,cut);
	Out.ar(out, Pan2.ar(src*env, pan, vol));
}).add;
)

s.meter
Synth(\test)


Scale.directory
Scale.pelog

(
f = Routine{
	t =  1;
	l = 4;
	inf.do{

		var roll = rrand(1, 6).postln;
	case(
			{roll == 1}, {Synth(\test, [\freq, [60, 64, 66].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
			{roll == 2}, {Synth(\test, [\freq, [61, 65, 66].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
			{roll == 3}, {Synth(\test, [\freq, [57, 60, 63].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
			{roll == 4}, {Synth(\test, [\freq, [55, 57, 54].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
			{roll == 5}, {Synth(\test, [\freq, [69, 71, 73].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
			{roll == 6}, {Synth(\test, [\freq, [63, 64, 65].midicps.scramble, \atk,rrand(0.1,1), \rel, 0.5.rand(l)])},
	);
		t.rrand(0.25,4).wait;
	};

}.play;

)
t.reschedule
f.value.play
f.stop


(
Routine{
	t = 0.25;
	10.do{
		"yoy".scramble.postln;
		Synth(\test);
		t.wait
	};

	10.do{
		"bolo".scramble.postln;
		Synth(\test, [\freq, rrand(300, 500), \atk, 1, \rel, 3]);
		t.wait;

		10.do{
			"fvpopolr".scramble.postln;
			t.wait;
		};
	};

}.play
)

s.boot


(
Routine{
	arg inval;
	inval.postln;
}.value("hello routine")
)





