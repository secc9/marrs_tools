
// a stereo 40 Hz tone to 'help' with focus



s.boot;
s.meter;

(

var power, width=300, height=300, study, volume, detune, kSize;
SynthDef(\studyTone, {
	arg out= 0, freqA=40, freqB=0, gate=1, vol=0.0;
	var src1,mod, env;
	env = EnvGen.kr(Env.asr(1,1,1,1), gate, doneAction:2);
	mod = SinOsc.kr(1, 0.0, freqB,0);
	src1 = SinOsc.ar(freqA+mod, 0, 0.3);
	Out.ar(out, Pan2.ar(src1*env, 0, vol));
}).add;


/*
a=Synth(\studyTone)
a.set(\gate, 1, \vol, 0.35)
a.set(\freqB, 40.5)
a.set(\vol, 0.35)
a.set(\gate, 0)
a.free
*/

//gui
w = Window("StudyTone", Rect(0, 100, width, height))
.front
.alwaysOnTop_(true)
.background_(Color(0.0, 0.9, 0.3, 0.6));


power = Button.new(w, Rect(10, 10, width-20, height-200))
.states_([
	["Study!", Color.white, Color.blue],
	["Chill!", Color.white, Color(0.0, 0.9, 0.3, 0.2)]
])
.action_({
	arg view;
	if(
		view.value == 1,
		{study = Synth.new(\studyTone)},
		{study.set(\gate, 0)}
	)
})
.font_("Adelle Sans Devanagari", 30);


kSize = 130;

volume = Knob.new(w, Rect(10, height-130, kSize, kSize))
.action_({
	arg view;
	study.set(\vol, view.value.linlin(0, 1, 0.0, 1))
});
StaticText.new(w, Rect(50, height-180, 60, 60))
.string_("Volume")
.font_("Adelle Sans Devanagari", 60);

detune = Knob.new(w, Rect(width-140, height-130, kSize, kSize))
.action_({
	arg view;
	study.set(\freqB, view.value.linlin(0,1, 0.0, 5))
});

)

// Font.availableFonts