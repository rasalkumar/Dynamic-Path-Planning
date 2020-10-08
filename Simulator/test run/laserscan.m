scan = receive(laser);
plot(scan); data = readCartesian(scan);
dat1 = rms(data);
if isnan(dat1)
    dat1(1) = 999;
    dat1(2) = 999;
end
