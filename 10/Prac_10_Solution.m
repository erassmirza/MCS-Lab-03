clear, clc, close
num = 1/50;
den = [1 10/50 5/50];
plant = tf(num,den)
step(plant); grid on;

Kp=500; Ki=10; Kd=100;
contr=tf([Kd Kp Ki],[1 0]);
sys_cl=feedback(contr*plant,1)
t=0:0.0001:300;

figure
[n,d] = tfdata(sys_cl)
step(n,d,t); grid on;
[y,x,t]=step(n,d,t);

%to find rise time i.e. time taken for output to rise from
%10% to 90%
k=1;
while y(k)<=0.1;
    k=k+1;
end
tenpercent=t(k);
while y(k)<=0.9;
    k=k+1;
end
nintypercent=t(k);
rtime=nintypercent-tenpercent;
fprintf('The rise time is: %f sec \n',rtime);
format short
% to find delay time i.e. time taken to rise to 50% of step
k=1;
while y(k)<=0.5;
    k=k+1;
end
dtime=t(k);
fprintf('The delay time is: %f sec\n', dtime);
% to find maximum overshoot
for k=1:length(t)-1;
    if y(k+1)<=y(k);
        % to find value of k till response keeps rising
        break;
    end;
end;
Oshoot=y(k)-1;
fprintf('The overshoot is: %f sec\n', Oshoot);
% to find the peak time
tp=t(k);
fprintf('the peak time is :%f sec\n',tp)
% to find the settling time
%maximum tolerance for comnsidering output to be in steady
%state taken as
%2%
tol=0.02;
for k=length(t)-1:-1:2;
    if(abs(y(k)-y(length(t)-1))>tol)
        break;
    end;
end;
stime=t(k); 
fprintf('the settling time is :%f sec\n',stime)
sserror = abs(1-y(end))
