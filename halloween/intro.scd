// ProxySpace

// Start up the proxy space
p = ProxySpace.push(s.boot);


// Now ALL the ~ variables (env variables) are "node proxies" (i.e. audio processes)

~wind.play
~wind = { BPF.ar(GrayNoise.ar, MouseX.kr(200, 8000), MouseY.kr(0.1, 1.0)).dup }
~wind.stop

~theremin.play
~theremin = { SinOsc.ar(MouseX.kr(200, 800)) * MouseY.kr(0.0001, 1, 1) }
~theremin.stop

~seashore.play
~seashore = { Splay.ar( LPF.ar( PinkNoise.ar, { SinOsc.ar(Rand(0.1, 0.5)).range(30, 800) }.dup(8) ) ) * 0.1 }
~seashore.stop

~ufo.play
~ufo.fadeTime = 4
~ufo = { Splay.ar( SinOsc.ar( { ExpRand(80.0, 800.0) }.dup(8) ) ) }
~ufo.stop

~rain.play
~rain = { Splay.ar( { BPF.ar( Decay2.ar( Dust.ar( ExpRand(0.5, 8.0) ), 0.005, 0.05 ), ExpRand(200.0, 12000.0), ExpRand(0.5, 1.0) ) }.dup(8) ) }
~rain.stop

~thunder.play
// eparated source and effect:
~thunder[0] = { EnvGen.ar(Env.perc(0.01, 4)) * LPF.ar(WhiteNoise.ar, EnvGen.ar(Env.perc(0.1, 2, 1000, -8), levelBias: 20)) }
// the reverb... reexecute the source
~thunder[1] = \filter -> { |in| GVerb.ar(in, 300, 8, mul:1, add: in * 0.5) }