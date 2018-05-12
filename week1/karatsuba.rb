#!/usr/bin/env ruby

require 'bigdecimal'

def split(num, mid, sup)
    string = num.to_s.rjust(sup)
    return string.to_s[0 ... mid].to_i, string.to_s[mid .. sup].to_i
end

def karatsuba(a, b)
    return a*b if a < 10 || b < 10
        
    # calculates the size of the numbers 
    m = [a.to_s.length,b.to_s.length].max
    m2 = (m)/2
    k = (m+1)/2

    # split the digit sequences about the middle 
    high1, low1 = split(a, k, m)
    high2, low2 = split(b, k, m)

    # 3 calls made to numbers approximately half the size
    z0 = karatsuba(low1, low2)
    z1 = karatsuba((low1 + high1), (low2 + high2))
    z2 = karatsuba(high1, high2)
    z3 = z1-z0-z2

    return z2 * 10**(2*m2) + ((z3) * 10**(m2)) + z0
end

puts "Actual " 
puts karatsuba(1211, 5211)
puts "should be 6310521"

puts "Actual " 
puts karatsuba(121123, 5211123)
puts "should be 631186851129"

puts "Actual " 
puts karatsuba(123,1123)
puts "should be 138129"

a = 3141592653589793238462643383279502884197169399375105820974944592
b = 2718281828459045235360287471352662497757247093699959574966967627
puts "Actual " 
puts  karatsuba(a,b)
puts "should be 8539734222673567065463550869546574495034888535765114961879601127067743044893204848617875072216249073013374895871952806582723184"