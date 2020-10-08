% num_ants = [10 20 30 40 50 60 70 100 150];
% min_lengths = [2460 2200 2125 2142 2036 2054 2110 2082 1978];
% time = [5.534 6.036 6.457 6.856 7.199 7.42 7.849 9.57 11.47];
% subplot(2,1,1);
% plot(num_ants,min_lengths,'b*--');
% xlabel('Number of ants');
% ylabel('Length of path');
% axis([0 170 1800 2600])
% subplot(2,1,2);
% plot(num_ants,time,'r*--');
% legend('iterations = 10');
% xlabel('Number of ants');
% ylabel('Computation Time (sec)');
% axis([0 170 5 15])

num_obj = [3 5 7 10 16 21];
deviation = [.277 .093 .101 .096 .20 .21]*100;
plot(num_obj,deviation,'r*--');
grid;
xlabel('Number of obstacles');
ylabel('deviation from Free path length (%)');

