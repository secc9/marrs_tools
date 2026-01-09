

// this is my MARRS nano controller thingy
// Author Ashley Sagar
// Date 24_10_30



/* so far the thinking is that I bought this dirt cheap Korg nano Kontrol for about £15
I'm gonna make a gui for it then add in some kind of synth

YThe thing has 9 channels of midi control
so.......
 - so far the ideas are as follows


channel 1 - 4
4 oscilators
with
volume control on the sliders
frequency on the pots

channel 5 - 8
4 modulators
with
speed on the sliders
depth on the pots

Channel 9 ??????????


* BUTTONS??????
toggle between different waveforms

    - maybe the top row are lfo waveform select

    - the bottom row are Osc select???


transport control buttons???????



think about the use of the scenes switch
 - each scene is a new machine
 - scene 1 is the already made 4 channel osc and 4 channel modulator // fm synth
 - scene 2 is wavetable synth else
 - scene 3 is a granular synth
 - scene 4 is maybe a sequencer??




 /////////////

/////// To Do


Add 3 more synthdefs
map the
amp
freq
lfo speed
lfo depth
to each slider


make a synthdef with a switchable oscillator
make a switchable lfo





*/

s.quit
s.meter
(
s.boot;

MIDIIn.connectAll;
MIDIFunc.trace(true);

)
(


var sldr1,sldr2,sldr3,sldr4,sldr5,sldr6,sldr7,sldr8,sldr9;
var knb1,knb2,knb3,knb4,knb5,knb6,knb7,knb8,knb9;
var topBtn1,topBtn2,topBtn3,topBtn4,topBtn5,topBtn6,topBtn7,topBtn8,topBtn9;
var lowBtn1,lowBtn2,lowBtn3,lowBtn4,lowBtn5,lowBtn6,lowBtn7,lowBtn8,lowBtn9;
var rwButt,playButt,ffButt,loopButt, stopButt, recButt, sceneButt;

var sliderWidth = 20;
var sliderHeight = 200;
var knobPosX = 180;
var knobPosY = 60;
var knobSize =60;
var chButtonSize = 40;
var chBtnPosX = 145;
var chBtnPosY = 170;
var xPos = 90;
var cfButtYpos=10;
var cfButtWidth = 60;
var cfButtHeight = 30;
var txtboxW = 200;
var txtboxH = 20;
var txtboxTY = 10;
var txtboxMY = 35;
var txtboxBY = 350;
var tbFreq = 170;
var tbVol =180;
var tbFX = 85;
var tbVX = 90;
var runSyn1,runSyn2,runSyn3,runSyn4;



////////////////////////////////////

SynthDef(\osc1, {
	|out=0, freq=400, amp = 0.0, gate=1, lfoSpeed=0.1, lfoDepth=0.1|

	var env, src, lfoSin;
	env = EnvGen.kr(Env.asr,gate, doneAction:2);
	lfoSin = SinOsc.kr(lfoSpeed, 0.0, lfoDepth);
	src = SinOsc.ar(freq.lag(0.2)+lfoSin, 0.0, 0.2);

	Out.ar(out, Pan2.ar(src*env,0.0, amp.lag(0.2)))
}).add;

SynthDef(\osc2, {
	|out=0, freq=400, amp = 0.0, gate=1, lfoSpeed=0.1, lfoDepth=0.1|

	var env, src, lfoSin;
	env = EnvGen.kr(Env.asr,gate, doneAction:2);
	lfoSin = SinOsc.kr(lfoSpeed, 0.0, lfoDepth);
	src = SinOsc.ar(freq.lag(0.2)+lfoSin, 0.0, 0.2);

	Out.ar(out, Pan2.ar(src*env,0.0, amp.lag(0.2)))
}).add;

SynthDef(\osc3, {
	|out=0, freq=400, amp = 0.0, gate=1, lfoSpeed=0.1, lfoDepth=0.1|

	var env, src, lfoSin;
	env = EnvGen.kr(Env.asr,gate, doneAction:2);
	lfoSin = SinOsc.kr(lfoSpeed, 0.0, lfoDepth);
	src = SinOsc.ar(freq.lag(0.2)+lfoSin, 0.0, 0.2);

	Out.ar(out, Pan2.ar(src*env,0.0, amp.lag(0.2)))
}).add;

SynthDef(\osc4, {
	|out=0, freq=400, amp = 0.0, gate=1, lfoSpeed=0.1, lfoDepth=0.1|

	var env, src, lfoSin;
	env = EnvGen.kr(Env.asr,gate, doneAction:2);
	lfoSin = SinOsc.kr(lfoSpeed, 0.0, lfoDepth);
	src = SinOsc.ar(freq.lag(0.2)+lfoSin, 0.0, 0.2);

	Out.ar(out, Pan2.ar(src*env,0.0, amp.lag(0.2)))
}).add;
//
// s.meter
// //
// a= Synth(\osc1)
// a.free


(
// w.close;
w=Window.new("MARRS_nanokontrol", Rect(330, 00, 1400, 400))
.background_(Color.black)
.front;
);


(
//run the synth
// run = Synth(\osc1);
);

(
//control function buttons
x = 10;
y = 40;

rwButt = Button.new(w, Rect(30-x, 200+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
]);



//PLAY BUTTON
playButt = Button.new(w, Rect(95-x, 200+cfButtYpos, cfButtWidth, cfButtHeight))
.action_({
	arg pwr;
	if(
		pwr.value == 1,
		{runSyn1 = Synth(\osc1)},
		{runSyn1.set(\gate,0)}
	);
	if(
		pwr.value == 1,
		{runSyn2 = Synth(\osc2)},
		{runSyn2.set(\gate,0)}
	);
	if(
		pwr.value == 1,
		{runSyn3 = Synth(\osc3)},
		{runSyn3.set(\gate,0)}
	);
	if(
		pwr.value == 1,
		{runSyn4 = Synth(\osc4)},
		{runSyn4.set(\gate,0)}
	);
})
.states_([
	["poweroff", Color.black, Color.red],
	["poweron", Color.black, Color.green];
]);

MIDIdef.cc(\playButton,{
	arg val, num, chan;
	{playButt.valueAction_(val/127)}.defer
},45, 1);




ffButt = Button.new(w, Rect(160-x, 200+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
]);
loopButt = Button.new(w, Rect(30-x, 200+y+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
]);
stopButt = Button.new(w, Rect(95-x, 200+y+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
]);
recButt = Button.new(w, Rect(160-x, 200+y+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
]);

sceneButt = Button.new(w, Rect(30-x, 200+(y*2)+cfButtYpos, cfButtWidth, cfButtHeight))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green];
						]);
);



