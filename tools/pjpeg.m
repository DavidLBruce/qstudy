% pjpeg.m
%
% Overview:
%  Sets orientation to portrait.  Prints the open figures specified 
%  in the input vector as color jpeg files.  The figure 
%  number will be appended to the fileBaseName.
%
% Usage:
%  
%  pjpeg(figVec, fileBaseName);
%
% Modified for Octave
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pjpeg(figVec, fileBaseName);

  for (ii=1:length(figVec))
    fig = figVec(ii);
    orient(fig, 'portrait');

    fileName = sprintf('%s_%02d', fileBaseName, fig);

    print(fig, fileName, '-djpeg');
    orient(fig, 'landscape');
  end;

return;


