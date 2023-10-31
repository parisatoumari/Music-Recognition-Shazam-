% [fs, audio] = import_audio('musics/', 8, 'mp3');
% plot(FFT(audio));
% [t,f,time_freq_mat] = STFT(audio,fs,0.1);
% subplot(1,2,1);
%    pcolor(t, f, time_freq_mat);
%    axis square;
%    shading interp;
%    colorbar;
%    xlabel('time(s)','interpreter','latex');
%    ylabel('frequency(Hz)','interpreter','latex');
%%
% [audio, Fs] = audioread(['musics/', 'music', num2str(10),'.', 'mp3']);
% info = size(audio);
% duration = floor(info(1)./Fs);
% start = randi(duration-20);
% extracedAudio = audio(start*Fs : (start+20)*Fs);
% snr=7;
% output = awgn(extracedAudio,snr);
% sound(output,Fs);
% [audio, Fs] = audioread(['musics/', 'music', num2str(51),'.', 'mp3']);
% sound(audio,Fs) 
% % b=[1,2];
% c=[3,5];
% A=[b;c]


