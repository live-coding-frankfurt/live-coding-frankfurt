# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
#
#                .:-`
#              `+oooo`
#              +-  :o+
#                   /o-
#                   .oo`
#                   /oo:                dP                         oo
#                  `oo+o`               88
#                  :o:.o/      88d888b. 88d888b. .d8888b. 88d888b. dP .d8888b.
#                 `oo` /o.     88'  `88 88'  `88 88'  `88 88'  `88 88 88'  `""
#                 :o+  `oo` `  88.  .88 88    88 88.  .88 88    88 88 88.  ...
#         -/++++:.oo-   :oo++  88Y888P' dP    dP `88888P' dP    dP dP `88888P'
#        ++-..-:/ooo`    .-.   88
#     `--o+:------o+--`        dP       http://lambdaphonic.de
#        `/oo+///++`
#           .-::-`               Made with Sonic Pi (http://sonic-pi.net)
#
# -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.- --
def cosr(center, range, cycle)
  return (Math.cos(vt*cycle) * range) + center
end

with_fx(:reverb, room: 0.75, mix: 0.6, damp: 0.5) do
  live_loop :foo do
    with_synth :tech_saws do
      base = ring(0, 3, 5).tick(:b)
      [32, 16, 16].ring.look(:b).times do
        play [36, 48, 60, 47].ring.tick + base, amp: 1.0, cutoff: cosr(90, 30, 0.125), release: 0.2
        sleep 0.125
      end
    end
  end
  
  pis="31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989380952572"
  $pi=pis.split("").map { |v| v.to_i }.ring
  
  live_loop :m, sync: :foo do
    tick
    with_synth :dsaw do
      n = scale(:c, :phrygian)[$pi.look]
      t = $pi[look + 1] > 5 ? 2 : 1
      dur = $pi[look + 1] > 5 ? 0.125 : 0.25
      oct = $pi[look + 2] > 5 ? 12 : 0
      t.times do
        play n + oct, release: 0.3, cutoff: cosr(100, 20, 0.5),  amp: 0.25, detune: cosr(0.2, 0.1, cosr(3, 1, 4))
        sleep dur
      end
    end
  end
  
  live_loop :seq do
    seq = scale(:c, :phrygian, num_octaves: 1).pick(8)
    steps = 8
    pulse_counts = ring(1, 2, 4).pick(8)
    types = ring(:tick, :hold, :repeat).pick(8)
    slides = bools(0, 1)
    dur = 0.125
    use_synth :prophet
    with_fx :level, amp: 0.0 do
      norm_seq = seq.take steps
      norm_pulses = pulse_counts.take steps
      norm_types = types.take steps
      norm_slides = slides.pick steps
      s = play norm_seq[0], amp: 1.0, cutoff: cosr(100, 20, 0.125), sustain: dur * norm_pulses.to_a.sum, release: dur
      steps.times do
        idx = tick
        current_note = norm_seq[idx]
        pulse_count = norm_pulses[idx]
        type = norm_types[idx]
        is_slide = norm_slides[idx + 1]
        case type
        when :repeat
          pulse_count.times do
            control s, amp: 1, note: current_note
            sleep dur / 2
            control s, amp: 0
            sleep dur / 2
          end
        when :hold
          control s, amp: 1, note: current_note
          sleep pulse_count * dur
          control s, amp: 0
        when :tick
          control s, amp: 1, note: current_note
          sleep dur / 2
          control s, amp: 0
          sleep (pulse_count * dur) - (dur / 2)
        when :sleep
          control s, amp: 0
          sleep pulse_count * dur
        end
        
        if is_slide then
          control s, note_slide: dur / 2
        else
          control s, note_slide: 0
        end
      end
    end
  end
end

live_loop :drums, sync: :foo do
  tick
  sample :bd_haus if spread([4].choose, 16).look
  sample :drum_cymbal_closed, hpf: cosr(120, 10, cosr(2, 1, 3)), amp: 0.75 if spread([11, 13].choose, [13, 15].choose).look
  sample :drum_snare_hard, amp: 0.25, hpf: 90 if (spread 5, 11).look
  sleep 0.125
end