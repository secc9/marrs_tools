// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S
// June 2025
// Rising Bubbles
// Code taken from the Cottle Book


/*
what do I want to do??

I want to take the rising bubbles code and
make a gui for it and turn it into a performance tool


How?

Port the cottle code into a synthdef - done
make a gui
1 - make a window - done
2 - add a power button - done
3 - add controllers for the modulatoable params
    3.1 - amplitude - done
    3.2 - panner - no pan needed as theres a 2 channel array
    3.3 - nFreq - done
    3.4 - nRange - done
    3.5 - sawFreq A - done
    3.6 - Saw Frewq B - done
    3.7 - saw range - done
    3.8 - saw offset - done
    3.9 - delay -
    3.10- decay



I already have the code
Why?
For a performance tool to use




*/


(
//server options
Server.default.options.inDevice_("UltraLite-mk5");
Server.default.options.outDevice_("UltraLite-mk5");
s.options.numInputBusChannels=8; //set inputs to 8
s.options.numOutputBusChannels=8; //set outputs to 8
);

(
//start server and show windows
s.boot;
s.meter;
);



(

var bubble, power, vol, noiseFreq, noiseRange, sawFreqA, sawFreqB, sawRange, sawOffset, delay, decay;
(
SynthDef(\risingBubbles, {
	arg out=0, nFreq=4, nRange=24, sFreqA=8.0, sFreqB=7.23, sRange=3,sOffset=80, maxDelay = 0.2, delay=4, decay=4, gate=1,amp=0;

	var sigA, sigB, noise, delayFx, env;
	env = EnvGen.kr(Env.asr(1, 1, 1), gate, doneAction:2);
	sigA = LFSaw.ar([sFreqA, sFreqB], 0, sRange, sOffset);
	noise = LFNoise1.kr(nFreq.lag(0.01), nRange.lag(0.01), sigA).midicps;
	sigB = SinOsc.ar(noise, 0, 0.04);
	delayFx = CombN.ar(sigB, 1, delay, decay);

	Out.ar(out, Pan2.ar(delayFx*env, 0.0, amp.lag(0.04)))
}).add;
);


// a = Synth(\risingBubbles)
// a.set(\amp, 0.4)
// a.free








(
w=Window.new("Rising Bubbles", Rect(10, 700, 190, 150))
.front
.background_(Color.new255(154, 40, 190))
.alwaysOnTop_(true);
);


// power

power = Button.new(w, Rect(10, 10, 30, 20))
.action_({
	arg view;
	if(
		view.value == 1,
		{bubble=Synth(\risingBubbles)},
		{bubble.set(\gate, 0)}
	)
})
.states_([
	["ON", Color.black, Color.red],
	["OFF", Color.black, Color.green]
]);



// parameters

// volume

vol= Slider.new(w, Rect(10, 40, 120, 10))
.action_({
	arg view;
	bubble.set(\amp, view.value.linlin(0, 1, 0, 3))
});
StaticText.new(w, Rect(130, 35, 50, 20))
.font_("Monaco")
.string_("volume");



//noise frequency
noiseFreq= Slider.new(w, Rect(10, 55, 120, 10))
.action_({
	arg view;
	bubble.set(\nFreq, view.value.linlin(0, 1, 0.1, 100))
})
.value_(0.4);
StaticText.new(w, Rect(130, 45, 70, 30))
.font_("Monaco")
.string_("noiseF");


// noiseRange
noiseFreq= Slider.new(w, Rect(10, 70, 120, 10))
.action_({
	arg view;
	bubble.set(\nRange, view.value.linlin(0, 1, 0.1, 100))
})
.value_(0.4);
StaticText.new(w, Rect(130, 60, 70, 30))
.font_("Monaco")
.string_("noiseR");


// sawFreqA

sawFreqA = Slider.new(w, Rect(10, 85, 120, 10))
.action_({
	arg view;
	bubble.set(\sFreqA, view.value.linlin(0, 1, 0.0125, 10))
})
.value_(0.4);
StaticText.new(w, Rect(130, 75, 70, 30))
.font_("Monaco")
.string_("sawF_A");



//sawFreqB

sawFreqB = Slider.new(w, Rect(10, 100, 120, 10))
.action_({
	arg view;
	bubble.set(\sFreqB, view.value.linlin(0, 1, 0.0125, 10))
})
.value_(0.4);
StaticText.new(w, Rect(130, 90, 70, 30))
.font_("Monaco")
.string_("sawF_B");



// sawRange

sawRange = Slider.new(w, Rect(10, 115, 120, 10))
.action_({
	arg view;
	bubble.set(\sRange, view.value.linlin(0, 1, 0.0125, 10))
})
.value_(0.4);
StaticText.new(w, Rect(130, 105, 70, 30))
.font_("Monaco")
.string_("sawRange");






// sawOffset
sawRange = Slider.new(w, Rect(10, 130, 120, 10))
.action_({
	arg view;
	bubble.set(\sOffset, view.value.linlin(0, 1, 50, 150))
})
.value_(0.4);
StaticText.new(w, Rect(130, 120, 70, 30))
.font_("Monaco")
.string_("sawOffset");



// delay
delay = Slider.new(w, Rect(45, 10, 100, 10))
.action_({
	arg view;
	bubble.set(\delay, view.value.linlin(0, 1, 0.1, 4))
})
.value_(0.4);
StaticText.new(w, Rect(145, 0, 70, 30))
.font_("Monaco")
.string_("delay");


// decay

decay = Slider.new(w, Rect(45, 20, 100, 10))
.action_({
	arg view;
	bubble.set(\decay, view.value.linlin(0, 1, 0, 100))
})
.value_(0.4);
StaticText.new(w, Rect(145, 10, 70, 30))
.font_("Monaco")
.string_("decay");



)
