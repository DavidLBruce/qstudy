% getFig.m
%
% fig = getFig(tag);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fig = getFig(tag);

  fig = findobj('tag',tag);
  if (isempty(fig))
    fig = figure;
    set(fig,'tag',tag);
  end;

  set(fig, 'NumberTitle','off');
  set(fig, 'Name',[num2str(fig), ':  ',tag]);

  figure(fig);
  clf;
  orient landscape;

return;
