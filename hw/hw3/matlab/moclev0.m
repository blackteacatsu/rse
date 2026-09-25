function moclev0(imn,remake)
% moclev0: make moc level 0 cube

imn=lower(imn);

if exist('remake','var') 
  if remake
    if exist([imn,'.lev0.cub'],'file') delete([imn,'.lev0.cub']); end
  end
end

if ~exist([imn,'.lev0.cub'],'file'),
  [ind,cdname,cdpath]=find_moccd(imn);
  %unix(['moclev0.pl /home/marsdata/mars/MOC/data/',cdname,'/',cdpath]);
unix(['moclev0.pl /home/marsdata/mars/MOC/data/mgsc_1242/e23000/e2300003.imq']);
end

