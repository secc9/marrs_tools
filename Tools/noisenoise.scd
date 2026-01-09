
// Title - noise machine
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S



s.boot
s.quit
s.meter
(

// noise machine

/*

Things to do
get rid of all the ~ variables and replace with hard coded

Maybe add in some volume lfo's on the noise muls.
a single one on each and a master one??

Always on Top

*/

//---------------------------------------------
// variables
//---------------------------------------------

var
wnLfoSpeed,
wnLfoDepth,
pnLfoSpeed,
pnLfoDepth,
bnLfoSpeed,
bnLfoDepth,
gnLfoSpeed,
gnLfoDepth,
cnLfoSpeed,
cnLfoDepth,
volumeLfoSpeeds = 2,
wnVol;


//---------------------------------------------
// The synthDef
//---------------------------------------------


(
SynthDef(\noise,{
	//arguments
	arg out=0,
	pan=0.0,
	vol=1.0,
	wVol=0.0,
	pVol=0.0,
	bVol=0.0,
	gVol=0.0,
	cVol=0.0,
	fc=1000,
	g=0,
	lfoSpeed=1,
	lfoDepth=100,
	wnLfoSpeed = 0.1,
	wnLfoDepth = 0.1,
	pnLfoSpeed = 0.1,
	pnLfoDepth = 0.1,
	bnLfoSpeed = 0.1,
	bnLfoDepth = 0.1,
	gnLfoSpeed = 0.1,
	gnLfoDepth = 0.1,
	cnLfoSpeed = 0.1,
	cnLfoDepth = 0.1,
	gate=1;


	//Variable
	var wht, pnk,brn,gry,clp,filt, filtlfo, env,wnLfo,pnLfo,bnLfo,gnLfo,cnLfo;

	// envelope
	env = EnvGen.kr(Env.asr,gate,doneAction:2);

	// LFO
	wnLfo = SinOsc.kr(wnLfoSpeed, 0.0, wnLfoDepth);
	pnLfo = SinOsc.kr(pnLfoSpeed, 0.0, pnLfoDepth);
	bnLfo = SinOsc.kr(bnLfoSpeed, 0.0, bnLfoDepth);
	gnLfo = SinOsc.kr(gnLfoSpeed, 0.0, gnLfoDepth);
	cnLfo = SinOsc.kr(cnLfoSpeed, 0.0, cnLfoDepth);
	filtlfo = SinOsc.kr(lfoSpeed, 0.0, lfoDepth);

	// Generators
	wht = WhiteNoise.ar(wVol.lag(0.1)*wnLfo);
	pnk = PinkNoise.ar(pVol.lag(0.1)*pnLfo);
	brn = BrownNoise.ar(bVol.lag(0.1)*bnLfo);
	gry = GrayNoise.ar(gVol.lag(0.1)*gnLfo);
	clp = ClipNoise.ar(cVol.lag(0.1)*cnLfo);
	filt = MoogFF.ar(wht+pnk+brn+gry+clp,fc.lag(0.1)+filtlfo,g.lag(0.1));



	Out.ar(out,Pan2.ar(filt*env, pan,vol.lag(0.1)));
}).add;
);


(
//---------------------------------------------
//---------------------------------------------
// build the gui
//---------------------------------------------
//---------------------------------------------


// Window.closeAll;
// s.meter;
w=Window.new("NoiseNoise",Rect(600,0,400,400),false).front
.background_(Color.new255(250,250,0))
.alwaysOnTop_(true);


//---------------------------------------------
//---------------------------------------------
// White noise
//---------------------------------------------
//---------------------------------------------
wnVol=Slider.new(w,Rect(20, 20, 200, 40))
/*.background_(Color.new255(200,0,200))*/
.knobColor_(Color.new255(200, 0, 200))
.action_({
	arg wnVol;
	wnVol.value.postln;
	wnVol.background_(Color.new(wnVol.value, 0,wnVol.value));
	~noise.set(\wVol, wnVol.value);

})
.value_(0);
StaticText.new(w, Rect(50, 65, 200, 15))
.font_(Font.new("Monaco", 15))
.string_("White Noise Volume");



//---------------------------------------------
// white noise lfo speed
//---------------------------------------------
wnLfoSpeed = Knob.new(w, Rect(220, 15, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\wnLfoSpeed, view.value.linlin(0,1,0.01, volumeLfoSpeeds));
})
.value_(0.0);
StaticText.new(w, Rect(225, 40, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo speed");




//---------------------------------------------
// white noise lfo depth
//---------------------------------------------
wnLfoDepth = Knob.new(w, Rect(255, 15, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\wnLfoDepth, view.value.linlin(0,1,0.01, 1));
})
.value_(0.0);
StaticText.new(w, Rect(260, 40, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo depth");





//---------------------------------------------
//---------------------------------------------
// Pink noise
//---------------------------------------------
//---------------------------------------------

~pnVol=Slider.new(w,Rect(20, 90, 200, 40))
/*.background_(Color.new255(200,0,200))*/
.knobColor_(Color.new255(200, 0, 200))
.action_({
	arg pnVol;
	pnVol.value.postln;
	~pnVol.background_(Color.new(pnVol.value, 0,pnVol.value));
	~noise.set(\pVol, ~pnVol.value);

})
.value_(0);
StaticText.new(w, Rect(50, 135, 200, 15))
.font_(Font.new("Monaco", 15))
.string_("Pink Noise Volume");




//---------------------------------------------
// pink noise lfo speed
//---------------------------------------------

pnLfoSpeed = Knob.new(w, Rect(220, 85, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\pnLfoSpeed, view.value.linlin(0,1,0.0001, volumeLfoSpeeds));
})
.value_(0.0);

StaticText.new(w, Rect(225, 110, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo speed");
//---------------------------------------------
// pink noise lfo depth
//---------------------------------------------

pnLfoDepth = Knob.new(w, Rect(255, 85, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\pnLfoDepth, view.value.linlin(0,1,0.01, 1 ));
})
.value_(0.0);
StaticText.new(w, Rect(260, 110, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo depth");


//---------------------------------------------
//---------------------------------------------
// Brown noise
//---------------------------------------------
//---------------------------------------------

~bnVol=Slider.new(w,Rect(20, 160, 200, 40))
/*.background_(Color.new255(200,0,200))*/
.knobColor_(Color.new255(200, 0, 200))
.action_({
	arg bnVol;
	bnVol.value.postln;
	~bnVol.background_(Color.new(bnVol.value, 0, bnVol.value));
	~noise.set(\bVol, ~bnVol.value);

})
.value_(0);
StaticText.new(w, Rect(50, 205, 200, 15))
.font_(Font.new("Monaco", 15))
.string_("Brown Noise Volume");




//---------------------------------------------
// brown noise lfo speed
//---------------------------------------------

bnLfoSpeed = Knob.new(w, Rect(220, 155, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\bnLfoSpeed, view.value.linlin(0,1,0, volumeLfoSpeeds));
})
.value_(0.0);

StaticText.new(w, Rect(225, 180, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo speed");



//---------------------------------------------
// brown noise lfo depth
//---------------------------------------------

bnLfoDepth = Knob.new(w, Rect(255, 155, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\bnLfoDepth, view.value.linlin(0,1,0, 1 ));
})
.value_(0.0);
StaticText.new(w, Rect(260, 180, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo depth");







//---------------------------------------------
//---------------------------------------------
// Gray noise
//---------------------------------------------
//---------------------------------------------

~gnVol=Slider.new(w,Rect(20, 225, 200, 40))
/*.background_(Color.new255(200,0,200))*/
.knobColor_(Color.new255(200, 0, 200))
.action_({
	arg gnVol;
	gnVol.value.postln;
	~gnVol.background_(Color.new(gnVol.value, 0, gnVol.value));
	~noise.set(\gVol, ~gnVol.value);

})
.value_(0);
StaticText.new(w, Rect(50, 270, 200, 15))
.font_(Font.new("Monaco", 15))
.string_("Gray Noise Volume");

//---------------------------------------------
// Grey noise lfo speed
//---------------------------------------------

gnLfoSpeed = Knob.new(w, Rect(220, 220, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\gnLfoSpeed, view.value.linlin(0,1,0, volumeLfoSpeeds));
})
.value_(0.0);

StaticText.new(w, Rect(225, 245, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo speed");



//---------------------------------------------
// Grey noise lfo depth
//---------------------------------------------

gnLfoDepth = Knob.new(w, Rect(255, 220, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\gnLfoDepth, view.value.linlin(0,1,0, 1 ));
})
.value_(0.0);
StaticText.new(w, Rect(260, 245, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo depth");







//---------------------------------------------
//---------------------------------------------
// Clip noise
//---------------------------------------------
//---------------------------------------------

~cnVol=Slider.new(w,Rect(20, 290, 200, 40))
/*.background_(Color.new255(200,0,200))*/
.knobColor_(Color.new255(200, 0, 200))
.action_({
	arg cnVol;
	cnVol.value.postln;
	~cnVol.background_(Color.new(cnVol.value, 0, cnVol.value));
	~noise.set(\cVol, ~cnVol.value);

})
.value_(0);
StaticText.new(w, Rect(50, 335, 200, 15))
.font_(Font.new("Monaco", 15))
.string_("Clip Noise Volume");



//---------------------------------------------
// Clip noise lfo speed
//---------------------------------------------

cnLfoSpeed = Knob.new(w, Rect(220, 285, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\cnLfoSpeed, view.value.linlin(0,1,0, volumeLfoSpeeds));
})
.value_(0.0);

StaticText.new(w, Rect(225, 310, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo speed");



//---------------------------------------------
// Clip noise lfo depth
//---------------------------------------------

cnLfoDepth = Knob.new(w, Rect(255, 285, 30, 30))
.action_({
	arg view;
	view.value.postln;
	~noise.set(\cnLfoDepth, view.value.linlin(0,1,0, 1 ));
})
.value_(0.0);

StaticText.new(w, Rect(260, 310, 30, 30))
.font_(Font.new("Monaco", 7))
.string_("lfo depth");




//---------------------------------------------
//---------------------------------------------
//Overall volume
//---------------------------------------------
//---------------------------------------------

~volume=Slider.new(w, Rect(20, 370, 200, 20))
.action_({
	arg volume;
	volume.value.postln;
	~volume.background_(Color.new(volume.value, volume.value, volume.value));
	~noise.set(\vol, ~volume.value)
});
StaticText.new(w, Rect(230, 375,80, 10))
.font_(Font.new("Monaco", 10))
.string_("Master Volume");





//---------------------------------------------
//---------------------------------------------
//filter Cutoff
//---------------------------------------------
//---------------------------------------------

~fcSlider=Slider.new(w, Rect(290, 20, 40, 250))
.action_({
	arg fcSlider;
	fcSlider.value.postln;
	~fcSlider.background_(Color.new(fcSlider.value, fcSlider.value*0.2,0.3, 0.7));
	~noise.set(\fc, ~fcSlider.value.linexp(0,1,100,2000));
});

StaticText.new(w, Rect(292,260, 40, 30))
.font_(Font.new("Monaco", 10))
.string_("cutoff");





//---------------------------------------------
// filter gain
//---------------------------------------------

~fgSlider=Slider.new(w, Rect(340, 20, 40, 250))
.action_({
	arg fgSlider;
	fgSlider.value.postln;
	~fgSlider.background_(Color.new(fgSlider.value, fgSlider.value*0.2,0.3, 0.7));
	~noise.set(\g, ~fgSlider.value.linexp(0,1,0.1,3.7))
})
.value_(0);
StaticText.new(w, Rect(345,260, 40, 30))
.font_(Font.new("Monaco", 10))
.string_("Fgain");









//---------------------------------------------
//---------------------------------------------
//Filter LFO
//---------------------------------------------
//---------------------------------------------

~filterLfoSpeed=Knob.new(w, Rect(295, 285, 30, 30))
.action_({
	arg filterLfoSpeed;
	filterLfoSpeed.value.postln;
	~noise.set(\lfoSpeed, ~filterLfoSpeed.value.linexp(0,1,0.00125, 100));

});
StaticText.new(w, Rect(300, 310, 20, 30))
.font_(Font.new("Monaco", 6))
.string_("filter lfo speed");

~filterLfoDepth=Knob.new(w, Rect(340, 285, 30, 30))
.action_({
	arg filterLfoDepth;
	filterLfoDepth.value.postln;
	~noise.set(\lfoDepth, ~filterLfoDepth.value.linexp(0,1,0.001, 10000));
});
StaticText.new(w, Rect(345, 310, 30, 30))
.font_(Font.new("Monaco", 6))
.string_("filter lfo depth");



);

//---------------------------------------------
//---------------------------------------------
//run the synth
//---------------------------------------------
//---------------------------------------------

~noise = Synth(\noise, [
	\gate,1,
	\fc, ~fcSlider.value,
	\vol,~volume.value,
	\lfoSpeed, ~filterLfoSpeed.value,
	\lfoDepth, ~filterLfoDepth.value
]);
)



/* test stuff
s.meter
a=Synth(\noise)
a.set(\wVol,0, \pVol,0, \bVol,0,\gVol, 0,\cVol, 0.3, \fc,2000,\g,0)
a.free

*/