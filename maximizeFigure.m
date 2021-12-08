function maximizeFigure(h)

OriginalUnits=get(h,'Units');
set(h,'Units','normalized');
set(h,'Position',[0 -.1 1 1]);
set(h,'Units',OriginalUnits);