
// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S
// June 2025

// Random Bleeps

// code adapted from David Cottle Book





/*(
{
	var trig, out, delay;
	trig = Impulse.kr(6);
	out = Blip.ar(
		TRand.kr(48, 72, trig).midicps,
		TRand.kr(1, 12, trig),
		max(0, TRand.kr(-0.5, 0.4, trig))
	);
	out = Pan2.ar(out, TRand.kr(-1.0, 1.0, trig));
	out = out*EnvGen.kr(Env.perc(0, 1), trig);
	out = Mix.ar({out}.dup(6))*0.2;
	delay = CombL.ar(out, 2.0, 4/6, 6);
	out+delay
}.play
)*/









(
var power, randBleeps, volume, triggerValue, freqLo, freqHi, harmLo, harmHi, delayTime, decayTime;
(
SynthDef(\randomBleeps, {
	arg  out = 0, gate = 1, vol = 0.0, tValue=6, fLow=4, fHi=72, hLow=1, hHi=12, delayTime = 4/6, decay = 6;

	var sig, env, delay, trig;

	trig = Impulse.kr(tValue);
	env = EnvGen.kr(Env.asr(1, 1,1), gate, doneAction:2);
	sig = Blip.ar(
		TRand.kr(fLow, fHi, trig).midicps,
		TRand.kr(hLow, hHi, trig),
		max(0, TRand.kr(-0.5, 0.4, trig))
	);
	sig = Pan2.ar(sig, TRand.kr(-1.0, 1.0, trig),vol);
	sig = sig * env;
	sig = Mix.ar({sig}.dup(6))*0.2;
	delay = CombL.ar(sig, 2.0, delayTime, decay );

	Out.ar(out, sig+delay);

}).add;

);


w = Window.new("Random Bleeps", Rect(100, 400, 200, 300))
.front
.alwaysOnTop_(true);


// power

power = Button.new(w, Rect(10, 10, 30, 20))
.action_({
	arg view;
	if(
		view.value == 1,
		{randBleeps=Synth(\randomBleeps)},
		{randBleeps.set(\gate, 0)}
	)
})
.states_([
	["ON", Color.black, Color.red],
	["OFF", Color.black, Color.green]
]);








// variables
h = 30;
n = 33;
l = 170;
f = Font("Monaco", 13);
// volume


volume = Slider.new(w, Rect(10, h, l, 20))
.action_({
	arg view;
	randBleeps.set(\vol, view.value.linlin(0,1,0,1))
});
StaticText.new(w, Rect(130, h-15, 50, 20))
.string_("volume")
.font_(f);





// triggerValue,

triggerValue = Slider.new(w, Rect(10, h+n, l, 20))
.action_({
	arg view;
	randBleeps.set(\tValue, view.value.linlin(0,1,0.5,20))
})
.value_(0.2);
StaticText.new(w, Rect(80, h+n-15, 120, 20))
.string_("trigger value")
.font_(f);



// freqLo,

freqLo = Slider.new(w, Rect(10, h+(n*2), l, 20))
.action_({
	arg view;
	randBleeps.set(\fLow, view.value.linlin(0,1,4,44))
})
.value_(0.1);
StaticText.new(w, Rect(110, h+(n*2)-15, 65, 20))
.string_("freq low")
.font_(f);



// freqHi,

freqHi = Slider.new(w, Rect(10, h+(n*3), l, 20))
.action_({
	arg view;
	randBleeps.set(\fHi, view.value.linlin(0,1,45,150))
})
.value_(0.4);
StaticText.new(w, Rect(110, h+(n*3)-15, 75, 20))
.string_("freq high")
.font_(f);


// harmLo,

harmLo = Slider.new(w, Rect(10, h+(n*4), l, 20))
.action_({
	arg view;
	randBleeps.set(\hLow, view.value.linlin(0,1,0.1,5))
})
.value_(0.1);
StaticText.new(w, Rect(80, h+(n*4)-15, 105, 20))
.string_("harmonics low")
.font_(f);


// harmHi,

harmHi = Slider.new(w, Rect(10, h+(n*5), l, 20))
.action_({
	arg view;
	randBleeps.set(\hHi, view.value.linlin(0,1,50,200))
})
.value_(0.4);
StaticText.new(w, Rect(70, h+(n*5)-15, 110, 20))
.string_("harmonics high")
.font_(f);




// delayTime,

delayTime = Slider.new(w, Rect(10, h+(n*6), l, 20))
.action_({
	arg view;
	randBleeps.set(\delayTime, view.value.linlin(0,1,0.1,10))
})
.value_(0.4);
StaticText.new(w, Rect(95, h+(n*6)-15, 80, 20))
.string_("delay time")
.font_(f);




// decayTime

decayTime = Slider.new(w, Rect(10, h+(n*7), l, 20))
.action_({
	arg view;
	randBleeps.set(\decay, view.value.linlin(0,1,0.1,100))
})
.value_(0.4);
StaticText.new(w, Rect(95, h+(n*7)-15, 80, 20))
.string_("decay time")
.font_(f);

)