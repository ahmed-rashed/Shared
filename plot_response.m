function [ax,h1]=plot_response(t_col,x_func,zeta_row,...
                                        t_label,x_label,zeta_subtitle,t_multiplier,ax,legend_location,varargin)   %Optional arguments

if nargin<4
    t_label='$t$ (sec.)';
else
    if isempty(t_label)
        t_label='$t$ (sec.)';
    end
end

if nargin<5
    x_label='';
end

if nargin<6
    zeta_subtitle='\zeta';
else
    if isempty(zeta_subtitle)
        zeta_subtitle='\zeta';
    end
end

if nargin<7
    t_multiplier=1;
else
    if isempty(t_multiplier)
        t_multiplier=1;
    end
end

if nargin<8
    figure
    ax=axes;
else
    if isempty(ax)
        figure
        ax=axes;
    end
end

if nargin<9
    legend_location='northeast';
else
    if isempty(legend_location)
        legend_location='northeast';
    end
end

set(groot,'DefaultAxesLineStyleOrder','-|--|-.')

x_cols=x_func(t_col,zeta_row);
h1=plot(t_col.*t_multiplier,x_cols,varargin{:});

xlabel(t_label,'interpreter','latex');
if ~isempty(x_label)
    ylabel(x_label,'interpreter','latex')
end

if length(zeta_row)>1
    legend_str_vec="$"+zeta_subtitle+'='+zeta_row+'$';
    legend_str_vec(zeta_row==1/sqrt(2))="$"+zeta_subtitle+'=1/\sqrt{2}$';
    legend_str_vec(zeta_row==sqrt(2))="$"+zeta_subtitle+'=\sqrt{2}$';

    legend(legend_str_vec,'interpreter','latex','Location',legend_location);
end

set(groot,'DefaultAxesLineStyleOrder','remove')