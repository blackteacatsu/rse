function varargout=sgrdread(fn)
% sgrdread: safe call to grdread
% [x,y,z,d]=sgrdread(fn)
%
% mygrdread: wrapper function to grdread.
%
% Checks if files exists first to avoid crashes
%

varargout=cell(nargout,1);

if exist(fn,'file') 
  [varargout{:}]=grdread(fn);
else
  error([fn,' does not exist!']);
end
