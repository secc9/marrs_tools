// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S

// granulator
// *************Empty Sample ************

//==== FILL WITH SAMPLE BEFORE USING

/*

Things to do

* I want this to be a granular sample player.
* multiple samples
* live waveform view
*

1 - Build a synthdef


2 - buld a gui
    2.1 -  power - done
    2.2 - time=10,
    2.3 - dur=0.09,
    2.4 - rate=1,
    2.5 - pos = 0.1,
    2.6 - pan=0.0,
    2.7 - amp=1



*/

s.boot
s.meter


(
var bOne, power, gran,time,duration,rate,position,pan,vol, kSz,kspace, knobY, viewer, sFile, txtY, txtSizeX, txtSizeY;


//buffers
// *************Empty Sample ************
bOne = Buffer.readChannel(s, "/Users/ashleysagar/Music/MusicProjects/MARRS/Samples/beat02_percussion.wav" , channels:[0]);



SynthDef(\granulator, {
	arg out=0, gate=1, time=0.001, dur=0.09, rate=1, pos = 0.1, pan=0.0, amp=0.0;

	var sig, env;
	env = EnvGen.kr(Env.asr(1,1,1),gate, doneAction:2);

	sig = GrainBuf.ar(
		2, // channels
		Impulse.kr(time.lag(0.2)), // trigger
		dur.lag(0.2), // duration
		bOne.bufnum, // buffer
		rate.lag(0.01), //rate
		pos.lag(0.01), // position
		2, // interpolation
		pan, //pan
		-1, // envbufnum
		512, //max grains
		1; // amplitude
	);
	Out.ar(out, Pan2.ar(sig*env, 0.0, amp.lag(0.2)));
}).add;


// Tests
/*
a = Synth(\granulator)
a.set(\gate,1)
a.set(\time, 1)
a.set(\dur, 2)
a.set(\rate,-1)
a.free
s.meter
*/


// gui

w=Window.new("Granulator Beat02_Perc_ML", Rect(10, 700, 900, 500))
.front
.background_(Color.new255(0, 244, 0, 150))
.alwaysOnTop_(true);

//power button

power = Button.new(w, Rect(10, 10, 50, 20))
.action_({
	arg view;
	if(
		view.value == 1,
		{gran=Synth(\granulator)},
		{gran.set(\gate, 0)}
	)

})
.states_([
	["ON", Color.black, Color.red],
	["OFF", Color.black, Color.green]
]);


// Dials
kSz = 100;
kspace = kSz+40;
y = 20;
knobY = 350+y;
txtSizeX = 80;
txtSizeY = 20;
txtY = 450+y;

//TIME
time = Knob.new(w, Rect(50, knobY, kSz, kSz))
.action_({
	arg view;
	gran.set(\time, view.value.linlin(0, 1, 0.001, 30))
}
);
StaticText.new(w, Rect(85, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("TIME");


//DURATION
duration = Knob.new(w, Rect(50+kspace, knobY, kSz, kSz))
.action_({
	arg view;
	gran.set(\dur, view.value.linlin(0, 1, 0.0, 10))
});

StaticText.new(w, Rect(70+kspace, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("DURATION");


//RATE
rate = Knob.new(w, Rect(50+(kspace*2), knobY, kSz, kSz))
.action_({
	arg view;
	gran.set(\rate, view.value.linlin(0,1, -1,2))
})
.value_(0.5)
.centered_(true);

StaticText.new(w, Rect(43+kspace*2, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("RATE");

//POSITION
position = Knob.new(w, Rect(50+(kspace*3), knobY, kSz, kSz))
.action_({
	arg view;
	var pos = view.value.linlin(0, 1, 0, 1); // maps knob value to pos
	var framePos = pos * sFile.numFrames; //convert to frame pos

	gran.set(\pos, pos); // send pos to granulator
	viewer.timeCursorPosition = framePos; //move the time cursor in the view
	viewer.refresh; // updates the UI
});

StaticText.new(w, Rect(23+kspace*3, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("POSITION");


//PAN
pan = Knob.new(w, Rect(50+(kspace*4), knobY, kSz, kSz))
.action_({
	arg view;
	gran.set(\pan, view.value.linlin(0,1, -1, 1));
})
.value_(0.5)
.centered_(true);
StaticText.new(w, Rect(22+kspace*4, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("PAN");


//VOLUME
vol = Knob.new(w, Rect(50+(kspace*5), knobY, kSz, kSz))
.action_({
	arg view;
	gran.set(\amp, view.value.linlin(0, 1, 0, 3))
});
StaticText.new(w, Rect(15+kspace*5, txtY, txtSizeX, txtSizeY))
.font_("Monaco", 50)
.string_("VOLUME");





// soundfile view

viewer = SoundFileView.new(w, Rect(20, 50, 850, 200));
sFile = SoundFile.new;
sFile.openRead("/Users/ashleysagar/Music/MusicProjects/MARRS/Samples/beat02_percussion.wav");// fill with path to audio file
viewer.soundfile = sFile;
viewer.read(0, sFile.numFrames);
viewer.refresh;
viewer.zoom(4).refresh;

viewer.timeCursorOn = true;
viewer.timeCursorColor_(Color.white);

)
