function single_sided_power_spectrum = FFT(X)
    %%% single_sided_power_spectrum
    %f = 8000*(0:(length(X)/2))/length(X);
    Y = fft(X);
    P2 = (abs(Y/length(X))).^2;
    P1 = P2(1:floor(length(X)/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    single_sided_power_spectrum = P1;
    %ft = ((abs(fft(X))./length(X)).^2) .*2;
    %single_sided_power_spectrum = ft(1: floor(length(ft)/2)+1);
end