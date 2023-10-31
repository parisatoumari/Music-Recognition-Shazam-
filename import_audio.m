function [downsampled_Fs, resampled_audio] = import_audio(path, song_num, format)
    % import the audio 
    [audio, Fs] = audioread([path, 'music', num2str(song_num),'.', format]);
    % getting mean over right and left channels
    temp = size(audio)
    if temp(2)==2
        monoAudio = (audio(:,1) + audio (:,2))./2;
    else
        monoAudio = audio;
    end    
    %%% monoAudio
    % downsample the audio to 8 KHz
    downsampled_Fs = 8000;
    resampled_audio = resample(monoAudio,downsampled_Fs,Fs);
    %%% resampled_audio
end