(
(
//channel 1
topBtn1 = Button.new(w, Rect(chBtnPosX+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn1 = Button.new(w, Rect(chBtnPosX+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr1= Slider.new(w, Rect(200+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr1;
	sldr1.value.postln;
	runSyn1.set(\amp, sldr1.value);
});
knb1 = Knob.new(w, Rect(knobPosX+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb1;
	knb1.value.postln;
	runSyn1.set(\freq, knb1.value.linexp(0,1, 50, 10000));
});
);


(
x = 130;
//channel 2
topBtn2 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn2 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr2= Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr1;
	sldr1.value.postln;
	runSyn2.set(\amp, sldr2.value);
});
knb2 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb1;
	knb1.value.postln;
	runSyn2.set(\freq, knb2.value.linexp(0,1, 50, 10000));
});
);

(
x = 130*2;
//channel 3
topBtn3 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn3 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr3= Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr3;
	sldr3.value.postln;
	runSyn3.set(\amp, sldr3.value);
});
knb3 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb3;
	knb3.value.postln;
	runSyn3.set(\freq, knb3.value.linexp(0,1, 50, 10000));
});
);

(
x = 130*3;
//channel 4
topBtn4 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn4 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr4= Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr4;
	sldr4.value.postln;
	runSyn4.set(\amp, sldr4.value);
});
knb4 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb4;
	knb4.value.postln;
	runSyn4.set(\freq, knb4.value.linexp(0,1, 50, 10000));
});
);

(
x = 130*4;
//channel 5
topBtn5 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn5 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr5 = Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr5;
	sldr5.value.postln;
	runSyn1.set(\lfoSpeed, sldr5.value.linexp(0,1,0.1,300));
});
knb5 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb5;
	knb5.value.postln;
	runSyn1.set(\lfoDepth, knb5.value.linexp(0,1,0.1,2000));
});
);

(
x = 130*5;
//channel 6
topBtn6 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn6 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr6 = Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr5;
	sldr5.value.postln;
	runSyn2.set(\lfoSpeed, sldr6.value.linexp(0,1,0.1,300));
});
knb6 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb5;
	knb5.value.postln;
	runSyn2.set(\lfoDepth, knb6.value.linexp(0,1,0.1,2000));
});
);

