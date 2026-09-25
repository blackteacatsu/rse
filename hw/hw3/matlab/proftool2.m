function varargout=proftool()
% proftool: interactive profile extraction tool
%
% Usage:
%   [xp,yp,zp,dp]=proftool(x,y,z[,method]);
% or
%   [xp,yp,zp,dp]=proftool(z[,method]);
% 
%s

% Oded Aharonson
% 


disp('Extracting profile...')

button=1;

disp('Left click starting point');
[x1(1),y1(1),button]=ginput(1);

imf=gcf;
ima=gca;
imh=findobj(gca,'type','image');
if length(imh)==0,
    disp('This axis does not contain an image...');
    return
end

imh=imh(1);
z=get(imh,'cdata'); %constant
xd=get(imh,'xdata'); yd=get(imh,'ydata'); %constant
xd=minmax(xd); yd=minmax(yd); %constant
xi=[1,size(z,2)]; yi=[1,size(z,1)]; %constant

%initialize...
xi1=zeros(0); yi1=zeros(0); di=zeros(0);
xip=x1; yip=y1; dip=zeros(1);
x1a=x1; y1a=y1; da=zeros(1);
disp('Left click next point, right click to end');
[x1(end+1),y1(end+1),button]=ginput(1);
while button==1,
  
  xi1temp=interp1(xd,xi,x1(end-1:end));  yi1temp=interp1(yd,yi,y1(end-1:end));
  xi1=cat(1,xi1,xi1temp); yi1=cat(2,yi1,yi1temp);
  
  ditemp=2.*sqrt(diff(xi1temp).^2+diff(yi1temp).^2);
  di=di+ditemp;
  
  xiptemp=linspace(xi1temp(1),xi1temp(2),ditemp);
  yiptemp=linspace(yi1temp(1),yi1temp(2),ditemp);
  xip=cat(2,xip,xiptemp(2:end));
  yip=cat(2,yip,yiptemp(2:end));
  diptemp=dip(end)+sqrt((xi1temp(2:end)-xi1temp(1)).^2+(yi1temp(2:end)-yi1temp(1)).^2);
  dip=cat(2,dip,diptemp);
  
  x1atemp=linspace(x1(end-1),x1(end),ditemp);
  y1atemp=linspace(y1(end-1),y1(end),ditemp);
  x1a=cat(2,x1a,x1atemp(2:end)); y1a=cat(2,y1a,y1atemp(2:end));
  
  
  datemp=da(end)+sqrt((x1atemp(2:end)-x1atemp(1)).^2+(y1atemp(2:end)-y1atemp(1)).^2);
  da=cat(2,da,datemp);
  
  zip=interp2(z,xip,yip);

  if ~exist('olh','var'), hold on; olh=plot(nan,nan,'w-');  end
  if ~exist('plh','var'), figure;  plh=plot(nan,nan,'.-'); figure(imf); end

  set(olh,'xdata',x1,'ydata',y1);
  
  set(plh,'xdata',da,'ydata',zip);
    %    if (abs(diff(da))>0 & abs(diff(zip))>0)
  set(get(plh,'parent'),'xlimmode','auto','ylimmode','auto')
    %end
  
  disp('Left click to choose next point, right click to end.');
  [x1(end+1),y1(end+1),button]=ginput(1);
  %[x1,y1,button]=ginput(1);
  %if button==1,   set(olh,'xdata',nan,'ydata',nan); end;
end

if nargout==4
    varargout(1)={x1a};
    varargout(2)={y1a};
    varargout(3)={zip};
    varargout(4)={da};
end

