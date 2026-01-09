
s.quit


//FMSYNTH1

// to do
// Fix the pan position





(
SynthDef.new(\fm1,
	{arg out=0, carrier=400, modulator=0, pan=0.0,amp=0.1;


		Out.ar(out,Pan2.ar(PMOsc.ar(carrier.lag(0.1), modulator.lag(0.1),1, 0, 1),pan.lag(0.1), amp.lag(0.1)));
}).add;



// Window.closeAll;

w = Window("fmSynth", Rect(820, 00, 400,270))
.front
.alwaysOnTop_(true)
.background_(Color(0.1,0.6,0.6));
// w.alwaysOnTop_(true);
/*z = {arg out=0, carrier=400, modulator=100, pan=0.0,amp=0.1;
	var src = PMOsc.ar(carrier, modulator,1, 0, 1);
	// var env = EnvGen.ar(Env.linen,doneAction:2);
	Out.ar(out,Pan2.ar(src,pan, amp));
};*/


y = 50;



//power on off button

~powerButton = Button(w, Rect(20, 210, 80, 40))
.states_([
	["Poder On!", Color.blue, Color.gray],
	["Poder Off!", Color.red, Color.yellow]
])
.action_({
	arg obj;
	obj.value.postln;
	if(
		obj.value == 1,
		{
			z = Synth(\fm1, [
				\carrier,~carrier.value.linexp(0,1,50,1000),
				\modulator,~modulator.value.linexp(0, 1, 0.1, 1000),
				\amp, ~fmSynthvolume.value.linlin(0, 1, 0, 1),
				\pan, ~pan.value

			]).register;
		},
		{z.free}
	);
});

// sliders

~carrier = Slider(w,Rect(20, 20, 200, 30))
.background_(Color(0.9,0,0.9, 0.3))
.knobColor_(Color(0.4, 0.4, 0.0,0.9))
.action_({
	arg obj;
	obj.value.postln;
	if(
		z.isPlaying,{
	z.set(\carrier, obj.value.linexp(0,1,50,1000));
		}
	);
});
StaticText.new(w, Rect(220, 24, 60, 20)).string_("Carrier")
.font_(Font("Monaco", 14));


~modulator = Slider(w, Rect(20, 20+(y), 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;
	obj.value.postln;
	if(z.isPlaying,{
	z.set(\modulator, obj.value.linexp(0, 1, 0.1, 1000));
	}
	);
});
StaticText.new(w, Rect(220, 24+(y), 100, 20)).string_("Modulator")
.font_(Font("Monaco", 14));


~fmSynthvolume = Slider(w, Rect(20, 20+(y*2), 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;
	obj.value.postln;
	if(z.isPlaying,{
	z.set(\amp, obj.value.linlin(0, 1, 0, 1));
	}
	);
});
StaticText.new(w, Rect(220, 24+(y*2), 60, 20)).string_("Volume")
.font_(Font("Monaco", 14));


~pan = Slider(w, Rect(20, 20+(y*3), 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;
	obj.value.postln;
	if(z.isPlaying,{
	z.set(\pan, obj.value.linlin(0,1,-1,1,));
	}
	);
})
.value_(0.5);
StaticText.new(w, Rect(220, 24+(y*3), 60, 20)).string_("Pan")
.font_(Font("Monaco", 14));



s.meter;
// s.scope;
);






