
//
// Title - Random note roller
// Author - Ashley Sagar
// Meanwood Audio Research And Recording
// AKA M/A/R/R/S
// date 05/05/2025



/*

Currently this is a chromatic random note generator.


Things to do

1 - center text nicely
2 - add a little clock count down fr when the note changes it gives the remaining time for before the next note is plucked.
3 - scale chooser for different scale tunings.
4 - duration of played note choice
5 - sequence of note chices (2, 12, 24, prime, fibonacci, golden ratio)

*/



(
var rollButton, rolledNote, endCycle;
(


w = Window.new("Random Note Roller", Rect(800, 800, 600, 600),false)
.alwaysOnTop_(true)
.front;

v=UserView(w,Rect(10, 120, 590, 470));

// rolledNote = "Roll";
endCycle = "";

rollButton = Button.new(w, Rect(10, 10, 580, 100))
.states_([
	["ROLL!", Color.magenta, Color.green]
])
.action_({
Routine{

		endCycle = "";
		AppClock.sched(0, {v.refresh});

	12.do{
	var roll = rrand(1,12);

		rolledNote = case(
			{roll == 1},  {"A"},
				// {roll == 2},  {"A#"},
			{roll == 3},  {"B"},
			{roll == 4},  {"C"},
				// {roll == 5},  {"C#"},
			{roll == 6},  {"D"},
				// {roll == 7},  {"D#"},
			{roll == 8},  {"E"},
			{roll == 9},  {"F"},
			{roll == 10}, {"F#"},
			{roll == 11}, {"G"},
				// {roll == 12}, {"G#"},

		);
			rolledNote.postln;
			// Schedule GUI update on Appclock
			AppClock.sched(0, {v.refresh});

			1.rrand(12).wait;
			// 1.wait;
	};
		rolledNote = ""; //clear rolled note
		// set end message and refresh gui
		endCycle="End";
		endCycle.postln;
		AppClock.sched(0, {v.refresh});


}.play;

})
.font_(Font("Monaco", 100));

v.drawFunc={


	Pen.fillColor = Color.cyan;
	Pen.fillRect(Rect(0, 0, 580, 470));

	Pen.fillColor = Color.black;
	Pen.font = Font("Monaco", 400);



	Pen.stringAtPoint(rolledNote, Point(10, 0));

	// display end message when routing finishes
	Pen.font = Font("Monaco", 200);
	Pen.stringAtPoint(endCycle, Point(10, 10));


};
);
)