function M = rotation(theta)
    theta = theta * 2*pi/360; %radian conversion
    M = [ cos(theta), -sin(theta) ; sin(theta) cos(theta) ];
end