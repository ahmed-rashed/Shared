function plot_FRF_3d(f_vec,H_vec, ...
                     f_label,H_subtitle,DispRealImag,DispMagLines) %Optional arguments

curve_h=plot3(f_vec,real(H_vec),imag(H_vec));
view(30,20);
grid on

DataAspectRatio=get(gca,'DataAspectRatio');
set(gca,'DataAspectRatio',[DataAspectRatio(1),DataAspectRatio(2),DataAspectRatio(2)]);

if nargin<3
    f_label='$f$ (Hz)';
else
    if isempty(f_label)
        f_label='$f$ (Hz)';
    end
end

if nargin<4
    H_subtitle='H';
else
    if isempty(H_subtitle)
        H_subtitle='H';
    end
end
xlabel(f_label,'interpreter', 'latex');
ylabel(['$\Re\left(',H_subtitle,'\right)$'], 'interpreter', 'latex')
zlabel(['$\Im\left(',H_subtitle,'\right)$'], 'interpreter', 'latex')

if nargin>4
    nexta = get(gca,'NextPlot');
    nextf = get(gcf,'NextPlot');

    if DispRealImag
        set(gca,'YLimMode','manual');
        set(gca,'ZLimMode','manual');
        ylims=ylim;
        zlims=zlim;

        set(gcf,'NextPlot','add');
        set(gca,'NextPlot','add');

        %Nyquist
        hLine=line(f_vec*0,real(H_vec),imag(H_vec),'Color',get(curve_h,'Color'),'LineStyle',get(curve_h,'LineStyle'),'LineWidth',get(curve_h,'LineWidth')/3);
        set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend

        %Imag
        hLine=line(f_vec,max(ylims)*ones(size(f_vec)),imag(H_vec),'Color',get(curve_h,'Color'),'LineStyle',get(curve_h,'LineStyle'),'LineWidth',get(curve_h,'LineWidth')/3);
        set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend

        %Real
        hLine=line(f_vec,real(H_vec),min(zlims)*ones(size(f_vec)),'Color',get(curve_h,'Color'),'LineStyle',get(curve_h,'LineStyle'),'LineWidth',get(curve_h,'LineWidth')/3);
        set(get(get(hLine,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend
    end
    
    if nargin>5
        if DispMagLines
            n_f=length(f_vec);
            n_MagLines=DispMagLines;
            delta_temp=floor(n_f/n_MagLines);
            iidx=1:delta_temp:n_f;
            
            set(gcf,'NextPlot','add');
            set(gca,'NextPlot','add');
            setappdata(gca,'PlotHoldStyle',false);

            if n_f==size(H_vec,1)
                H_temp=H_vec(iidx,:);
            else     %Assuming that n_f==size(H_vec,2)
                H_temp=H_vec(:,iidx);
            end
            
            handle=quiver3(f_vec(iidx),0*f_vec(iidx),0*f_vec(iidx),0*f_vec(iidx),real(H_temp),imag(H_temp),0,'ShowArrowHead','off','LineWidth',get(curve_h,'LineWidth')/3);
            set(get(get(handle,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend
            
            handle2=plot3(f_vec(iidx),real(H_temp),imag(H_temp),'.','MarkerSize',15,'MarkerEdgeColor',get(handle,'Color'));
            set(get(get(handle2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Exclude line from legend

        end
    end

    set(gcf,'NextPlot',nexta);
    set(gca,'NextPlot',nextf);
end