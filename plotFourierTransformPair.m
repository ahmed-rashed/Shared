function plotFourierTransformPair(f_s,x_cols,T,X_cols, ...
    x_xlabel_LaTeX, x_title_LaTeX, ...
    X_xlabel_LaTeX, X_title_LaTeX, ...
    y_xlabel_LaTeX, Y_xlabel_LaTeX, ...
    y_ticks_cols,y_TicksLaTeX_strCols, ...
    x_ticks_cols,x_TicksLaTeX_strCols, ...
    Y_ticks_cols,Y_TicksLaTeX_strCols, ...
    X_ticks_cols,X_TicksLaTeX_strCols, ...
    sameScale_y_Y)

N_Curves=size(x_cols,2);

if nargin<5
    x_xlabel_LaTeX='$t$ (sec.)';
else
    if isempty(x_xlabel_LaTeX)
        x_xlabel_LaTeX='$t$ (sec.)';
    end
end

if nargin<7
    X_xlabel_LaTeX='$f/f_{\mathrm{s}}$';
else
    if isempty(X_xlabel_LaTeX)
        X_xlabel_LaTeX='$f/f_{\mathrm{s}}$';
    end
end

if ~isempty(y_ticks_cols)
    if size(y_ticks_cols,2)==1
        repmat(y_ticks_cols,[1,N_Curves])
    elseif size(y_ticks_cols,2)~=N_Curves
        error('y_ticks_cols must have one column or same number of columns as that of x_cols !!')
    end
end


if ~(isempty(y_ticks_cols) || size(y_ticks_cols,2)==1 || size(y_ticks_cols,2)==N_Curves)
    error('y_ticks_cols must have one column or same number of columns as that of x_cols !!')
end

if ~(isempty(x_ticks_cols) || size(x_ticks_cols,2)==1 || size(x_ticks_cols,2)==N_Curves)
    error('x_ticks_cols must have one column or same number of columns as that of x_cols !!')
end
if ~(isempty(Y_ticks_cols) || size(Y_ticks_cols,2)==1 || size(Y_ticks_cols,2)==N_Curves)
    error('Y_ticks_cols must have one column or same number of columns as that of x_cols !!')
end
if ~(isempty(X_ticks_cols) || size(X_ticks_cols,2)==1 || size(X_ticks_cols,2)==N_Curves)
    error('X_ticks_cols must have one column or same number of columns as that of x_cols !!')
end

if size(y_ticks_cols,1)~=size(y_TicksLaTeX_strCols,1)
    error('y_ticks_cols and y_TicksLaTeX_strCols must have the same size !!');
end
if size(x_ticks_cols,1)~=size(x_TicksLaTeX_strCols,1)
    error('y_ticks_cols and y_TicksLaTeX_strCols must have the same size !!');
end
if size(Y_ticks_cols,1)~=size(Y_TicksLaTeX_strCols,1)
    error('y_ticks_cols and y_TicksLaTeX_strCols must have the same size !!');
end

if size(X_ticks_cols,1)~=size(X_TicksLaTeX_strCols,1)
    error('y_ticks_cols and y_TicksLaTeX_strCols must have the same size !!');
end

[D_t,K,D_f,N_no_fold]=samplingParameters_T_fs(T,f_s);
% N=K;
t_col=(0:K-1).'*D_t;
f_col=(0:N_no_fold-1).'*D_f;

X_cols=fft(x_cols,[],1);

for ii=1:N_Curves
    subplot(N_Curves,2,(ii-1)*2+1)
    plot(t_col,x_cols(1:length(t_col),ii))
    xlabel(x_xlabel_LaTeX,'interpreter','latex')
    ylabel(y_xlabel_LaTeX(ii),'interpreter','latex')
    %xlim([0,1])
    x_lims=xlim;
    hold on;
    for nn=1:size(y_ticks_cols,1)
        if size(y_ticks_cols,2)==1
            plot(xlim,y_ticks_cols(nn,1)*[1,1],'--k');
            text(x_lims(1)+.05*(x_lims(2)-x_lims(1)),1.05*y_ticks_cols(nn,1),y_TicksLaTeX_strCols(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        else
            plot(xlim,y_ticks_cols(nn,ii)*[1,1],'--k');
            text(x_lims(1)+.05*(x_lims(2)-x_lims(1)),1.05*y_ticks_cols(nn,ii),y_TicksLaTeX_strCols(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        end
    end
    hold off
    
    subplot(N_Curves,2,(ii-1)*2+2)
    plot(f_col,abs(X_cols(1:length(f_col),ii)));
    xlabel(X_xlabel_LaTeX,'interpreter','latex')
    ylabel(Y_xlabel_LaTeX(ii),'interpreter','latex')
    %xlim([0,0.5])
    x_lims=xlim;
    hold on;
    for nn=1:size(Y_ticks_cols,1)
        if size(Y_ticks_cols,2) ==1
            plot(xlim,Y_ticks_cols(nn,1)*[1,1],'--k');
            text(x_lims(1)+.3*(x_lims(2)-x_lims(1)),1.05*Y_ticks_cols(nn,1),Y_TicksLaTeX_strCols(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        else
            plot(xlim,Y_ticks_cols(nn,ii)*[1,1],'--k');
            text(x_lims(1)+.3*(x_lims(2)-x_lims(1)),1.05*Y_ticks_cols(nn,ii),Y_TicksLaTeX_strCols(nn,1),'VerticalAlignment','bottom','interpreter','latex','FontSize',8)
        end
    end
    hold off
end

yLimitsMin=inf;
yLimitsMax=-inf;
YLimitsMin=inf;
YLimitsMax=-inf;
if sameScale_y_Y
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
    if ~isempty(x_ticks_cols)
        hold on;
        for nn=1:size(x_ticks_cols,1)
            if size(x_ticks_cols,2) ==1
                plot(x_ticks_cols(nn,1)*[1,1],[yLimitsMin,yLimitsMax],'--k');
                text(x_ticks_cols(nn,1),yLimitsMin+.05*(yLimitsMax-yLimitsMin),x_TicksLaTeX_strCols(nn,1),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            else
                plot(x_ticks_cols(nn,1)*[1,1],[yLimitsMin,yLimitsMax],'--k');
                text(x_ticks_cols(nn,ii),yLimitsMin+.05*(yLimitsMax-yLimitsMin),x_TicksLaTeX_strCols(nn,1),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            end
        end
        hold off
    end

    
    subplot(N_Curves,2,(ii-1)*2+2)
    if ~isempty(X_ticks_cols)
        hold on;
        for nn=1:size(X_ticks_cols,1)
            if size(X_ticks_cols,2) ==1
                plot(X_ticks_cols(nn,1)*[1,1],[YLimitsMin,YLimitsMax],'--k');
                text(X_ticks_cols(nn,1),YLimitsMax-.05*(YLimitsMax-YLimitsMin),X_TicksLaTeX_strCols(nn,1),'Rotation',90,'HorizontalAlignment','right','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            else
                plot(X_ticks_cols(nn,ii)*[1,1],[YLimitsMin,YLimitsMax],'--k');
                text(X_ticks_cols(nn,ii),YLimitsMax-.05*(YLimitsMax-YLimitsMin),X_TicksLaTeX_strCols(nn,1),'Rotation',90,'HorizontalAlignment','right','VerticalAlignment','bottom','interpreter','latex','FontSize',8)
            end
        end
        hold off
    end    
end