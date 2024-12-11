function tile1=plot_FRF_matrix(f_col,H_cols_pages,H_label_symbol,tile1,varargin)
[~,M,N]=size(H_cols_pages);

if nargin<3
    H_label_symbol=[];
end

holdState='on';
if nargin<4
    tile1=tiledlayout(M,N,"TileSpacing","tight");
    holdState='off';
else
    if isempty(tile1)
        tile1=tiledlayout(M,N,"TileSpacing","tight");
        holdState='off';
    end
end

if isempty(H_label_symbol)
    H_label="";
end
for m=1:M
    for n=1:N
        if ~isempty(H_label_symbol)
            H_label=H_label_symbol+'_{'+m+n+'}';
        end

        ax_mag_h=nexttile(tile1,(m-1)*N+n);
        hold(holdState)
        plot_FRF_mag_phase(f_col,H_cols_pages(:,m,n),false,ax_mag_h,gobjects,'',H_label,[],[],varargin{:});

        if m~=M
            set(ax_mag_h,'XTickLabel',[]);
            xlabel('')
        end
    end
end