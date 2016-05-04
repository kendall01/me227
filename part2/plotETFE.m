load chirpTimeSeries


N = length(torque);
%No Time Delay
[in,out,tf,w]=ETFE(torque,handwheelAngle,Ts);

% Shift 4 time steps (20 ms to account for steering delay)
%[in,out,tf,w]=ETFE(torque(1:N-3),handwheelAngle(4:N),Ts);

figure(2)
subplot(3,1,1)
semilogx(w,20*log10(abs(in)),w,20*log10(abs(out)))
grid on
legendText=legend('torque input (N.m)','handwheel output (rad)');
leg=findobj(legendText,'type','text');
set(leg,'FontSize',12);
xlim([0.05 30].*6)
ylim([-100 0])
ylabel('dB','FontSize', 14)
set(gca,'XTickLabel',[])

subplot(3,1,2)
semilogx(w,20*log10(abs(tf)))
grid on
ylabel('magnitude (rad/N.m)','FontSize', 14)
xlim([0.05 30].*6)
ylim([-60 20])
ylabel('dB','FontSize', 14)
set(gca,'XTickLabel',[])

subplot(3,1,3)
semilogx(w,unwrap(angle(tf)).*180/pi-180)
grid on
xlabel('frequency (rad/s)','FontSize', 14)
ylabel('phase (deg)','FontSize', 14)
set(leg,'FontSize',12);
ylim([-270 0])
xlim([0.05 30].*6)