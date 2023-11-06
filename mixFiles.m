function mixFiles(logFileName,noisyFile,targetFile,snr)
% This function mixes a clean file with a noise file at a given snr, and writes 
% into a target file, intended for speech enhancement experiments
%
% if nargin = 1, reads logFileName containing a list of clean file, noise file,
% target file, snr
% if nargin = 4, input is taken to be individual arguments in the above format

ACTUAL_SNR_OUT = 0; %whether to write out a file of instantaneous snr

%WARNING: auto-loops noise to at least clean length
%WARNING: START_BEHAVIOR = 'loop' has been removed
% START_BEHAVIOR = 'default';
%default behavior: deterministically chooses the first clean length of noise
% START_BEHAVIOR = 'rand'; %starts at a random index in the noise file,
%chosen from the clean window
%this is useful when we want to not use the same start noise sequence in 
% every mixed file, but the noise length is comparable to the clean length
% START_BEHAVIOR = 'rand_longnoise'; %starts at a random index in the noise file,
%chosen the possible overlap (without further looping) of the clean window
%with the noise file
%this is useful when the noise file is very long, and we want to take a
%random chunk of it every time
START_BEHAVIOR = 'auto';
%chooses between 'rand' and 'rand_longnoise' based on data length
RAMP_BEHAVIOR = 'ramp';
%RAMP_BEHAVIOR = 'ramp'; %whether to implement a 9-sample ramp at the
%beginning of the noise to eliminate pops/clicks on startup
MEAN_BEHAVIOR = 'remove'; %whether to remove the mean from the noise
CLIP_BEHAVIOR = 'dont_abort'; %whether to abort the write of clipped files
SILENCE_THRESHOLD = 0; %1e-4; %the level of "silence" in the signal below which the signal is not counted in the power calc
VERBOSE = 0;

fprintf(logFileName);
fprintf('\n');
if (nargin == 1)
	[cleanFileList, noisyFileList, targetFileList, snrList] = textread(logFileName,'%s %s %s %s');
    filestoprocess = length(cleanFileList);
    fprintf('Found %d lines to process in input file %s\n',filestoprocess,logFileName);
else
	if (nargin < 4)
        fprintf('Format: cleanfile, noisefile, targetfile, snr\n');
        fprintf('     or a single file containing list in above format\n');
        return;
    else
        cleanFile = logFileName;
        filestoprocess = 1;
    end
end

if VERBOSE>0
    fprintf('behavior strings: start: %s ramp: %s mean: %s\n',START_BEHAVIOR,RAMP_BEHAVIOR,MEAN_BEHAVIOR);
end
for jkl = 1:filestoprocess % noise type iteration
    if(nargin == 1)
        cleanFile = cleanFileList{jkl};
        noisyFile = noisyFileList{jkl};
        targetFile = targetFileList{jkl};
        snr = str2num(snrList{jkl});
    end
    if VERBOSE>0
    fprintf('Reading clean file %s\n',cleanFile);    %{jkl}
    end
    %[cleanSignal, fs, nbits_s] = audioread(cleanFile);
    [cleanSignal, fs] = audioread(cleanFile);
    cleanSignal = cleanSignal(:, 1);
    if VERBOSE>0
    fprintf('Reading noise file %s\n',noisyFile);
    end
    % [noiseSignal, fs_n, nbits_n] = audioread(noisyFile);
    [noiseSignal, fs_n] = audioread(noisyFile);
    noiseSignal = noiseSignal(:, 1);
    
%     if (nbits_s ~= nbits_n)
%         error('The format of noise and signal does not match.  Exiting.');
%         return;
%     end   
    if(fs_n ~= fs)
        noiseSignal = resample(noiseSignal, fs, fs_n);
        if VERBOSE>0
        fprintf('Warning: resampling noise to match clean rate (%d to %d)\n',fs_n,fs)
        end
    end
	noise_len = length(noiseSignal);
    clean_len = length(cleanSignal);
    if (clean_len > noise_len)
        if VERBOSE>0
        fprintf('Warning: looping noise to match clean input length\n')
        end
    end
    %WARNING: noise is auto-looped to be at least the clean length
    while (clean_len > noise_len)
		noiseSignal = [noiseSignal;noiseSignal];
        noise_len = length(noiseSignal);
    end
    if strcmp(START_BEHAVIOR,'auto')
        if (2*clean_len < noise_len)
            START_BEHAVIOR='rand_longnoise';
        else
            START_BEHAVIOR='rand';
        end
    end
    if strcmp(START_BEHAVIOR,'rand_longnoise') && (2*clean_len > noise_len)
        START_BEHAVIOR='rand';
        if 1 %VERBOSE>0
        fprintf('Warning: rand_longnoise assumption violated, defaulting to rand behavior\n')
        end
    end
    if strcmp(START_BEHAVIOR,'rand')
        %this variant assumes that the noisy file length is at least the
        %clean length, but not significantly longer
        %start time for noise is chosen randomly from the clean length, noise is
        %looped once if necessary
        rn = rand(1);
        nst = 1+round(rn*(clean_len-1));
        ned = nst+clean_len-1;
        if ned>noise_len
            noiseSignal = [noiseSignal;noiseSignal];           
        end
        noiseSignal = noiseSignal(nst:ned);
        if VERBOSE>0
            fprintf('noise start %d end %d\n',nst,ned)
        end
    elseif strcmp(START_BEHAVIOR,'rand_longnoise')
        %this variant assumes that the noisy file length is much longer
        %than the clean length (i.e., Spirent)
        %start time for noise is chosen from the non-looped overlap
        
        rn = rand(1);
        stw = noise_len-clean_len+1;
        nst = 1+round(rn*(stw-1));
        ned = nst+clean_len-1;
        %WARNING: looped if necessary.  should never be necessary.
        if ned>noise_len
            noiseSignal = [noiseSignal;noiseSignal];            
        end
        noiseSignal = noiseSignal(nst:ned);
        if VERBOSE>0
            fprintf('noise start %d end %d\n',nst,ned)
        end
    else %default behavior, use the start time of the noise file
        nst=1;
        ned = clean_len;
        noiseSignal = noiseSignal(nst:ned);
    end
    if strcmp(RAMP_BEHAVIOR,'ramp')
        noiseSignal(1:9) = noiseSignal(1:9).*[0.0245 0.0955 0.2061 0.3455 0.5000 0.6545 0.7939 0.9045 0.9755]';
    end
