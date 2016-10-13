function [audio_h, w_out, spec_hat, mfcc_hat] = utterance(src_spkr, tgt_spkr, audio, sr, varargin)

if(size(src_spkr.centroids,1) ~= size(tgt_spkr.centroids,1))
    error('Source and target speaker have different number of features.');
end

p = inputParser;

defaultSynthesis = 'STRAIGHT';
defaultSpectralUpdate = 1;
defaultBasis     = 2:24;
defaultLambda    = 0.025;

expectedSynthesis = {'STRAIGHT'};

addOptional(p,'lambda',defaultLambda,@isnumeric);
addOptional(p,'update',defaultSpectralUpdate,@isnumeric);
addOptional(p,'basis',defaultBasis,@(x) all(isnumeric(x) && x>0));
addOptional(p,'synthesis',defaultSynthesis, @(x) any(validatestring(expectedSynthesis)));

parse(p,varargin);

basis   = p.Results.basis;
penalty = p.Results.lambda;

%% Extract source utterance MFCCs

[ src_f0, src_spec, src_ap ] = config.load_straight( audio, sr, 0 );

src_mfcc = spectrum.spec2mfcc(src_spec, sr, 24, 0);

%% Build SABR representation and estimate target speaker spectrum

w_out    = sabr.build.weights(src_spkr, src_mfcc, penalty, basis);
mfcc_hat = [src_mfcc(1,:); tgt_spkr.centroids(bases,:) * w_out];
spec_hat = spectrum.invmfcc(mfcc_hat(1:24,:),u.sr,size(n3sgram,1));
adj_f0   = vc.adj_f0(src_f0, tgt_spkr.f0_mean, tgt_spkr.f0_std);

%% reconstruct the audio

audio_h = exstraightsynth(adj_f0,spec_hat,src_ap,sr);
audio_h = audio_h ./ 2^15; %as per STRAIGHT documentation, see section 4.1