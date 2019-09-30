#! /usr/bin/ruby
require './number10'

def assert(cond)
    raise "assert! Fail!" unless cond
end



# test: 2つと +
values = makeable_values([1,2], [:+])
assert values == [3]

# test: 2つと -
values = makeable_values([5,1], [:-])
assert values.sort == [-4,4].sort

# test: 2つと /
values = makeable_values([4,8], [:/])
assert values.sort == [2].sort

# test: 2つと +-*/
values = makeable_values([3,7], [:+, :-, :*, :/])
assert values.sort == [-4, 4, 10, 21].sort

# test: skip, commutative
assert skip?(3, :/, 2)
assert skip?(5, :/, 2)
assert !skip?(8, :/, 2)
assert commutative?(:+)
assert !commutative?(:-)

# test: combination and set substraction
a = [1,2,3,4]
c = a.combination(1).to_a
assert c == [[1], [2], [3], [4]]
d = [a - c[0], a - c[1], a - c[2], a - c[3]]
assert d == [[2,3,4],[1,3,4],[1,2,4],[1,2,3]]

# test: split_into_2_groups
values = makeable_values([1,2,3], [:+])
assert values == [6]
values = makeable_values([1,2,3], [:+,:-])
assert values.sort == [6,0,4,2,-2,-4].sort

