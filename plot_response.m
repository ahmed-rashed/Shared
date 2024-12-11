function [ax,h1]=plot_response(t_vec,x_func,zeta_vec,...
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

set(groot,'DefaultAxesColorOrder',[0,0,1;0,0,0;1,0,0;0,0.5,0;1,0,1])
set(groot,'DefaultAxesLineStyleOrder','-|--|-.')
set(groot,'DefaultLineLineWidth',1);

N_zeta=length(zeta_vec);
axes(ax);
holdState=ishold;
if ~holdState,hold on,end
if N_zeta>1,legend_str_vec=strings(N_zeta,1);end
for ii=1:N_zeta
    x_vec=x_func(t_vec,zeta_vec(ii));
    h1=plot(t_vec*t_multiplier,x_vec,varargin{:});
    
    if N_zeta>1
        if zeta_vec(ii)==1/sqrt(2)
            legend_str_vec(ii)="$"+zeta_subtitle+'=1/\sqrt{2}$';
        elseif zeta_vec(ii)==sqrt(2)
            legend_str_vec(ii)="$"+zeta_subtitle+'=\sqrt{2}$';
        else
            legend_str_vec(ii)="$"+zeta_subtitle+'='+zeta_vec(ii)+'$';
        end
    end
end
if ~holdState,hold off,end
xlabel(t_label,'interpreter','latex');
if ~isempty(x_label)
    ylabel(x_label,'interpreter','latex')
end
if N_zeta>1,legend(legend_str_vec,'interpreter','latex','Location',legend_location);end

set(groot,'DefaultAxesColorOrder','remove')
set(groot,'DefaultAxesLineStyleOrder','remove')
set(groot,'DefaultLineLineWidth','remove');