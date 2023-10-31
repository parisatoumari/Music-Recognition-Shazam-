%% adding the path of subfolders
clc;
addpath('functions/');
addpath('database/');
addpath('musics/');
addpath('test_musics/');

%% loading the created database
clear; close all; clc;

database = load('database/database.mat').database;

%% calculate the hash tags for the given song

%importing an audio
path = 'test_musics/'; % test musics path
song_num=1 ;
format='wav';
[downsampled_Fs, resampled_audio] = import_audio(path, song_num, format);

% adding noise to the audio
% for snr=1:10
%%
snr=10;
% fprintf([num2str(snr), '\n']);
% [audio, Fs] = audioread(['musics/', 'music', num2str(2),'.', 'mp3']);
% [audio2, Fs2] = audioread(['musics/', 'music', num2str(8),'.', 'mp3']);
% info = size(audio);
% inf = size(audio2);
% duration = floor(info(1)./Fs);
% dura = floor(inf(1)./Fs2);
% prob=zeros(1,100);
%for p=1:100
% start = randi(duration-20);
% start2 = randi(dura-20);
% extracedAudio = audio(start*Fs : (start+20)*Fs,:);
% extraAud = audio(start2*Fs2 : (start2+20)*Fs2);
% output = awgn(extracedAudio,snr);
% output2 = awgn(extrAud,snr);
% temp = size(extracedAudio);
%     if info(2)==2
%         monoAudio = (extracedAudio(:,1) + extracedAudio(:,2))./2;
%     else
%         monoAudio = extracedAudio;
%     end    
downsampled_Fs = 8000;
% resampled_audio = resample(monoAudio,downsampled_Fs,Fs);
% temp2 = size(extraAud);
%     if temp2(2)==2
%         monoAudio2 = (extraAud(:,1) + extraAud(:,2))./2;
%     else
%         monoAudio2 = extraAud;
%     end    
% resampled_audio2 = resample(monoAudio2,downsampled_Fs,Fs2);
% all=[resampled_audio';resampled_audio2];
% 
%     a=0.5/10;
%     sum = a*all(1,:)+(1-a)*all(2,:);


% creating the time-freq matrix of the audio using fft and an overlapping sliding window with the length of "window_time"
window_time = 0.1;
[time, freq, time_freq_mat] = STFT(resampled_audio, downsampled_Fs, window_time);

% a full screen figure for plots
figure('Units','normalized','Position',[0 0 1 1]);

% plotting the stft
subplot(1,2,1);
pcolor(time, freq, time_freq_mat);
shading interp
colorbar;
xlabel('time(s)');
ylabel('frequency(Hz)');
title('STFT(dB)');

% finding the anchor points from time_freq_mat using a sliding window with the size of 2dt*2df
df = floor(0.1*size(time_freq_mat, 1)/4);
dt = 2/window_time;
% finding anchor points
anchor_points = find_anchor_points(time_freq_mat, dt, df);
% plotting the anchor points
subplot(1,2,2);
scatter(time(anchor_points(:, 2)), freq(anchor_points(:, 1)),'x');
xlabel('time(s)','interpreter','latex');
ylabel('frequency(Hz)','interpreter','latex');
title("anchor points",'interpreter','latex');
xlim([time(1) time(end)]);
ylim([freq(1) freq(end)]);
grid on; grid minor;

% creating the hash tags using a window with the size of dt*2df for each anchor point
df_hash = floor(0.1*size(time_freq_mat,1));
dt_hash = 20/window_time;
% creating hash-keys and hash-values for each pair of anchor points
% Key format: (f1*f2*(t2-t1)) 
% Value format: (song_name*time_from_start)
[hash_key, hash_value] = create_hash_tags(anchor_points, df_hash, dt_hash, 0);

%% searching hash tags
clc; close all;

list = []; 

% searching for found hash-keys in the database
for i = 1:length(hash_key)
    key_tag = [num2str(hash_key(i, 1)), '*', num2str(hash_key(i, 2)), '*', num2str(hash_key(i, 3))];
    if (isKey(database, key_tag))
        temp1 = split(database(key_tag),'+');
        for j = 1:length(temp1)
            temp2 = split(temp1{j},'*');
            list = [list; [str2num(temp2{1}),str2num(temp2{2}),hash_value(i,2)]];
        end
    end
end

%% scoring
clc; close all;
%%
%for finding the time of the test_musics:
%prob(p)=
score=scoring(list);
for i=1:length(list)
    if list(i,1)==score(1,1)
    st=list(i,2);
    end
end    
fprintf(num2str(st*(1/20)));
% fprintf([num2str(prob(p)), '\n']);
% end
%ava=zeros(1,10);
% for j=1:10 
%   sum=0;
%   for i=1:100
%     sum=sum+prob(i);
%   end
%   avg=sum/100;
%   ava(j)=avg;
% end
% end
% SNR=[1,2,3,4,5,6,7,8,9,10];
% plot(SNR,ava)