(
x = 130*6;
//channel 7
topBtn7 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn7 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr7 = Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr7;
	sldr7.value.postln;
	runSyn3.set(\lfoSpeed, sldr7.value.linexp(0,1,0.1,300));
});
knb7 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb7;
	knb7.value.postln;
	runSyn3.set(\lfoDepth, knb7.value.linexp(0,1,0.1,2000));
});
);


(
x = 130*7;
//channel 8
topBtn8 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn8 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr8 = Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight))
.action_({
	arg sldr8;
	sldr8.value.postln;
	runSyn4.set(\lfoSpeed, sldr8.value.linexp(0,1,0.1,300));
});
knb8 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize))
.action_({
	arg knb8;
	knb8.value.postln;
	runSyn4.set(\lfoDepth, knb8.value.linexp(0,1,0.1,2000));
});
);

(
x = 130*8;
//channel 9
topBtn9 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
lowBtn9 = Button.new(w, Rect(chBtnPosX+x+xPos, chBtnPosY+110, chButtonSize,chButtonSize))
.states_([
	["off", Color.black, Color.red],
	["on", Color.black, Color.green]
]);
sldr9 = Slider.new(w, Rect(200+x+xPos, 150, sliderWidth, sliderHeight));
knb9 = Knob.new(w, Rect(knobPosX+x+xPos, knobPosY, knobSize, knobSize));
);

);

(
//simple labels

//channel numbers

StaticText.new(w, Rect(290, txtboxMY+90, 20, 20))
.string_("1")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+130, txtboxMY+90, 20, 20))
.string_("2")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*2), txtboxMY+90, 20, 20))
.string_("3")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*3), txtboxMY+90, 20, 20))
.string_("4")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*4), txtboxMY+90, 20, 20))
.string_("5")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*5), txtboxMY+90, 20, 20))
.string_("6")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*6), txtboxMY+90, 20, 20))
.string_("7")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*7), txtboxMY+90, 20, 20))
.string_("8")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);

StaticText.new(w, Rect(290+(130*8), txtboxMY+90, 20, 20))
.string_("9")
.align_(\center)
.background_(Color.white)
.font_("Monaco", 4);





//OSC Section
//osc1
StaticText.new(w, Rect(200, txtboxTY, txtboxW, txtboxH))
.string_("Oscillator 1")
.align_(\center)
.stringColor_(Color.yellow);
//osc1 freq
StaticText.new(w, Rect(285, txtboxMY, txtboxW-tbFreq, txtboxH))
.string_("Freq")
.align_(\center)
.stringColor_(Color.yellow);
//osc1 vol
StaticText.new(w, Rect(290, txtboxBY, txtboxW-tbVol, txtboxH))
.string_("Vol")
.align_(\center)
.stringColor_(Color.yellow);


//osc2
StaticText.new(w, Rect(330, txtboxTY, txtboxW, txtboxH))
.string_("Oscillator 2")
.align_(\center)
.stringColor_(Color.yellow);
//osc2 freq
StaticText.new(w, Rect(330+tbFX, txtboxMY, txtboxW-tbFreq, txtboxH))
.string_("Freq")
.align_(\center)
.stringColor_(Color.yellow);
//osc2 vol
StaticText.new(w, Rect(330+tbVX, txtboxBY, txtboxW-tbVol, txtboxH))
.string_("Vol")
.align_(\center)
.stringColor_(Color.yellow);


//osc3
StaticText.new(w, Rect(460, txtboxTY, txtboxW, txtboxH))
.string_("Oscillator 3")
.align_(\center)
.stringColor_(Color.yellow);
//osc3 freq
StaticText.new(w, Rect(460+tbFX, txtboxMY, txtboxW-tbFreq, txtboxH))
.string_("Freq")
.align_(\center)
.stringColor_(Color.yellow);
//osc3 vol
StaticText.new(w, Rect(460+tbVX, txtboxBY, txtboxW-tbVol, txtboxH))
.string_("Vol")
.align_(\center)
.stringColor_(Color.yellow);


//osc4
StaticText.new(w, Rect(590, txtboxTY, txtboxW, txtboxH))
.string_("Oscillator 4")
.align_(\center)
.stringColor_(Color.yellow);
//osc4 freq
StaticText.new(w, Rect(590+tbFX, txtboxMY, txtboxW-tbFreq, txtboxH))
.string_("Freq")
.align_(\center)
.stringColor_(Color.yellow);
//osc4 vol
StaticText.new(w, Rect(590+tbVX, txtboxBY, txtboxW-tbVol, txtboxH))
.string_("Vol")
.align_(\center)
.stringColor_(Color.yellow);


