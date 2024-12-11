function plot_IRF_matrix(t_col,h_cols_pages)
[~,M,N]=size(h_cols_pages);

tiledlayout(M,N,"TileSpacing","tight")
for m=1:M
    for n=1:N
        h_label="$h_{"+m+','+n+'}(t)$';

        ax=nexttile;
        plot(t_col,h_cols_pages(:,m,n))
        ylabel(h_label,'Interpreter','latex')
        if m~=M
            set(ax,'XTickLabel',[]);
        else
            xlabel('$t$ (sec.)','Interpreter','latex')
        end
    end
end