function [ax_r,ax_i,h1,h2]=plot_FRF_r_i(f_vec,H_vec,...
                                        ax_r,ax_i,f_label,H_label)   %Optional arguments

if nargin<3 || isempty(ax_r)
    tiledlayout(2,1,"TileSpacing","compact")
    ax_r=nexttile;
    ax_i=nexttile;
end

if nargin<5
    f_label='$f$ (Hz)';
else
    if isempty(f_label)
        f_label='$f$ (Hz)';
    end
end
indices=strfind(f_label,'$');
if length(indices)<2,error('f_label does not include LaTeX inline equation !!'),end
index_temp=strfind(f_label,'\equiv');
if ~isempty(index_temp),indices(2)=index_temp;end

H_real_multiplier="";
if nargin<6
    H_Latex_subtitle="H";
else
    if isempty(H_label)
        H_Latex_subtitle="H";
    elseif  isStringScalar(H_label) || ischar(H_label)
        H_Latex_subtitle=string(H_label);
    elseif isstring(H_label) && length(H_label)==2
        H_Latex_subtitle=H_label(1);
        H_real_multiplier=H_label(2);
    else
        error('H_label can be either a character array, a string scalar or two-element-string; one for H_Latex_subtitle and the other for H_real_multiplier')
    end
end
H_Latex_subtitle=H_Latex_subtitle+'\left('+f_label(indices(1)+1:indices(2)-1)+'\right)';

h1=plot(ax_r,f_vec,real(H_vec));
%xlabel(ax_r,f_label,'interpreter','latex');
%set(ax_r,'XTick',[]);
set(ax_r,'XTickLabel',[]);
ylabel(ax_r,'$\Re\left('+H_Latex_subtitle+'\right)'+H_real_multiplier+'$','interpreter','latex')
set(ax_r,'xGrid','on','YGrid','on');

h2=plot(ax_i,f_vec,imag(H_vec));
xlabel(ax_i,f_label,'interpreter','latex');
ylabel(ax_i,'$\Im\left('+H_Latex_subtitle+'\right)'+H_real_multiplier+'$','interpreter','latex')
set(ax_i,'xGrid','on','YGrid','on');

linkaxes([ax_r,ax_i],'x')

if ~ishold(ax_r)
    ylim(ax_r,"padded")
end
if ~ishold(ax_i)
    ylim(ax_i,"padded")
end
