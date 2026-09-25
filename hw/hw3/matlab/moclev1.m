function moclev1(imn,remake)
% moclev1: make moc level 1 cube

imn=lower(imn);

if exist('remake','var') 
  if remake
    if exist([imn,'.lev1.cub'],'file') delete([imn,'.lev1.cub']); end
  end
end

if ~exist([imn,'.lev1.cub'],'file'),
  moclev0(imn);
  unix(['moclev1.pl ',imn,'.lev0.cub']);
end

