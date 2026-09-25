function [c,d]=pclin(name,varargin)

if (length(varargin)>3) disp('Error: too many arguments'); return; end
if length(varargin)==3 albedo=varargin{1}, sl=varargin{2}, shadow=varargin{3}, end
if length(varargin)==2 albedo=varargin{1}, sl=varargin{2}, shadow=-1; end
if length(varargin)==1 albedo=varargin{1}, sl=-1; shadow=-1; end
if length(varargin)==0 albedo=-1; sl=-1; shadow=-1; end

%inputs - albedo,sl,shadow
%name    = ['m0201989.asp.cub'];	%Name of file to read in.
res     = 2.95;	     		        %Size of pixels in meters.
sunaz   = 320.65;			%Solar Azimuth.
inc_ang = 48.18;			%Inclination Angle.
lines = 5248;                           %Number of lines in the image
samples=1024;                           %Number of samples in the image

%[status,result]=unix('grep --binary-files=text SUN m0806185.lev1.cub');
%if length(result)==0
fid=fopen([name],'r','l');
%else
%fid=fopen([name],'r','b');
%end



temp=fread(fid,'float');
temp=temp(end-lines*samples+1:end);
image=reshape(temp,samples,lines);
imagesc(image')
hold on;
axis equal; axis tight; axis xy; colormap(gray)
set(gca,'XTickLabel',{})
ylabel('Line Number');

imagewidth=size(image,1);
imageheight=size(image,2);

if (sl<1)
 sl = 3000;    %Start line of profile
 disp('Picked default value for starting line of 6000')
end

if (sl>17540)
 sl = 3000; %Start line of profile
 disp('You will fall off the edge of the image!! Setting sl to 3000...')
end

xx=1:imagewidth;
yy=fliplr(xx).*tan(sunaz*(pi/180.0));
b  = image(sub2ind(size(image),fliplr(xx),round(yy)+sl));
plot(fliplr(xx),round(yy)+sl,'r');
set(gca,'Xdir','reverse')

figure;
imagesc(image')
hold on;
axis equal; axis xy; colormap(gray)
ylim([min(round(yy)+sl),max(round(yy)+sl)]);
plot(fliplr(xx),round(yy)+sl,'r');
text(xx(end),round(yy(1))+sl+100,'A','fontsize',14,'fontweight','bold','verticalalignment','top');
text(xx(1),round(yy(end))+sl,'B','fontsize',14,'fontweight','bold','verticalalignment','bottom','horizontalalignment','right');
xlabel('Sample Number')
ylabel('Line Number')

if (shadow < 0)
    shadow = 0; %Default Shadow Brightness
    disp('Picked Default Shadow Brightness of 0.0 in I/F units')
end

if (shadow > min(b))
 shadow = min(b);			%Max Shadow Brightness
 disp(['Max Default Shadow Brightness is ',num2str(min(b)),'...Using that value.']);
end

b=b-shadow;

if (albedo < 0 | albedo > 1) 
 albedo=median(b.*pi);
 disp(['Albedo not valid. Guessed an albedo of ',num2str(albedo)])
end

z = acos(b.*pi.*cos(inc_ang*(pi/180.0))./albedo) - (inc_ang*(pi/180.0));
z = res.*tan(z);
for i=2:length(z)
    z(i) = z(i-1)-z(i);
end
d = ([0:(length(z)-1)]+0.5).*res;
set(gca,'Xdir','reverse')

figure; plot(d,z);
xlabel('Distance (meters)');
ylabel('Height (Arbitrary Units)');
text(d(1)+10,min(z),'A','fontsize',14,'fontweight','bold')
text(d(end)+30,min(z),'B','fontsize',14,'fontweight','bold')
title('Photoclinometry Profile of m0806185','fontsize',14)