// Modulation Section

// Mod1
StaticText.new(w, Rect(720, txtboxTY, txtboxW, txtboxH))
.string_("Modulator 1")
.align_(\center)
.stringColor_(Color.yellow);
//Mod1 Depth
StaticText.new(w, Rect(720, txtboxMY, txtboxW, txtboxH))
.string_("Depth")
.align_(\center)
.stringColor_(Color.yellow);
//Mod1 Speed
StaticText.new(w, Rect(720, txtboxBY, txtboxW, txtboxH))
.string_("Speed")
.align_(\center)
.stringColor_(Color.yellow);

// Mod2
StaticText.new(w, Rect(720+130, txtboxTY, txtboxW, txtboxH))
.string_("Modulator 2")
.align_(\center)
.stringColor_(Color.yellow);
//Mod2 Depth
StaticText.new(w, Rect(720+130, txtboxMY, txtboxW, txtboxH))
.string_("Depth")
.align_(\center)
.stringColor_(Color.yellow);
//Mod2 Speed
StaticText.new(w, Rect(720+130, txtboxBY, txtboxW, txtboxH))
.string_("Speed")
.align_(\center)
.stringColor_(Color.yellow);


// Mod3
StaticText.new(w, Rect(720+(130*2), txtboxTY, txtboxW, txtboxH))
.string_("Modulator 3")
.align_(\center)
.stringColor_(Color.yellow);
//Mod3 Depth
StaticText.new(w, Rect(720+(130*2), txtboxMY, txtboxW, txtboxH))
.string_("Depth")
.align_(\center)
.stringColor_(Color.yellow);
//Mod3 Speed
StaticText.new(w, Rect(720+(130*2), txtboxBY, txtboxW, txtboxH))
.string_("Speed")
.align_(\center)
.stringColor_(Color.yellow);

// Mod4
StaticText.new(w, Rect(720+(130*3), txtboxTY, txtboxW, txtboxH))
.string_("Modulator 4")
.align_(\center)
.stringColor_(Color.yellow);
//Mod3 Depth
StaticText.new(w, Rect(720+(130*3), txtboxMY, txtboxW, txtboxH))
.string_("Depth")
.align_(\center)
.stringColor_(Color.yellow);
//Mod3 Speed
StaticText.new(w, Rect(720+(130*3), txtboxBY, txtboxW, txtboxH))
.string_("Speed")
.align_(\center)
.stringColor_(Color.yellow);

);

(
// slider controls

MIDIdef.cc(\ch1Slider, {
	arg val, num, chan;
	{sldr1.valueAction_(val/127)}.defer
},2,1);


MIDIdef.cc(\ch2Slider, {
	arg val, num, chan;
	{sldr2.valueAction_(val/127)}.defer
},3,1);


MIDIdef.cc(\ch3Slider, {
	arg val, num, chan;
	{sldr3.valueAction_(val/127)}.defer
},4,1);



MIDIdef.cc(\ch4Slider, {
	arg val, num, chan;
	{sldr4.valueAction_(val/127)}.defer
},5,1);

MIDIdef.cc(\ch5Slider, {
	arg val, num, chan;
	{sldr5.valueAction_(val/127)}.defer
},6,1);

MIDIdef.cc(\ch6Slider, {
	arg val, num, chan;
	{sldr6.valueAction_(val/127)}.defer
},8,1);


MIDIdef.cc(\ch7Slider, {
	arg val, num, chan;
	{sldr7.valueAction_(val/127)}.defer
},9,1);

MIDIdef.cc(\ch8Slider, {
	arg val, num, chan;
	{sldr8.valueAction_(val/127)}.defer
},12,1);

MIDIdef.cc(\ch9Slider, {
	arg val, num, chan;
	{sldr9.valueAction_(val/127)}.defer
},13,1);

);


