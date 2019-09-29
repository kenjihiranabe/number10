#! /usr/bin/ruby
#
# Number 10 問題
# 仮説： 車のナンバープレートには4つの数字がありますが、4つの数字に0を含まずすべて違う数字の時、
# 4つの数字の四則演算で10を作れる。
# このことを証明もしくは反例をあげよ。
#
# 例：1234 -> 1+2+3+4 = 10, 5431 -> 5*(4-3)+1 = 10, 2874-> (7-2)(8/4) = 10
# 追記： 4つはどの順に現れても良い
#        割り算は割り切れる組み合わせしか使ってはいけない

# 禁止演算
def skip?(l, op, r)
    op == :/ && ((r == 0) || (l % r != 0))
end

# 交換則の成り立つ演算
def commutative?(op)
    op == :+ || op == :*
end

def calculate(l, op, r)
    l.send(op, r)
end

# nums 配列の中に入っている数字と ops 配列に入っている演算のすべての組み合わせで
# 作れる可能性がある数字の配列を返す。
def makeable_values(nums, ops)

# 方針: すべて2項演算の繰り返しに還元できるので、4つの数字をAB(左右)2つのグループに分け、すべての
# グループ分けの場合について、左右に再帰的に取り得る値を求め、その組み合わせを列挙

    return nums if nums.size == 1 

    if nums.size == 2 then
        values = []
	ops.each { |op|
            next if skip?(nums[0], op, nums[1])
            values << calculate(nums[0], op, nums[1]) 

            if !commutative?(op) then
            	next if skip?(nums[1], op, nums[0])
                values << calculate(nums[1], op, nums[0]) 
            end
        }
        return values.uniq
    end

    # すべての 2グループ分けを作る.要素数 1つ, 2つ, ... のグループとその他(n/2 まであればよい)
    values = []
    (1..nums.size/2).each { |i|
       nums.combination(i) { |c|
           l = c   # left group
           r = nums - c   #  right group
           v1 = makeable_values(l, ops)    # recursive call to left
           v2 = makeable_values(r, ops)    # recursive call to right
           v1.each { |vv1|
                 v2.each { |vv2|
                     vs = makeable_values([vv1,vv2], ops) # recursive call to cross
                     values += vs
                 }
           }
       }
    }
    return values.uniq
end

if __FILE__ == $0

[1,2,3,4,5,6,7,8,9].combination(4) { |i|
    values = makeable_values(i, [:+,:-,:*,:/])
    if values.include?(10)
        p ("%s --> 10" % i.to_s) 
    elsif
        p ("%s XXX 10" % i.to_s) 
    end
}

end
