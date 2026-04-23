function ind = findClosest(vector,value)
	diff = abs(vector-value);
	[mn,ind]  = min(diff);
	%return ind 	# alt. add: diff(ind), vector(ind)
end