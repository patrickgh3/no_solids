///scrQuadInterp(v1, v2, t)
if argument2 < 0.5 return argument0 + (argument1-argument0)*(2*sqr(argument2))
else return argument0 + (argument1-argument0)*(-2*sqr(argument2-1)+1)
