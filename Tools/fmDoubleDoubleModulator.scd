// a fm synth with multiple modulators

/*
to do
1add in some text at least - fixed
2window closes noises stop and free up synths
3start volume at zero - fixed
4takeover
5 lfo speed start at zero - fixed
6 - turn power on green
*/

s.quit
s.boot


(

SynthDef.new(\fmModulator,{
	arg out=0,freq=0, mod1=0,mod2=0, pan=0.0,amp=0.0, gate=1;
	var src, mod, env;
	mod = SinOsc.kr(mod1.lag(0.1), 0.0, mod2.lag(0.2));
	env=EnvGen.kr(Env.asr(0.1,1,1),gate,doneAction:2);
	src = SinOsc.ar(freq.lag(0.1)+mod,0.0,0.2);


	Out.ar(out, Pan2.ar(src*env, pan, amp.lag(0.2)));

}).add;

//gui
// Window.closeAll;
w=Window.new(
	"fm double double modulator",
	Rect(
		Window.screenBounds.width/2-400,
		Window.screenBounds.height/2-150,
		300,
		300)
).front
.alwaysOnTop_(true)
.background_(Color.new255(200,200,0,255));




//sliders
//Volume
~fmDDvolume=Slider.new(w, Rect(20, 70, 50, 200))
.background_(Color.new255(100, 200, 20))
.action_({
	arg view;
	view.value.postln;
	~syn.set(\amp, view.value)
});
a=StaticText.new(w, Rect(24, 270, 50, 20));
a.string="volume";


//freq
~freqA=Slider.new(w,Rect(70, 70, 50, 200))
.background_(Color.new255(100,200,20))
.action_({
	arg view;
	view.value.postln;
	~syn.set(\freq, view.value.linexp(0,1,100,10000))

});
b=StaticText.new(w, Rect(80, 270, 50, 20));
b.string="freq";

~freqB=Knob.new(w, Rect(150, 110, 70, 70))
.background_(Color.new255(200,200,0,200))
.action_({
	arg view;
	view.value.postln;
	~syn.set(\mod1,view.value.linexp(0,1,0.1,500))
});
c=StaticText.new(w, Rect(230, 120, 60, 20));
c.string="speed";

~freqC=Knob.new(w, Rect(150, 200, 70, 70))
.background_(Color.new255(200,200,0,200))
.action_({
	arg view;
	view.value.postln;
	~syn.set(\mod2,view.value.linexp(0,1,0.1,1000))
});

d=StaticText.new(w, Rect(230, 210, 60, 20));
d.string="depth";






//buttons
~power=Button.new(w, Rect(220, 10, 50, 50))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
])
.action_({
	arg view;
	if(
		view.value == 1,
		{~syn = Synth.new(\fmModulator)},
		{~syn.set(\gate,0)}
	);
});





)


//run the test synth
~syn=Synth(\fmModulator)
~syn.set(\freq,400)
~syn.free
s.meter

~synt=Synth.new(\default)
~synt.free