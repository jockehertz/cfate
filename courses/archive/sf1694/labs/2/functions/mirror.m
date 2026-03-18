function M = mirror(a, b)
    ea = 1/(1 + a^2)*[1; a];
    ex = [1; 0];
    ey = [0; 1];
    ey = ey - [0; b];

    ex_proj = dot(ex, ea)/dot(ea, ea)*ea;
    ey_proj = dot(ey, ea)/dot(ea, ea)*ea;
    tx = ex_proj - ex;
    ty = ey_proj - ey;

    
    ex_new = ex + 2*tx;
    ey_new = ey + 2*ty + [0; b];
    M = [ex_new, ey_new];
end