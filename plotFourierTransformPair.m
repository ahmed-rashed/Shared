function plotFourierTransformPair(t_col,x_cols,f_col,x_xlabel_Latex,x_Title_Latex,X_xlabel_Latex,X_Title_Latex,y_HorizontalLines,horizontalLinesTextLatex,x_VeticalLines,verticalLinesTextLatex,Y_HorizontalLines,HorizontalLinesTextLatex,X_VeticalLines,VerticalLinesTextLatex,sameScale_yY)

N_Curves=size(x_cols,2);

if (~isempty(horizontalLinesTextLatex) && size(horizontalLinesTextLatex,2)~=1) || (~isempty(verticalLinesTextLatex) && size(verticalLinesTextLatex,2)~=1) || (~isempty(HorizontalLinesTextLatex) && size(HorizontalLinesTextLatex,2)~=1) || (~isempty(VerticalLinesTextLatex) && size(VerticalLinesTextLatex,2)~=1)
    error('horizontalLinesTextLatex, verticalLinesTextLatex, HorizontalLinesTextLatex and VerticalLinesTextLatex must be column vectors');
end

if ~(isempty(y_HorizontalLines) || size(y_HorizontalLines,2)==1 || size(y_HorizontalLines,2)==N_Curves)
    error('y_HorizontalLines must have one column or same number of columns as that of x_mat !!')
end
if ~(isempty(x_VeticalLines) || size(x_VeticalLines,2)==1 || size(x_VeticalLines,2)==N_Curves)
    error('x_VeticalLines must have one column or same number of columns as that of x_mat !!')
end
if ~(isempty(Y_HorizontalLines) || size(Y_HorizontalLines,2)==1 || size(Y_HorizontalLines,2)==N_Curves)
    error('Y_HorizontalLines must have one column or same number of columns as that of x_mat !!')
end
if ~(isempty(X_VeticalLines) || size(X_VeticalLines,2)==1 || size(X_VeticalLines,2)==N_Curves)
    error('X_VeticalLines must have one column or same number of columns as that of x_mat !!')
end

if size(y_HorizontalLines,1)~=size(horizontalLinesTextLatex,1)
    error('y_HorizontalLines and horizontalLinesTextLatex must have the same size !!');
end
if size(x_VeticalLines,1)~=size(verticalLinesTextLatex,1)
    error('y_HorizontalLines and horizontalLinesTextLatex must have the same size !!');
end
if size(Y_HorizontalLines,1)~=size(HorizontalLinesTextLatex,1)
    error('y_HorizontalLines and horizontalLinesTextLatex must have the same size !!');
end
if size(X_VeticalLines,1)~=size(VerticalLinesTextLatex,1)
    error('y_HorizontalLines and horizontalLinesTextLatex must have the same size !!');
end

X_cols=fft(x_cols,[],1);

