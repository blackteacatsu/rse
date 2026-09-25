function directions2(cdi,AL,ari,north,sun,fs,clr)
% north and sun in degrees

imwidth=diff(get(gca,'xlim'));
imheight=diff(get(gca,'ylim'));

margin=8;

if nargin<8, clr='k'; end;
set(gcf,'inverthardcopy','off','color',[0.8 0.8 0.8],'color','w'); % default
switch clr
 case 'k'
  col1='k'; col2='k';
 case 'w'
  col1='w'; col2='w';
  set(gcf,'inverthardcopy','off','color','none');
 case 'y'
  col1='k'; col2='y';
end

if nargin<7
  fs=12; % default fontsize
end

% convert azimuths to radians
north=north*pi/180;
sun=sun*pi/180;

start=[0,0];
l=imwidth*.1;
nscale=1.25;
sscale=1.25;

n_stop=[(l*cos(north)), (l*sin(north))/ari];
s_stop=[(l*cos(sun)), (l*sin(sun))/ari];

nx=((nscale*l)*cos(north));
ny=((nscale*l)*sin(north)/ari);
sx=((sscale*l)*cos(sun));
sy=((sscale*l)*sin(sun)/ari);

% offsets 
xoff=imwidth;
yoff=0;

h_n=text(nx+xoff, ny+yoff, 'N','color',col1,'fontweight','bold', 'fontn','times','fontsize',fs, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

%h_s=text(sx+xoff, sy+yoff, '*','color',col2,'fontweight','bold', 'fontn','courier','fontsize',fs*2, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
%hse=get(h_s,'extent'); set(h_s,'pos',get(h_s,'pos')+[0,hse(4)/3,0]);
hne=get(h_n,'extent'); hne(3)=hne(1)+hne(3); hne(4)=hne(2)-hne(4);
%hse=get(h_s,'extent'); hse(3)=hse(1)+hse(3); hse(4)=hse(2)-hse(4);

h_s=plot(sx+xoff, sy+yoff,'*','markers',9, 'color', col2);
h_ssize=get(h_s, 'markersize');

hse_x=get(h_s, 'xdata');
hse_y=get(h_s, 'ydata');
hse=[hse_x-h_ssize/2-3, hse_y+(h_ssize/ari), hse_x+h_ssize/2+3, hse_y-(h_ssize/ari)];

corrx=min([0,imwidth-max([hne(3),hse(3)])]);
corry=max([0,-min([hne(4),hse(4)])]);

xoff=xoff+corrx-margin/2;
yoff=yoff+corry+margin/2/ari;

delete(h_n); delete(h_s);

h_n=text(nx+xoff, ny+yoff, 'N','color',col1,'fontweight','bold', 'fontn','times','fontsize',fs, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
%h_s=text(sx+xoff, sy+yoff, '*','color',col2,'fontweight','bold', 'fontn','courier','fontsize',fs*2., 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
%hse=get(h_s,'extent'); set(h_s,'pos',get(h_s,'pos')+[0,hse(4)/3,0]);

h_s=plot(sx+xoff, sy+yoff,'*','markers',9,'color', 'k');
h_ssize=get(h_s, 'markersize');
hse_x=get(h_s, 'xdata');
hse_y=get(h_s, 'ydata');
hse=[hse_x-h_ssize/2-3, hse_y+(h_ssize/ari), hse_x+h_ssize/2+3, hse_y-(h_ssize/ari)];

hne=get(h_n,'extent'); hne(3)=hne(1)+hne(3); hne(4)=hne(2)-hne(4);
%hse=get(h_s,'extent'); hse(3)=hse(1)+hse(3); hse(4)=hse(2)-hse(4);

rectx=minmax([hne(1),hne(3),hse(1),hse(3),xoff+margin]);
recty=minmax([hne(2),hne(4),hse(2),hse(4),yoff+margin/ari]);

% draw rectangle
h_rect=fill([rectx(1),rectx(2),rectx(2),rectx(1),rectx(1)]...
	    ,[recty(1),recty(1),recty(2),recty(2),recty(1)],[.8,.8,.8]...
	    ,'edgecolor', 'none');
set(h_rect,'facealpha',.8);

% put rectangle below text
ch=get(gca,'chil');
tmp=ch(1); ch(1)=ch(3); ch(3)=tmp;
set(gca,'chil',ch);

% plot center
plot(start(1)+xoff,start(2)+yoff,'o','markerfacecolor','k','markersize',5,'color','k');

%% north direction arrow
h_na=arrow('start', start+[xoff,yoff], 'stop', n_stop+[xoff,yoff], 'width', 1, 'length', 5, 'baseangle', 45, 'tipangle', 20);

%% direction of solar illumination arrow
h_sa=arrow('start', start+[xoff,yoff], 'stop', s_stop+[xoff,yoff], 'width', 1, 'length', 5, 'baseangle', 45, 'tipangle', 20);

%h_test=rectangle('position', [hse(1), hse(2)-abs(hse(4)-hse(2)), abs(hse(3)-hse(1)), abs(hse(4)-hse(2))], 'facecolor', 'b');

hold off;