%    noiseSignal = noiseSignal(nst:ned);
    noise_len = length(noiseSignal);
    if VERBOSE>1
    fprintf('Using snr %2.1f\n',snr)
    end
%         
% 	cleanSignal = energyNormalize(cleanSignal);
%   noiseSignal = energyNormalize(noiseSignal);
% 		
    %framesize = 80;
    %frames = ceil(clean_len/framesize); 
    %actual_snr = zeros(frames,1);
    if (snr == inf)
        noisySignal = cleanSignal;
        actual_snr = inf*ones(frames,1);
    elseif (snr == -inf)
        noisySignal = noiseSignal;
        actual_snr = -inf*ones(frames,1);
    else
        % Calculate noise power
        if strcmp(MEAN_BEHAVIOR,'remove') %MEAN_BEHAVIOR=='remove'
            nmean = mean(noiseSignal);
            noiseSignal = noiseSignal - nmean;
%             cmean = mean(cleanSignal);
%             cleanSignal = cleanSignal - cmean;
        end
        if SILENCE_THRESHOLD > 0 %"silence," level as defined by SILENCE_THRESHOLD, is not considered in the power calc
            nsv = noiseSignal(abs(noiseSignal)>SILENCE_THRESHOLD);
            csv = cleanSignal(abs(cleanSignal)>SILENCE_THRESHOLD);
            Pn = nsv'*nsv/length(nsv);
            Px = csv'*csv/length(csv);
        else
            Pn = noiseSignal'*noiseSignal/noise_len;
            Px = cleanSignal'*cleanSignal/clean_len;
        end

        %fprintf('Found signal power %f, noise power %f\n',Px,Pn)
        signal_offset = noise_len - clean_len + 1;
        % Scale the noise segment to obtain the desired snr = 10*log10(Px/(sf^2 * Pn))
        if Pn>1e-9 %trap the zero noise power condition
            sf = sqrt(Px/Pn/(10^(snr/10)));		% scale factor
        else
            sf = 0.0; %where noise power is nonexistent, output clean speech
            fprintf('WARNING: noise power below threshold in %s\n',noisyFile)
        end
        if VERBOSE>1
        fprintf('Adjusting noise by scale factor %f\n',sf)
        end
        noisySignal = noiseSignal * sf;
%         for f_ind=1:frames
%             st = framesize*(f_ind-1) + 1;
%             ed = min([st + framesize - 1, clean_len]);
%             actual_snr(f_ind) = 10*log10((cleanSignal(st:ed)'*cleanSignal(st:ed))/(noisySignal(st:ed)'*noisySignal(st:ed)));
%         end
        noisySignal(signal_offset:end) = noisySignal(signal_offset:end) + cleanSignal;
        %Pt = noisySignal'*noisySignal
        nbits_s = 16;
        
        
        maxAllowedVal = double(intmax('int16'))/(double(intmax('int16'))+1); %(2^(nbits_s-1)-10)/2^(nbits_s-1); %
        minAllowedVal = -1; %-(2^(nbits_s-1)-10)/2^(nbits_s-1);
        if ((max(noisySignal) >= maxAllowedVal) || (min(noisySignal) < minAllowedVal))
            if ~strcmp(CLIP_BEHAVIOR,'abort')
                %fprintf('Clipping output to avoid overflow in %s\n',targetFile);
                noisySignal(noisySignal >= maxAllowedVal) = maxAllowedVal;
                noisySignal(noisySignal < minAllowedVal) = minAllowedVal;
            else
                %fprintf('Aborting write due to overflow in %s\n',targetFile);
                break;
            end
        end

    end
    if VERBOSE>0
    fprintf('Writing target file %s\n',targetFile); %(jkl)
    end
    %wavwrite(noisySignal, fs, nbits_s, targetFile);
    audiowrite(targetFile, noisySignal, fs);
    
    if ACTUAL_SNR_OUT == 1
        targetFile = [targetFile(1:end-4),'_snr.txt'];
        save(targetFile,'actual_snr','-ascii');
    end
end

return;

function normalized_signal = energyNormalize(signal)

signal = signal - mean(signal);
normalized_signal = signal/sqrt(var(signal));

return;

function normalized_signal = ampNormalize(signal)

signal = signal - mean(signal);
normalized_signal = signal/max(abs(signal));

return;
