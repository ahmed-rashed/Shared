function curve_handle=plot_FRF_Nyq(H_vec,...
                         f_label,H_label,DispMagLines,varargin)  %Optional arguments

if nargin<2
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
if nargin<3
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

curve_handle=plot(real(H_vec),imag(H_vec),varargin{:});
if nargin>3
    if DispMagLines
        n_f=length(H_vec);
        n_MagLines=DispMagLines;
        delta_temp=floor(n_f/n_MagLines);
        iidx=1:delta_temp:n_f;

        set(gcf,'NextPlot','add');
        set(gca,'NextPlot','add');
        setappdata(gca,'PlotHoldStyle',false);

        if n_f==size(H_vec,1)
            H_temp_vec=H_vec(iidx,:);
        else     %Assuming that n_f==size(H_vec,2)
            H_temp_vec=H_vec(:,iidx);
        end

        handle=quiver(0*H_temp_vec,0*H_temp_vec,real(H_temp_vec),imag(H_temp_vec),0,'ShowArrowHead','off','LineWidth',get(curve_handle,'LineWidth')/3);
        set(get(get(handle,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend
        
        handle2=plot(real(H_temp_vec),imag(H_temp_vec),'.','MarkerSize',15,'MarkerEdgeColor',get(handle,'Color'));
        set(get(get(handle2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend
    end
end

vax=axis;
DataAspectRatio=get(gca,'DataAspectRatio');
set(gca,'DataAspectRatio',[DataAspectRatio(1),DataAspectRatio(1),DataAspectRatio(3)]);
axis(vax);

xlabel('$\Re\left('+H_Latex_subtitle+'\right)'+H_real_multiplier+'$','interpreter','latex')
ylabel('$\Im\left('+H_Latex_subtitle+'\right)'+H_real_multiplier+'$','interpreter','latex')
grid on