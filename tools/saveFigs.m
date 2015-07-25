%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% saveFigs.m
%
% Overview:
%  Saves selected figures to a folder in .fig format.
%
% Usage:
%  saveFigs(figVec, 'path/to/figure/folder/baseName');
%
%  If the path to the figure folder does not exist it will be created.  Figure
%  file names will be baseName_XX.fig, where xx is the figure number.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveFigs(figvec, figname)

  DIR = 7;

  idxDelim = sort([findstr(figname,'/'), findstr(figname,'\')]);
  if (~isempty(idxDelim))
    % Create directories, if necessary
    if (exist(figname(1:idxDelim(end))) ~= DIR)
      if (idxDelim(1) == 1) 
        % Absolute path
        idxDelim = idxDelim(2:end);
      end;
      for (idx = idxDelim)
        dirstr = figname(1:idx);
        if (~exist(dirstr, 'dir'))
          disp(['Making directory:  ', dirstr]);
          mkdir(dirstr);
        end;
      end;
    end;
  end;

  for (fig = figvec)
    tag = get(fig, 'tag');
    set(fig, 'tag','');
    savestr = [figname, '_',sprintf('%02d',fig), '.fig'];
    disp(savestr);
    saveas(fig,savestr);
    set(fig, 'tag',tag);
    pause(1);
  end;


return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
