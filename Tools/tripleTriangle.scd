
//Author
// Ashley Sagar
// date 24_10_27
//TRIPLETRIANGLE
/*
TODO
1- fix the panning gui - fixed
2 - add in some labelling
3 - the pannings setting seems out?

*/

s.quit;
(
s.boot;
s.meter;
s.scope;
)
(

var fknob1,fknob2,fknob3, slider1, slider2, slider3,pknob1,pknob2,pknob3,button1,button2,button3;
var size = 100;

// Window.closeAll;
~group1 = Group.new;
~group2 = Group.new;
~group3 = Group.new;
// Window.closeAll;
w=Window.new("TripleTriangle", Rect(800,0,400,400))
.front
.alwaysOnTop_(true)
.background_(Color.cyan);



//Synths


SynthDef(\tri1,{
	arg out=0, t1freq=400, t1pan=0.0,t1vol=0.0,gate=1;
	var src, env;
	t1freq =t1freq.lag(0.1);
	t1pan=t1pan.lag(0.1);
	t1vol = t1vol.lag(0.1);
	env = EnvGen.kr(Env.asr,gate,doneAction:2);
	src = LFTri.ar(t1freq, 0.0, 0.5);
	Out.ar(out, Pan2.ar(src*env,t1pan, t1vol));
}).add;

SynthDef(\tri2,{
	arg out=0, t2freq=500, t2pan=0.0,t2vol=0.0,gate=1;
	var src, env;
	t2freq = t2freq.lag(0.1);
	t2pan = t2pan.lag(0.1);
	t2vol = t2vol.lag(0.1);
	env = EnvGen.kr(Env.asr,gate,doneAction:2);
	src = LFTri.ar(t2freq, 0.0, 0.5);
	Out.ar(out, Pan2.ar(src*env,t2pan, t2vol));
}).add;

SynthDef(\tri3,{
	arg out=0, t3freq=600, t3pan=0.0,t3vol=0.0,gate=1;
	var src, env;
	t3freq = t3freq.lag(0.1);
	t3pan = t3pan.lag(0.1);
	t3vol = t3vol.lag(0.1);
	env = EnvGen.kr(Env.asr,gate,doneAction:2);
	src = LFTri.ar(t3freq, 0.0, 0.5);
	Out.ar(out, Pan2.ar(src*env,t3pan, t3vol));
}).add;


// Synth(\tri1, [\gate,1, \vol, 0.4])


//GUI
(
x=120;
y=20;





// Frequency Knobs
fknob1=Knob.new(w, Rect(30, y, size, size))
// .color_(Color.yellow)
.background_(Color.new255(200, 0, 200))
.action_({
	arg view;
	// view.value.postln;
	~group1.set(\t1freq, view.value.linexp(0,1,50,2000));
})
.canFocus_(false);


fknob2=Knob.new(w, Rect(30+(x), y, size, size))
.background_(Color.new255(200, 0, 200))
.action_({
	arg view;
	// view.value.postln;
	~group2.set(\t2freq,view.value.linexp(0,1,50,2000));
})
.canFocus_(false);


fknob3=Knob.new(w, Rect(30+(x*2), y, size, size))
.background_(Color.new255(200, 0, 200))
.action_({
	arg view;
	// view.value.postln;

	~group3.set(\t3freq, view.value.linexp(0,1,50,2000));

})
.canFocus_(false);


//Volume Sliders
slider1 = Slider.new(w, Rect(55, 200, size*0.5,size*1))
.background_(Color.blue)
.action_({
	arg view;
	// view.value.postln;
	~group1.set(\t1vol, view.value);

})
.canFocus_(false);


slider2 = Slider.new(w, Rect(55+(x), 200, size*0.5,size*1))
.background_(Color.blue)
.action_({
	arg view;
	// view.value.postln;
	~group2.set(\t2vol, view.value);
})
.canFocus_(false);


slider3 = Slider.new(w, Rect(55+(x*2), 200, size*0.5,size*1))
.background_(Color.blue)
.action_({
	arg view;
	// view.value.postln;
	~group3.set(\t3vol, view.value);
})
.canFocus_(false);



//Pan knobs

pknob1=Knob(w, Rect(60, 310, 40, 40))
.background_(Color.yellow)
.centered_(true)
.action_({
	arg view;
	// view = 0.0;
	~group1.set(\t1pan, view.value.linlin(0,1,-1,1));
})
.value_(0.499);



pknob2=Knob(w, Rect(60+(x), 310, 40, 40))
.background_(Color.yellow)
.centered_(true)
.action_({
	arg view;
	~group2.set(\t2pan, view.value.linlin(0,1,-1,1));
})
.value_(0.5);

pknob3=Knob(w, Rect(60+(x*2), 310, 40, 40))
.background_(Color.yellow)
.centered_(true)
.action_({
	arg view;
	~group3.set(\t3pan, view.value.linlin(0,1,-1,1));
})
.value_(0.5);

//Power Buttons
(
button1=Button(w, Rect(55, 130, size*0.5, size*0.5))
.states_([
	["On", Color.black, Color.red],
	["Off", Color.blue, Color.green]
])
.font_(Font.new("Monaco", 24))
.action_({
	arg obj;
	obj.value.postln;
	if(
		obj.value == 1,
		{Synth(\tri1,
			[
				\t1freq, fknob1.value.linexp(0,1,50,2000),
				\t1vol,slider1.value.linexp(0,1,0,1),
				\t1pan,pknob1.value;
			], ~group1).register;
		},
		{~group1.set(\gate,0)}
	)
})
.canFocus_(false);
);

(
button2=Button(w, Rect(55+(x), 130, size*0.5, size*0.5))
.states_([
	["On", Color.black, Color.red],
	["Off", Color.blue, Color.green]
])
.font_(Font.new("Monaco", 24))
.action_({
	arg obj;
	obj.value.postln;
	if(
		obj.value ==1,
		{Synth(\tri2,
			[
				\t2freq, fknob2.value.linexp(0,1,50,2000),
				\t2vol,slider2.value.linexp(0,1,0,1),
				\t2pan,pknob2.value;
			], ~group2).register;
		},
		{~group2.set(\gate,0)}
	)
})
.canFocus_(false);
);

(
button3=Button(w, Rect(55+(x*2), 130, size*0.5, size*0.5))
.states_([
	["On", Color.black, Color.red],
	["Off", Color.blue, Color.green]
])
.font_(Font.new("Monaco", 24))
.action_({
	arg obj;
	obj.value.postln;
	if(
		obj.value ==1,
		{Synth(\tri3,
			[
				\t3freq, fknob3.value.linexp(0,1,50,2000),
				\t3vol, slider3.value.linexp(0,1,0,1),
				\t3pan, pknob3.value;
			], ~group3).register;
		},
		{~group3.set(\gate,0)}
	)
})
.canFocus_(false);
);


);




)

