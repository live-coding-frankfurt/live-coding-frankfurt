# Make Sonic-Pi your own

You can add a file named `init.rb` to your home directory under the folder `.sonicpi`. This file is loaded at program start. Here you can place your own helper methods, which are then available to use globally within Sonic-Pi.

If you use the portable version under Windows, the folder will be in the subfolder `Data\-.sonic-pi` of the portable distribution.

In the same folder is also a file called `theme.properties`. Here you can tweak the colors of the Sonic-Pi UI.

# Useful helper methods

```ruby
# A scaled cosine over time
# Very useful as an LFO
# Example:
# cosr(10, 5, 1) will cycle between 5 and 15 (from center-range to center+range)
# The lower the cycle value is, the slower is the cycle
def cosr(center, range, cycle)
  return Math.cos(vt * cycle) * range + center
end

# A scaled sine over time
# Very useful as an LFO
# Example:
# sinr(10, 5, 1) will cycle between 5 and 15 (from center-range to center+range)
# The lower the cycle value is, the slower is the cycle
def sinr(center, range, cycle)
  return Math.sin(vt * cycle) * range + center
end
```
