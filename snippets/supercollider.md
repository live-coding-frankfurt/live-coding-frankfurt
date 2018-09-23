# Start the audio engine

**NOTE:** on Windows, the shortcuts are performed with `ctrl`, on mac with `command`.

```
s.boot
```

Execute the single line with **Shift + Enter* or selecting the text/line and then **Shift + Enter**

# Test tone

```
().play
```

You should hear a **Middle-C** at 10% of the current volume.
Execute it serveral times.

# Live coding

## Ndef (continuous sound process)


Single sinewave duplicated (stereo) at 440 Hz.

```
Ndef('test', { SinOsc.ar(440).dup }).play
```


Feel free to change the frequency and reexecute the line. And start exploring:

```
Ndef('test', { SinOsc.ar( LFNoise0.ar(8).range(400, 800) ).dup }).play
```

There's a lot of **UGens** to try out!

To stop it:

```
Ndef('test').stop
```

## SynthDef (an instrument)

```
SynthDef('ping', { |out, freq, amp, sustain, pan|
    var sound = SinOsc.ar(freq);
    sound = sound * EnvGen.ar(Env.perc(0.01, sustain), doneAction: 2);
    sound = Pan2.ar(sound, pan);
    sound = sound * amp;
    Out.ar(out, sound);
}).add
```

Test the **SynthDef**

```
(instrument: 'ping').play
```

## Pdef (a pattern player)

```
Pdef('pinger', Pbind(
    \instrument, \ping,
    \degree, Pseq([0, 1, 2, 3], inf),
    \amp, 0.1,
    \dur, Prand([0.25, 0.5], inf),
)).play;
```

There's also a lot of Patterns to generate notes/values!

To stop it:

```
Pdef('pinger').stop
```
















