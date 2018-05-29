function [fundfreq, maxmag, phase] = fundamentalParams(x, B, Fs)
% EXTRACTFUNDAMENTAL provides values for the fundamental of a magnetic flux
% density spatial wave B. These values comprise the fundamental frequency
% in cycles/cm, its magnitude and phase. The frequency and magnitude values
% are extracted using the Fast Fourier Transform. The phase is defined as 
% the phase at which the correlation coefficient between the fundamental 
% and the B signal is maximum.
%    [fundfreq, maxmag, phase] = EXTRACTFUNDAMENTAL(x,B,Fs) computes the 
%    value of frequency, magnitude and phase of the fundamental of the 
%    magnetic flux density B, which is a function of x (in cm) with values 
%    taken with a spatial sampling frequency Fs (in samples/cm). Fs can be 
%    computed as length(x)/Lp where Lp is the length of the analyzed region
%    in space.

% Number of samples
Ns = length(B);
% Next power of 2 from length of signal
NFFT = 2^nextpow2(Ns);
% Compute Fourier transform
sigFFT = fft(B,NFFT)/Ns;
% Extract single-sided FFT magnitudes
sigFFT = 2*abs(sigFFT(1:NFFT/2+1));
% Generate frequency data
f = Fs/2*linspace(0,1,NFFT/2+1);

% Find the index of the maximum in the FFT magnitude spectrum
[~,idx] = max(sigFFT);
fundfreq = f(idx);
maxmag = sigFFT(idx);

maxcorrcoeff = 0;
phase = 0;

% Find the phase at which the correlation coefficient between the signal 
% and the fundamental is maximum
for i = 0:2*pi/199:2*pi
    testB = sin(2*pi*fundfreq*x+i);
    nB = sqrt(B'*B);
    ntB = sqrt(testB'*testB);
    corrcoeff = (testB'*B)/(nB*ntB);
    if corrcoeff >= maxcorrcoeff
        maxcorrcoeff = corrcoeff;
        phase = i;
    end    
end

end