for ii=1:N_Curves
    subplot(N_Curves,2,(ii-1)*2+1)
    plot(t_col,x_cols(1:length(t_col),ii))
    xlabel(x_xlabel_Latex,'interpreter','latex')
    title(x_Title_Latex(ii),'interpreter','latex')
    %xlim([0,1])
    x_lims=xlim;
    hold on;
    for nn=1:size(y_HorizontalLines,1)
        if size(y_HorizontalLines,2) ==1
            plot(xlim,y_HorizontalLines(nn,1)*[1,1],'--k');
            text(x_lims(1)+.05*(x_lims(2)-x_lims(1)),1.05*y_HorizontalLines(nn,1),horizontalLinesTextLatex(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        else
            plot(xlim,y_HorizontalLines(nn,ii)*[1,1],'--k');
            text(x_lims(1)+.05*(x_lims(2)-x_lims(1)),1.05*y_HorizontalLines(nn,ii),horizontalLinesTextLatex(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        end
    end
    hold off
    
    subplot(N_Curves,2,(ii-1)*2+2)
    plot(f_col,abs(X_cols(1:length(f_col),ii)));
    xlabel(X_xlabel_Latex,'interpreter','latex')
    title(X_Title_Latex(ii),'interpreter','latex')
    %xlim([0,0.5])
    x_lims=xlim;
    hold on;
    for nn=1:size(Y_HorizontalLines,1)
        if size(Y_HorizontalLines,2) ==1
            plot(xlim,Y_HorizontalLines(nn,1)*[1,1],'--k');
            text(x_lims(1)+.3*(x_lims(2)-x_lims(1)),1.05*Y_HorizontalLines(nn,1),HorizontalLinesTextLatex(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        else
            plot(xlim,Y_HorizontalLines(nn,ii)*[1,1],'--k');
            text(x_lims(1)+.3*(x_lims(2)-x_lims(1)),1.05*Y_HorizontalLines(nn,ii),HorizontalLinesTextLatex(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        end
    end
    hold off
end

yLimitsMin=inf;
yLimitsMax=-inf;
YLimitsMin=inf;
YLimitsMax=-inf;
if sameScale_yY
    for ii=1:N_Curves
        subplot(N_Curves,2,(ii-1)*2+1)
        drawnow
        yLimits=ylim;
        yLimitsMin=min(yLimitsMin,yLimits(1));
        yLimitsMax=max(yLimitsMax,yLimits(2));
    
        subplot(N_Curves,2,(ii-1)*2+2)
        drawnow
        yLimits=ylim;
        YLimitsMin=min(YLimitsMin,yLimits(1));
        YLimitsMax=max(YLimitsMax,yLimits(2));
    end
    
    if yLimitsMin~=inf && yLimitsMax~=-inf
        for ii=1:N_Curves
            subplot(N_Curves,2,(ii-1)*2+1)
            ylim([yLimitsMin,yLimitsMax]);
        end
    end

    if YLimitsMin~=inf && YLimitsMax~=-inf
        for ii=1:N_Curves
            subplot(N_Curves,2,(ii-1)*2+2)
            ylim([YLimitsMin,YLimitsMax]);
        end
    end
end    
    
for ii=1:N_Curves
    subplot(N_Curves,2,(ii-1)*2+1)
    if ~isempty(x_VeticalLines)
        hold on;
        for nn=1:size(x_VeticalLines,1)
            if size(x_VeticalLines,2) ==1
                plot(x_VeticalLines(nn,1)*[1,1],[yLimitsMin,yLimitsMax],'--k');
                text(x_VeticalLines(nn,1),yLimitsMin+.05*(yLimitsMax-yLimitsMin),verticalLinesTextLatex(nn,1),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            else
                plot(x_VeticalLines(nn,1)*[1,1],[yLimitsMin,yLimitsMax],'--k');
                text(x_VeticalLines(nn,ii),yLimitsMin+.05*(yLimitsMax-yLimitsMin),verticalLinesTextLatex(nn,1),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            end
        end
        hold off
    end

    
    subplot(N_Curves,2,(ii-1)*2+2)
    if ~isempty(X_VeticalLines)
        hold on;
        for nn=1:size(X_VeticalLines,1)
            if size(X_VeticalLines,2) ==1
                plot(X_VeticalLines(nn,1)*[1,1],[YLimitsMin,YLimitsMax],'--k');
                text(X_VeticalLines(nn,1),YLimitsMax-.05*(YLimitsMax-YLimitsMin),VerticalLinesTextLatex(nn,1),'Rotation',90,'HorizontalAlignment','right','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            else
                plot(X_VeticalLines(nn,ii)*[1,1],[YLimitsMin,YLimitsMax],'--k');
                text(X_VeticalLines(nn,ii),YLimitsMax-.05*(YLimitsMax-YLimitsMin),VerticalLinesTextLatex(nn,1),'Rotation',90,'HorizontalAlignment','right','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            end
        end
        hold off
    end    
end