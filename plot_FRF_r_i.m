function [ax_r,ax_i,h1,h2]=plot_FRF_r_i(f_vec,H_vec, ...
                                        ax_r,ax_i,f_label,H_subtitle)   %Optional arguments

if nargin<3
    ax_r=subplot(2,1,1);
    ax_i=subplot(2,1,2);
end

if nargin<5
    f_label='$f$ (Hz)';
else
    if isempty(f_label)
        f_label='$f$ (Hz)';
    end
end

if nargin<6
    H_subtitle='H';
else
    if isempty(H_subtitle)
        H_subtitle='H';
    end
end

h1=plot(ax_r,f_vec,real(H_vec));
%xlabel(ax_r,f_label, 'interpreter', 'latex');
%set(ax_r,'XTick',[]);
set(ax_r,'XTickLabel',[]);
ylabel(ax_r,['$\Re\left(',H_subtitle,'\right)$'], 'interpreter', 'latex')
set(ax_r,'xGrid','on','YGrid','on');

h2=plot(ax_i,f_vec,imag(H_vec));
xlabel(ax_i,f_label, 'interpreter', 'latex');
ylabel(ax_i,['$\Im\left(',H_subtitle,'\right)$'], 'interpreter', 'latex')
set(ax_i,'xGrid','on','YGrid','on');