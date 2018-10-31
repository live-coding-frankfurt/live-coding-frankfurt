// EZ Remote server

// my local server:
s.options.maxLogins = 16
s.boot

// The remote server:
o = Server.remote(\boomcake, NetAddr("192.168.178.21", 57110))
o.latency = 0.1

// Manual OSC messages
o.sendMsg("/s_new", "default", 10000)
o.sendMsg("/n_free", 10000)

// Directly send and play synths
{ SinOsc.ar(220)!2 * 0.5 }.play(o)

// Stop all running synths
o.freeAll

// Language side:
n = NetAddr("192.168.178.21", 57120)
n.sendMsg("/chat", "hallo hallo")

OSCdef(\responder, { |m| m.postln }, "/chat")

// EZ ProxySpace
p = ProxySpace.push(o)

~a.play
~a[0] = { Dust.ar([8, 8]) }
~a[1] = \filter -> { |in| BPF.ar(in, 880, 0.1) * 10 }
~a[2] = \filter -> { |in| GVerb.ar(in, 299, 8) }

~a.end(4)

p.pop