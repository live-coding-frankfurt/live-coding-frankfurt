////////////////////////////////////////////////////
// BenoitLib (used by Benoît and the Mandelbrots)

// Only one can be the leader (in the whole network)

// Start as a leader
m = MandelHub.start(\myName);

// The followers join like this (async, since they have to wait for the leader):
// MandelHub.join(\myName, action: { m = MandelHub.instance })

// That's it! you are synced now!

// Display the metronome
m.gui

// Change tempo:
m.changeTempo(1.5)