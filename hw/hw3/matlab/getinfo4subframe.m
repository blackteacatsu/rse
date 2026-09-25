function [nori,soli,pwi,ari]=getinfo4subframe(name,method)

% This subroutine provides north azimuth, solar azimuth, pixel
% width, and pixel aspect ratio to the subroutines subframe*.m

persistent cumindex

switch method
  
 case 1  % from *.txt file
  %fn='overlap.txt';
  fn='/home/norbert/Streaks/final.3.3.txt';
  [n,lon,lat,siz,dat,Ls,flip,nor,sol,pw,ar]=textread(fn,['%s %f %f %f %s %f %s %f %f %f %f']);
  i=find(strcmp(name,n));
  if isempty(i) 
    error('Error: aspect ratio not found in file.');
  end
  ari=ar(i); pwi=pw(i);
  soli=sol(i); nori=nor(i); 
  disp(['Read ',char(name)]);

  if strcmp(flip(i),'F')
    aa=fliplr(aa);
    disp('Flipped image');
  end
  
 case 2  % from MOC matlab cumindex 
  if isempty(cumindex)
    if ~exist('/home/oa/mars/MOC/index/cumindex.mat','file'),
      error('Cumindex file not found');
    end
    disp('Reading cumindex mat file...')
    load /home/oa/mars/MOC/index/cumindex.mat;
  end
  sfn=cumindex.FILE_SPECIFICATION_NAME(:,9:16);
  k=strmatch(name,sfn);
  nori=cumindex.NORTH_AZIMUTH(k);
  soli=cumindex.SUB_SOLAR_AZIMUTH(k);
  pwi=cumindex.SCALED_PIXEL_WIDTH(k);
  ari=cumindex.PIXEL_ASPECT_RATIO(k);

 otherwise
  error('no valid method')
end



