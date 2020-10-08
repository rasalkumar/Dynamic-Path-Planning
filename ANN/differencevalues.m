final = zeros(1,length(data2));
final(1,1) = data2(1,1);
for i = 2:length(data2)
    final(1,i) = data2(1,i) - data2(1,i-1);
end