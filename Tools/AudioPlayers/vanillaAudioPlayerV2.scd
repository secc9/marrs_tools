

//
// Title - vanilla loop/audio player
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S
// date 03/02/2025


/*---

V2 -
Attempting a load audio situation

what even is this?
just a simple loop/ audio file player


to do
- make a Buffer - done

- Make a SynthDef -done

- Make a Gui -done



- TODO
 - Loop button is broken. it wont toggle the loop on and off
- add trigger button


*/



s.boot;
s.meter;
b.free
(
b = Buffer.read(s,"/Users/ashleysagar/Music/MusicProjects/{DELUXE_HUGS}/samplesNloops/Bounces/ertropicalloop01_106bpm.wav");
)

(

var play, apWin,apPlay, rate, loop, position, audioView, audioFile, volume, trig, loadButton;
(
SynthDef(\audioPlayer, {
	arg out = 0, bufnum=0, gate = 1, rate=1, trigger=0,pos=0,loop=0, vol=0;

	var env, src;
	env = EnvGen.kr(Env.asr(1,1,1), gate, doneAction:2);
	src = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, trigger,pos,loop, doneAction:2);

	Out.ar(out, Pan2.ar(src*env, 0, vol));
}).add;
);

//Tests
// z = {SinOsc.kr(100, 0, 100)}
// a= Synth(\audioPlayer, [\bufnum, b])
// a.set(\rate, 10)

// buf.free

// a.free
(
//===========GUI=================

apWin=Window.new("Vanilla Audio Player", Rect(900, 500, 300, 200))
.front
.background_(Color.new255(100, 100, 200))
.alwaysOnTop_(true);


//play button

play = Button.new(apWin, Rect(10, 10, 280, 50))
.states_([
	["PLAY", Color.black, Color.red],
	["STOP", Color.black, Color.green]
])
.action_({
	arg btn;
	if(
		btn.value == 1,
		{apPlay = Synth(\audioPlayer, [\out, 0,\bufnum, b])},
		{apPlay.free}
	);
});


//==========


loop = Button.new(apWin, Rect(10, 65, 50, 30))
.states_([
    ["Loop on", Color.black, Color.grey],
    ["Loop off", Color.black, Color.cyan]
])
.action_({
    arg lp;
    if (apPlay.notNil) {
        if (lp.value == 1) {
            apPlay.set(\loop, 1);
        } {
            apPlay.set(\loop, 0);
        };
    };
});









rate = Knob.new(apWin, Rect(20, 145, 50, 50))
.action_({
	arg rt;
	apPlay.set(\rate, rt.value.linlin(0, 1, -1, 2));
})
.value_(0.65)
.centered_(true);
StaticText.new(apWin, Rect(32, 125, 30, 20))
.string_("rate");


// position

// position = Slider.new(apWin, Rect(90, 160, 200, 30))
// .action_({
// 	arg view;
// 	var pos = view.value.linlin(0, 1, 0, 1); // map knobs
// 	var framePos = pos * audioFile.numFrames;
// 	apPlay.set(\pos, position);
// 	audioView.timeCursorPosition = framePos;
// 	audioView.refresh;
// });





//vol

volume = Knob.new(apWin, Rect(80, 145, 50, 50))
.action_({
	arg vl;
	apPlay.set(\vol, vl.value.linlin(0, 1, 0, 1));

});
StaticText.new(apWin, Rect(95, 125, 30, 20))
.string_("vol");


//======TRIGGER


trig = Button.new(apWin, Rect(65, 65, 20, 30))
.states_([["T", Color.black, Color.red]])
.action_({
    if (apPlay.notNil) {
        apPlay.set(\trigger, 1);
    };
});

//======LOAD

// Load button
loadButton = Button.new(apWin, Rect(210, 160, 80, 30))
    .states_([["Load", Color.black, Color.blue]])
     .action_({
        arg btn;
        FileDialog.new(
            { arg ok, path;
                if (ok, {
                    // Handle the selected file path
                    ("Selected file: " ++ path).postln;
                    // You can now load the audio file using the path
                    // For example, load it into a buffer or a sound file
                    // audioFile.openRead(path);
                });
            },
            { arg cancel;
                // Handle the cancel action if needed
            },
            fileMode: 1, // Single existing file
            acceptMode: 0 // Open file dialog
        );
    });



//===== Viewer

audioView = SoundFileView.new(apWin, Rect(90, 65, 200, 50));
audioFile = SoundFile.new;
audioFile.openRead("/Users/ashleysagar/Music/MusicProjects/{DELUXE_HUGS}/samplesNloops/Bounces/ertropicalloop01_106bpm.wav");
audioView.soundfile = audioFile;
audioView.read(0, audioFile.numFrames);
audioView.refresh;
audioView.zoom(4).refresh;

audioView.timeCursorOn = true;
audioView.timeCursorColor = Color.white;
);


apWin.onClose_({apPlay.release(2)});

)



