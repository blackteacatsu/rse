function [ind,cdname,cdpath,cient]=find_moccd(ims)
% find_moccd: find cd and path to moc image from cumindex file

persistent cumindex

ims=upper(ims);

if length(cumindex)==0
  if exist('/home/oa/mars/MOC/index/cumindex.mat','file'),
    disp('Reading cumindex mat file...')
    load /home/oa/mars/MOC/index/cumindex.mat;
  else
    disp('Reading cumindex tab file...')
    cumindex=make_moccumind;
    save /home/marsdata/mars/MOC/index/cumindex cumindex
  end
end


if iscell(ims),
  ind=zeros(length(ims),1);
  cdname=cell(size(ims));
  cdpath=cell(size(ims));
  for i=1:length(ims),
    ind1=strmatch(ims{i},cumindex.FILE_SPECIFICATION_NAME(:,9:end-1));
    if length(ind1)>0,
      ind(i)=ind1;
      cdname{i}=lower(cumindex.VOLUME_ID(ind1,2:end-1));
      cdpath{i}=lower(cumindex.FILE_SPECIFICATION_NAME(ind1,2:end-1));
    else
      ind(i)=-1;
    end
  end
else
  ind1=strmatch(ims,cumindex.FILE_SPECIFICATION_NAME(:,9:end-1));
  if length(ind1)>0,
    ind=ind1;
    cdname=lower(cumindex.VOLUME_ID(ind1,2:end-1));
    cdpath=lower(cumindex.FILE_SPECIFICATION_NAME(ind1,2:end-1));
  else 
    ind=-1;
    cdname=[];
    cdpath=[];
  end
end

nf=fields(cumindex);
if length(ind)>1,
  for i=1:length(ind),
    if ind(i)==-1,
      cient.(nf{j}){i}={};
    else
      for jf=1:length(nf),
	cient.(nf{jf}){i}=cumindex.(nf{jf})(ind(i),:);
      end      
    end
  end
else
  if ind==-1,
    for jf=1:length(nf),
      cient.(nf{jf})={};
    end
  else
    for jf=1:length(nf),
      cient.(nf{jf})=cumindex.(nf{jf})(ind,:);
    end      
  end
end



