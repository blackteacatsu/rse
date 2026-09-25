function varargout=minmax(x,varargin);
% minmax: function to return min and max of input in an array.

if nargin==1,
  mm(1)=min(x(:));
  mm(2)=max(x(:));
else
  mn=min(x,varargin{:});
  mx=max(x,varargin{:});
  mm=squeeze(cat(ndims(mn)+1,mn,mx));
end
if ((nargout==1) | (nargout==0)),
  varargout{1}=mm;
elseif nargout==2,
  varargout{1}=mm(1);
  varargout{2}=mm(2);
else
  error('minmax: must supply exactly 0, 1, or 2 output arguments!');
end