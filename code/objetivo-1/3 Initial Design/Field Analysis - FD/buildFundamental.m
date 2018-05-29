function fund = buildFundamental(x,B,Fs)

[fundfreq,maxmag,phase] = fundamentalParams(x,B,Fs);
fund = maxmag*sin(2*pi*fundfreq*x+phase);

end