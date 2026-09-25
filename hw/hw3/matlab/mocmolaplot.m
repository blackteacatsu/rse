function [time,y,x,z,d]=mocmolaplot(imname)


%load TIFF header for image
geo=load([imname,'.tfw']);
%read in MOLA header
%[temp,header_line]=unix(['grep -n C_END ',imname,'.asc']);
%header_line=str2num(header_line(end-9:end-7));
header_line=164;
%get MOLA data
[mola(:,1),mola(:,2),mola(:,3),mola(:,4)]=textread([imname,'.asc'],'%f%f%f%f','headerlines',header_line);
%read in TIFF file
a=imread([imname,'.tif']);
%read in GEOTIFF header for image
clon=textread([imname,'_clon.txt'],'CENTER_LONGITUDE = %f'); %center longitude of projected MOC image

%set up vectors for image lat,lon
X=[geo(5):geo(1):geo(5)+size(a,2)*geo(1)];
Y=[geo(6):geo(4):geo(6)+size(a,1)*geo(4)];

%set up a matlab map projection structure
mstruct=defaultm('sinusoid');
mstruct.origin=[0,clon,0];
mstruct.geoid=[3396190, sqrt(1-3376200^2/3396190^2)];
mstruct = defaultm(mstruct);

%map project MOLA data
[mola(:,3),mola(:,2)]=projfwd(mstruct,mola(:,2),mola(:,3));

%mola(:,3)=(mola(:,3)-clon).*cos(mola(:,2)*pi/180)*(pi*3396.19/180)*1000;
%mola(:,2)=mola(:,2)*(pi*3396.19/180)*1000;




subplot(1,2,1) 
%plot image 
imagesc(X,Y,a)
     axis equal; axis xy;
colormap gray
     %caxis([75,175])
hold on
plot(mola(:,3),mola(:,2),'r','linestyle','none','marker','.')
axis off
     title('MOC-NA image M1000782')
     yax=get(gca,'ylim');

     
subplot(1,2,2)
plot(mola(:,4),mola(:,2),'linestyle','-','marker','.')
     axis xy;
     xlabel('elevation (meters)')
set(gca,'YTickLabel',{})
title('MOLA elevation for M1000782')
     ylim(yax);

     time=mola(:,1);
     y=mola(:,2);
     x=mola(:,3);
     z=mola(:,4);
     d=(mola(:,2).^2+mola(:,3).^2).^.5;
     d=d-min(d);