(
// Knob Controls

MIDIdef.cc(\ch1Knob, {
	arg val, num, chan;
	{knb1.valueAction_(val/127)}.defer
	}, 14,1);


MIDIdef.cc(\ch2Knob, {
	arg val, num, chan;
	{knb2.valueAction_(val/127)}.defer
	}, 15,1);


MIDIdef.cc(\ch3Knob, {
	arg val, num, chan;
	{knb3.valueAction_(val/127)}.defer
	}, 16,1);

MIDIdef.cc(\ch4Knob, {
	arg val, num, chan;
	{knb4.valueAction_(val/127)}.defer
	}, 17,1);

MIDIdef.cc(\ch5Knob, {
	arg val, num, chan;
	{knb5.valueAction_(val/127)}.defer
	}, 18,1);

MIDIdef.cc(\ch6Knob, {
	arg val, num, chan;
	{knb6.valueAction_(val/127)}.defer
	}, 19,1);

MIDIdef.cc(\ch7Knob, {
	arg val, num, chan;
	{knb7.valueAction_(val/127)}.defer
	}, 20,1);

MIDIdef.cc(\ch8Knob, {
	arg val, num, chan;
	{knb8.valueAction_(val/127)}.defer
	}, 21,1);


MIDIdef.cc(\ch9Knob, {
	arg val, num, chan;
	{knb9.valueAction_(val/127)}.defer
	}, 22,1);

);

(
//top row buttons -- Momentary switches
MIDIdef.cc(\ch1TopButton, {
	arg val, num, chan;
	{topBtn1.value_(val/127)}.defer
}, 23, 1);

MIDIdef.cc(\ch2TopButton, {
	arg val, num, chan;
	{topBtn2.value_(val/127)}.defer
}, 24, 1);

MIDIdef.cc(\ch3TopButton, {
	arg val, num, chan;
	{topBtn3.value_(val/127)}.defer
}, 25, 1);

MIDIdef.cc(\ch4TopButton, {
	arg val, num, chan;
	{topBtn4.value_(val/127)}.defer
}, 26, 1);

MIDIdef.cc(\ch5TopButton, {
	arg val, num, chan;
	{topBtn5.value_(val/127)}.defer
}, 27, 1);

MIDIdef.cc(\ch6TopButton, {
	arg val, num, chan;
	{topBtn6.value_(val/127)}.defer
}, 28, 1);

MIDIdef.cc(\ch7TopButton, {
	arg val, num, chan;
	{topBtn7.value_(val/127)}.defer
}, 29, 1);

MIDIdef.cc(\ch8TopButton, {
	arg val, num, chan;
	{topBtn8.value_(val/127)}.defer
}, 30, 1);

MIDIdef.cc(\ch9TopButton, {
	arg val, num, chan;
	{topBtn9.value_(val/127)}.defer
}, 31, 1);



//bottom row buttons -- Momentary switches
MIDIdef.cc(\ch1LowButton, {
	arg val, num, chan;
	{lowBtn1.value_(val/127)}.defer
}, 33, 1);

MIDIdef.cc(\ch2LowButton, {
	arg val, num, chan;
	{lowBtn2.value_(val/127)}.defer
}, 34, 1);

MIDIdef.cc(\ch3LowButton, {
	arg val, num, chan;
	{lowBtn3.value_(val/127)}.defer
}, 35, 1);

MIDIdef.cc(\ch4LowButton, {
	arg val, num, chan;
	{lowBtn4.value_(val/127)}.defer
}, 36, 1);

MIDIdef.cc(\ch5LowButton, {
	arg val, num, chan;
	{lowBtn5.value_(val/127)}.defer
}, 37, 1);

MIDIdef.cc(\ch6LowButton, {
	arg val, num, chan;
	{lowBtn6.value_(val/127)}.defer
}, 38, 1);

MIDIdef.cc(\ch7LowButton, {
	arg val, num, chan;
	{lowBtn7.value_(val/127)}.defer
}, 39, 1);

MIDIdef.cc(\ch8LowButton, {
	arg val, num, chan;
	{lowBtn8.value_(val/127)}.defer
}, 40, 1);

MIDIdef.cc(\ch9LowButton, {
	arg val, num, chan;
	{lowBtn9.value_(val/127)}.defer
}, 41, 1);

);



(
// rwButt,playButt,ffButt,loopButt, stopButt, recButtt, sceneButt;
// transport buttons
MIDIdef.cc(\rwButton,{
	arg val, num, chan;
	{rwButt.value_(val/127)}.defer
},47, 1);



MIDIdef.cc(\ffButton,{
	arg val, num, chan;
	{ffButt.value_(val/127)}.defer
},48, 1);

MIDIdef.cc(\loopButton,{
	arg val, num, chan;
	{loopButt.value_(val/127)}.defer
},49, 1);

MIDIdef.cc(\stopButton,{
	arg val, num, chan;
	{stopButt.value_(val/127)}.defer
},46, 1);

MIDIdef.cc(\recButton,{
	arg val, num, chan;
	{recButt.value_(val/127)}.defer
},44, 1);




)



);


