function [DFT_input,DFT_output,TF_discrete,w]=ETFE(inputSignal,outputSignal,Ts)

% Function to calculate ETFE
% By Krisada Kritayakirana
% Date: October 20, 08
% inputSignal = discrete input signal in time domain
% outputSignal = discrete output signal in time domain
% Ts = sampling time [s]
% DFT_input = DFT of input signal
% DFT_output = DFT of output signal
% TF_discrete = discrete Transfer Function 
% w = frequency [rad/s]

if length(inputSignal) ~= length(outputSignal)
    error('Input and output must have same length')
end

N=length(inputSignal);
t=0:Ts:(N-1)*Ts;

% DFT
DFT_input=fft(inputSignal,N)./N;
DFT_output=fft(outputSignal,N)./N;

% frequency vector
w = ( 0:1:(N-1) )./N.*2*pi/Ts;

%keyboard

TF_discrete=DFT_output./DFT_input;


% %% plot figure
% 
% figure(111)
% plot(t,inputSignal,t,outputSignal,'--')
% grid 
% xlabel('Time [s]')
% legend('Input','Output')
% title('Time History')
% 
% figure(112)
% subplot(2,1,1)
% loglog(w,abs(DFT_input),w,abs(DFT_output),':','LineWidth',2)
% grid on
% xlabel('Frequency [rad/s]')
% ylabel('Magnitude')
% title('FFT')
% subplot(2,1,2)
% semilogx(w,unwrap(angle(DFT_input)).*180/pi,w,unwrap(angle(DFT_output)).*180/pi,':','LineWidth',2)
% ylabel('Phase [Deg]')
% grid 
% legend('Input','Output')
% 
% figure(113)
% subplot(2,1,1)
% loglog(w,abs(TF_discrete),'--','LineWidth',2)
% grid on
% xlabel('Frequency [rad/s]')
% ylabel('Magnitude')
% title('ETFE')
% subplot(2,1,2)
% semilogx(w,angle(TF_discrete).*180/pi,'--','LineWidth',2)
% ylabel('Phase [Deg]')
% grid 
% 
% disp('Pause')
% pause
% close figure 111 figure 112 figure 113



