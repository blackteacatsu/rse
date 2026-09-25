function subframeraw(name)

% display subframes of moc images from raw image data (imq files)
% scalebar and arrows for north and subsolar azimuth can be included

if ~exist('name','var'), name='m0401865'; end;

clf;

%name='M1301037'
%name='E1101360'
%name='M1001605'
%name='E0600053'
%name='M0903273'
%name='M0305458'
%name='E0900474'
%name='E0502221'
%name='M0401865'
%name='M0306047'

set(gcf,'name',name)

% Source of image file
ipath='/home/ge151/lab3/test/';

method=2;
[north,sol,pwi,ari]=getinfo4subframe(upper(name),method);

addpath /home/oa/matlab/
addpath /home/oa/matlab/pds
disp(['Read ',char(name)]);
if ~exist([ipath,lower(name),'.lev1.cub'],'file'),
  moclev1(name);
  %error(['Error: file does not exist!']);
  unix(['mv -i ',lower(name),'.lev1.cub',ipath]);
end
aa=read_cub([ipath,lower(name),'.lev1.cub']);
aa(aa<-1.e38)=NaN;

marker=1;
r=0;
pos=1;
AL=NaN; cdi=NaN;
dirs=1;
%siz=size(aa)
%cor=[1,1]
switch upper(name)
   case 'M1101764'; cor=[1,500]; siz(1)=200;
   case 'M1301037'; cor=[700,100]; siz(1)=600; 
   case 'E1101360'; cor=[6600,170]; siz(1)=200; 
   case 'M1001605'; cor=[1780,300]; siz(1)=201; 
   case 'E0600053'; cor=[4350, 100]; siz(1)=180;
   case 'M0903273'; cor=[1950, 10]; siz(1)=420;
   case 'M0305458'; cor=[960,200]; siz(1)=196;  %maybe
   case 'E0900474'; cor=[2280,250]; siz(1)=160;
   case 'E0503583'; cor=[2340,15]; siz(1)=130;
   case 'M0401865'; cor=[110,1]; siz(1)=320;  
   case 'M0306047'; cor=[10150,60]; siz(1)=124;

   case 'M0307528'; cor=[250,45]; siz(1)=200;
   case 'M0403806'; cor=[1,1]; siz(1)=190;
   case 'M0703450'; cor=[780,1]; siz(1)=240;
   case 'M0800442'; cor=[1140,1]; siz(1)=230

   otherwise, disp('Showing entire image.');
end
siz(2)=siz(1)*ari;


%aa=aa(cor(1)+(0:(siz(1)-1)),cor(2)+(0:(siz(2)-1)));

%xmax=floor((cor(1)+siz(1)-1));
%ymax=floor((cor(2)+siz(2)-1));

%aa=aa(cor(1):xmax,cor(2):ymax);
%size(aa)

%aa=aa(10140:10290,60:(150*ari)-1);

aa=aa(500:2500,:);
if (north<180)   %% make north up
  disp('Rotating image');
  aa=rot90(rot90(aa));
  north=north+180.;
  sol=sol+180.;
end

mi=prctile(aa(:),0.2);
ma=prctile(aa(:),99.8);
aa(aa<mi)=mi;
aa(aa>ma)=ma;
imagesc(aa); 

set(gca,'da',[ari,1,1]);
%axis equal off;
axis off;
colormap(gray);

hold on

%cdi=40; AL=40;
if isnan(AL), AL=size(aa,2)/10; end;
if isnan(cdi), cdi=size(aa,2)/10; end;
fprintf(1,'size(aa)= %d %d\n',size(aa,1),size(aa,2));
fprintf(1,'AL=%f cdi=%f\n',AL,cdi);
if dirs
  directions2(cdi,AL,ari,north,sol,12);
end
pos=2;
scalebar2(aa,pwi,ari,pos);

hold off

%print -deps2 m0806185.eps

