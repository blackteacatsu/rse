function scalebar(aa,pw,ari,pos,style,clr,fs)

% draw scalebar on image aa
% the image has pixel width pw (in meters) and aspect ratio ari
% optional argument pos describes where to put the scalebar
% optional argument style can be 
%        'none'  no scalebar
%        'fat'  fat horizontal scalebar
%        'sidebar' horizontal scalebar with vertical deliminators

buf=5;

if nargin<4
  pos=1;
end
if nargin<5
  style='fat';
end

if (pw<0 | ari<0) 
  error('parameters must be positive');
end

hold on
sdi=min([size(aa,1),size(aa,2)])/20;
if sdi<8, sdi=8; end;

margin=min([8,ceil(size(aa,1)/75)]);

if nargin<7
  fs=10;
  if (ari*size(aa,1)/size(aa,2)<3)
    fs=12;
  end
end

sdix=margin+buf;
sdiy=size(aa,1)-margin/ari;

% length of scale bar
%sbl=200;
sbl=ceil(size(aa,2)/5*pw/100)*100;

nset=[1,2,3,4,5,6];
sbl0=size(aa,2)/5*pw;
for j=1:100
  if mod(j,length(nset))==0,
    nset=nset*10;
  end
  sbl=nset(mod(j,length(nset))+1);
  if sbl>sbl0, 
    break; 
  else
    sblold=sbl;
  end
end
sbl=max(sblold,100);
if sbl>1000
  sbl=round(sbl/1000)*1000;
end
ll=sbl/pw;

clr='k';
%set(fill([30,30+ll+20,30+ll+20,30,30],[30,30,60,60,30],.6.*[1,1,1]),'edgecolor','none');

if (sbl<2000) 
h_t=text(sdix+ll/2,sdiy,[num2str(sbl),' m']);
else
h_t=text(sdix+ll/2,sdiy,[num2str(sbl/1000),' km']);
end;

set(h_t,'vert','bot','hori','cen', 'fontsize', fs, 'color', clr,'fontname','times');
t_extent=get(h_t, 'extent');
theight=t_extent(4);  % height of text
t_extent(3)=t_extent(1)+t_extent(3); t_extent(4)=t_extent(2)-t_extent(4);

h_bar=plot(sdix+[0,ll],t_extent(4)+[0,0],[clr,'-'],'linewidth',3);
switch style
 case 'fat'
  set(h_bar,'linewidth',4)
 otherwise
  error(['No valid scalebar style',style])
end

bar_x=get(h_bar, 'xdata');
bar_y=get(h_bar, 'ydata');
 
rectx=minmax([bar_x(1)-buf, bar_x(2)+buf, t_extent(1)-buf, t_extent(3)+buf] );
recty=minmax([bar_y(1)-buf, bar_y(2)+buf, t_extent(2), t_extent(4)]);

% draw rectangle
h_rect=fill([rectx(1),rectx(2),rectx(2),rectx(1)]...
	    ,[recty(1),recty(1),recty(2),recty(2)]...
	    ,[.8,.8,.8],'edgecolor', 'none');
set(h_rect,'facealpha',.8)

%h_rect=rectangle('position',[rectx(1), recty(1), (rectx(2)-rectx(1)), (recty(2)-recty(1))],'edgecolor', 'none', 'facecolor', 'b')

