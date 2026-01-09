
s.quit


//FMSYNTH_V2

// to do
// Fix the pan position

// add in a random walking noise on the carrier




(
var power, fmSynth, carrier, modulator, volume, pan, randomC,randomM,randomI,randomP, index;
(
SynthDef.new(\fm1,
	{arg out=0, carrier=400,index=0.1, modulator=0, rndC=0.0, rndM=0.0,rndI=0.0,rndP=0.0,gate=1, pan=0.0,amp=0.0;

		var src, env, noise1, noise2, noise3, noise4;

		env = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
		noise1 = LFDNoise3.kr(rndC, 1);
		noise2 = LFDNoise3.kr(rndM, 1);
		noise3 = LFDNoise3.kr(rndI, 1);
		noise4 = LFDNoise3.kr(rndP, 1);
		src = PMOsc.ar(carrier.lag(0.1)*noise1.lag(0.1),modulator.lag(0.1)*noise2.lag(0.1), index.lag(0.1)*noise3.lag(0.1), 0, 1);


		Out.ar(out, Pan2.ar(src*env, pan*noise4, amp.lag(0.1)));

		// Out.ar(out,Pan2.ar(PMOsc.ar(carrier.lag(0.1), modulator.lag(0.1),1, 0, 1),pan.lag(0.1), amp.lag(0.1)));
}).add;



// Window.closeAll;

w = Window("fmSynthRandom", Rect(820, 00, 400,270))
.front
.alwaysOnTop_(true)
.background_(Color(0.1,0.6,0.6));
// w.alwaysOnTop_(true);
/*z = {arg out=0, carrier=400, modulator=100, pan=0.0,amp=0.1;
	var src = PMOsc.ar(carrier, modulator,1, 0, 1);
	// var env = EnvGen.ar(Env.linen,doneAction:2);
	Out.ar(out,Pan2.ar(src,pan, amp));
};*/


y = 70;



//power on off button

power = Button(w, Rect(20, 210, 80, 40))
.states_([
	["Poder On!", Color.blue, Color.gray],
	["Poder Off!", Color.red, Color.yellow]
])
.action_({
	arg obj;
	obj.value.postln;
	if(
		obj.value == 1,
		{fmSynth=Synth(\fm1)},
		{fmSynth.set(\gate, 0)}

	);
});

// sliders

carrier = Slider(w,Rect(20, 20, 200, 30))
.background_(Color(0.9,0,0.9, 0.3))
.knobColor_(Color(0.4, 0.4, 0.0,0.9))
.action_({
	arg obj;
	obj.value.postln;
	fmSynth.set(\carrier, obj.value.linexp(0,1,50,1000));

})
.value_(0.7);
StaticText.new(w, Rect(220, 24, 60, 20)).string_("Carrier")
.font_(Font("Monaco", 14));


modulator = Slider(w, Rect(20, 60, 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;
	obj.value.postln;
	fmSynth.set(\modulator, obj.value.linexp(0, 1, 0.1, 1000));
});
StaticText.new(w, Rect(220, 64, 100, 20)).string_("Modulator")
.font_(Font("Monaco", 14));




index = Slider(w, Rect(20, 100, 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg view;
	fmSynth.set(\index, view.value.linlin(0,1,0,100));
});
StaticText.new(w, Rect(220, 104, 50, 20)).string_("index")
.font_(Font("Monaco", 14));





volume = Slider(w, Rect(20, 140, 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;
	obj.value.postln;

	fmSynth.set(\amp, obj.value.linlin(0, 1, 0, 1));

});
StaticText.new(w, Rect(220, 144, 60, 20)).string_("Volume")
.font_(Font("Monaco", 14));


pan = Slider(w, Rect(20, 180, 200, 30))
.background_(Color(0.9, 0.0,0.9,0.4))
.action_({
	arg obj;

	fmSynth.set(\pan, obj.value.linlin(0,1,-1,1,));

})
.value_(0.5);
StaticText.new(w, Rect(220, 184, 60, 20)).string_("Pan")
.font_(Font("Monaco", 14));



// random carrier knob
randomC = Knob.new(w, Rect(310, 20, 30, 30))
.action_({
	arg view;
	fmSynth.set(\rndC, view.value.linlin(0,1,0.1,10))
});
StaticText.new(w, Rect(305, 40, 40, 20))
.font_(Font("Monaco", 10))
.string_("R");


// random modulator knob
randomM = Knob.new(w, Rect(310, 60, 30, 30))
.action_({
	arg view;
	fmSynth.set(\rndM, view.value.linlin(0,1,0.1,10))
});
StaticText.new(w, Rect(310, 40, 40, 20))
.font_(Font("Monaco", 10))
.string_("R");


// random Index knob
randomI = Knob.new(w, Rect(310, 100, 30, 30))
.action_({
	arg view;
	fmSynth.set(\rndI, view.value.linlin(0,1,0.1,10))
});
StaticText.new(w, Rect(310, 40, 40, 20))
.font_(Font("Monaco", 10))
.string_("R");


// random Index knob
randomP = Knob.new(w, Rect(310, 180, 30, 30))
.action_({
	arg view;
	fmSynth.set(\rndP, view.value.linlin(0,1,0.1,5))
});
StaticText.new(w, Rect(310, 40, 40, 20))
.font_(Font("Monaco", 10))
.string_("R");

s.meter;
// s.scope;
);
)





