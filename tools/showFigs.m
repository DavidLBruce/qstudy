%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% showFigs.m
%
% Overview:
%  Brings designated figures forward on the screen.
%
% Usage:
% 
%   showFigs(figs1,figs2, ...);
%
%   If no arguments are passed in all open figures are brought forward.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function showFigs(varargin);

  if (nargin == 0)
    FigVects{1} = curfigs;
    NumVects = 1;
  else
    FigVects = varargin;
    NumVects = nargin;
  end;
  
  for (jj = NumVects:-1:1)
    figs = FigVects{jj};
    QtyFigs = length(figs);
    for (ii = QtyFigs:-1:1)
      figure(figs(ii));
    end;
  end;
  
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
