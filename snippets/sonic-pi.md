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