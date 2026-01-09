//
// Title - a reciever for serial data from arduino to supercollider
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S
// date 05/02/2025

// tutorial from Eli Fieldsteel
//https://www.youtube.com/watch?v=_NpivsEva5o


// this is some code that currently sends data from a pot connected to an arduino through usb to control a cutoff filter
s.boot;
s.quit;


SerialPort.devices
~port = SerialPort.new("/dev/tty.usbmodem11301", 115200);
~port.read

(
x = [ ];
30.do{x = x.add(~port.read)};
x.collect(_.asAscii);
)

(
var getCutoff, getRez;

(
getCutoff = Routine.new({
	var ascii;
	{
		ascii = ~port.read.asAscii;
		if(ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});
		if(ascii == $a, {
			~valA = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
	}.loop;
}).play;
);

(
getRez = Routine.new({
	var ascii;
	{
		ascii = ~port.read.asAscii;
		if(ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});
		if(ascii == $b, {
			~valB = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
		});
	}.loop;
}).play;
)
)
)

s.meter
~valA;
~getValues.stop

(
SynthDef(\test, {
	arg out=0, cut=1000, rez=1.0;
	var src, env, filt;
	// env = EnvGen.kr(Env.linen(1,1,10,1), doneAction:2);
	src = Saw.ar(200, 1);
	filt = RLPF.ar(src,cut, rez);
	Out.ar(out, Pan2.ar(filt, 0, 0.5));
}).add
)
s.boot
~synth = Synth(\test, ~valA.linexp(0, 1023, 80, 4000))
~synth.set(\cut, 400)
~synth.free

~synth = Synth(\test, [\cut, ~valA.linexp(0, 1023, 80, 4000), \rez, ~valB.linexp(0,1,0.1, 1)])

(
~control = Routine.new({
	{
		~synth.set(\cut, ~valA.linexp(0, 1023, 80, 4000));
		0.01.wait;
		~synth.set(\rez, ~valB.linexp(0, 1023, 0.0, 1.0));
		0.01.wait;
	}.loop;
}).play;
)
(
~control.stop;
~synth.free;
)