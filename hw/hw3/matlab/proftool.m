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
while button==1,
  disp('Left click starting and ending points');
  [x1,y1,button]=ginput(2);
  
  imf=gcf;
  ima=gca;

  imh=findobj(gca,'type','image');
  
  if length(imh)==0,
    disp('This axis does not contain an image...');
    return
  end
  
  imh=imh(1);
  z=get(imh,'cdata');
  
  xd=get(imh,'xdata'); yd=get(imh,'ydata');
  xd=minmax(xd); yd=minmax(yd);
  xi=[1,size(z,2)]; yi=[1,size(z,1)];

  xi1=interp1(xd,xi,x1);  yi1=interp1(yd,yi,y1);
  
  di=2.*sqrt(diff(xi1).^2+diff(yi1).^2);
  
  xip=linspace(xi1(1),xi1(2),di);
  yip=linspace(yi1(1),yi1(2),di);
  dip=sqrt((xip-xip(1)).^2+(yip-yip(1)).^2);
  
  x1a=linspace(x1(1),x1(2),di);
  y1a=linspace(y1(1),y1(2),di);
  da=sqrt((x1a-x1a(1)).^2+(y1a-y1a(1)).^2);
  
  zip=interp2(z,xip,yip);

  if ~exist('olh','var'), hold on; olh=plot(nan,nan,'w-');  end
  if ~exist('plh','var'), figure;  plh=plot(nan,nan,'.-'); figure(imf); end

  set(olh,'xdata',x1,'ydata',y1);
  set(plh,'xdata',da,'ydata',zip);
    %    if (abs(diff(da))>0 & abs(diff(zip))>0)
  set(get(plh,'parent'),'xlimmode','auto','ylimmode','auto')
    %end
  
  disp('Left click to reset, right click to end.');
  [x1,y1,button]=ginput(1);
  if button==1,   set(olh,'xdata',nan,'ydata',nan); end;
end
