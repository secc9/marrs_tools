// Ashley Sagar
// Meanwood Audio Research and Recording
// Aka M/A/R/R/S

// Recording template


(
ServerOptions.devices;
// MOTU Soundcard
Server.default.options.inDevice_("UltraLite-mk5");
Server.default.options.outDevice_("UltraLite-mk5");
s.options.numInputBusChannels=8; //set inputs to 10
s.options.numOutputBusChannels=8;
)
(
// M-Audio Soundcard
Server.default.options.inDevice_("USB AUDIO  CODEC");
Server.default.options.outDevice_("USB AUDIO  CODEC");
s.options.numInputBusChannels=2; //set inputs to 10
s.options.numOutputBusChannels=2;
)

(
// M-Audio Soundcard in/Headphones out
Server.default.options.inDevice_("USB AUDIO  CODEC");
Server.default.options.outDevice_("External Headphones");
s.options.numInputBusChannels=2; //set inputs to 10
s.options.numOutputBusChannels=2;
)
(
s.boot;
s.meter;
)
// signal test
z = {PinkNoise.ar(1)!2}.play;
z.release(2);
//dont forget to change date of prepareForRecord
s.prepareForRecord("/Users/ashleysagar/Music/MusicProjects/MARRS/audioRecordings/25_08_16.wav")
//add a clock
c = ClockFace.new(alwaysOnTop:true);
c.play
s.record
s.stopRecording
c.stop;
s.quit


//build some effects sends here to boot first


(
//this block adapted from Eli Fieldsteel
//6.13
// creation of a microphone input on channel 1 that applies a reverb effect to the generated signal
var bus = Bus.audio(s, 2);
(

s.newBusAllocators;
SynthDef(\micIn, {|out = 0, level = 0.5|
	var sig = SoundIn.ar(0, level)!2;
	Out.ar(out, sig);
}).add;

SynthDef(\reverb, {|in= 0, out = 0, size = 0.97|
	var sig = In.ar(in, 2);
	sig = FreeVerb2.ar(sig[0], sig[1], mix: 0.6, room:size, mul:4);
	Out.ar(out, sig);
}).add;
);
// ~a.set(\level, 3)
(
~b = Synth(\reverb, [in: bus, out: 0]);
~a = Synth(\micIn, [out: bus]);
);

);
~a.free;~b.free
// s.meter





//--------------------------------------------
// here is a patch to randomly open up the MAARS tools and force me to use tham in the order the computer gives it to me.
// I'm hoping it shakes me out of my falling back on things

(
var t1 = 60;
var t2 = 60*3;
Routine{
	27.do{
		var roll = rrand(1,27);
		case(
			{roll==1},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/pitchshifterV2.scd")},
			{roll==2},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/randomNoteRoller.scd")},
			{roll==3},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/melodyMaker01.scd")},
			{roll==4},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/fmDoubleDoubleModulator.scd")},
			{roll==5},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/fmsynth_V2.scd")},
			{roll==6},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/gendyGendy.scd")},
			{roll==7},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/AudioPlayers/SalsaAudioPlayerV2.scd")},
			{roll==8},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/AudioPlayers/vanillaAudioPlayerV2.scd")},
			{roll==9},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/liveGranulatorV0.1.scd")},
			{roll==10}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/noisenoise.scd")},
			{roll==11}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/LemurCalls.scd")},
			{roll==12}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/MedellinFruitSellers.scd")},
			{roll==13}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/granulatorHowler.scd")},
			{roll==14}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/granulatorPuffins.scd")},
			{roll==15}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01.scd")},
			{roll==16}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat02.scd")},
			{roll==17}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat03.scd")},
			{roll==18}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat04.scd")},
			{roll==19}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat05.scd")},
			{roll==20}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat06.scd")},
			{roll==21}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/CrackleNdust.scd")},
			{roll==22}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_ISIS_ML.scd")},
			{roll==23}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_Percussion_ML.scd")},
			{roll==24}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_Percussion.scd")},
			{roll==25}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat02_Percussion.scd")},
			{roll==26}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat05Musicnet")},
			{roll==27}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat06VCTK.scd")},

	 );
		rand(t1, t2).wait;
}
}.play
)


//-------------------------------------------------------------
//// This is a scramble version of the code from a gpt prompt
// This code shouldnt repeat the same line twice
(
var t1 = 60;
var t2 = 60*3;
var rolls = (1..27).scramble; // Generate a list of unique shuffled numbers

Routine{
	rolls.do { |roll|  // Iterate over the list instead of randomly generating numbers
		case(
			{roll==1},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/pitchshifterV2.scd")},
			{roll==2},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/randomNoteRoller.scd")},
			{roll==3},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/melodyMaker01.scd")},
			{roll==4},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/fmDoubleDoubleModulator.scd")},
			{roll==5},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/fmsynth_V2.scd")},
			{roll==6},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/gendyGendy.scd")},
			{roll==7},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/AudioPlayers/SalsaAudioPlayerV2.scd")},
			{roll==8},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/AudioPlayers/vanillaAudioPlayerV2.scd")},
			{roll==9},  {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/liveGranulatorV0.1.scd")},
			{roll==10}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/noisenoise.scd")},
			{roll==11}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/LemurCalls.scd")},
			{roll==12}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/MedellinFruitSellers.scd")},
			{roll==13}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/granulatorHowler.scd")},
			{roll==14}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/granulatorPuffins.scd")},
			{roll==15}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01.scd")},
			{roll==16}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat02.scd")},
			{roll==17}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat03.scd")},
			{roll==18}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat04.scd")},
			{roll==19}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat05.scd")},
			{roll==20}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat06.scd")},
			{roll==21}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/CrackleNdust.scd")},
			{roll==22}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_ISIS_ML.scd")},
			{roll==23}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_Percussion_ML.scd")},
			{roll==24}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat01_Percussion.scd")},
			{roll==25}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat02_Percussion.scd")},
			{roll==26}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat05Musicnet")},
			{roll==27}, {Document.open("/Users/ashleysagar/Music/MusicProjects/MARRS/Tools/GranularSynths/beat06VCTK.scd")},

		);
		rand(t1, t2).wait;
	}
}.play;
)







unixCmd

(
// just a buffer to check recordings
var emom = Buffer.read(s,"/Users/ashleysagar/Music/MusicProjects/MARRS/audioRecordings/emom_25_02_12_1.wav");

z = {PlayBuf.ar(2,emom,1)}.play;

)
s.meter