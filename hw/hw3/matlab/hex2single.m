function x=hex2single(x)
% hex2single: convert hex string to single precision float

fid=fopen('tmptmp.bin','w');
fwrite(fid,hex2dec(x),'uint');
fclose(fid);

fid=fopen('tmptmp.bin','r');
x=fread(fid,'float');
fclose(fid);

delete('tmptmp.bin');
