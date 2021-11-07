function export_figure(fig_handle_vec, ...
                    Expand,filenames,resolution,pictureFormat_vec,dimScale)   %Optional arguments

if nargin<2
    Expand='';
end

if nargin<4
    resolution=600;
elseif isempty(resolution)
    resolution=600;
end

if nargin<5
    pictureFormat_vec="pdf";
elseif isempty(pictureFormat_vec)
    pictureFormat_vec="pdf";
else
    if ~isstring(pictureFormat_vec)
        error('pictureFormat must be array of strings.')
    end
end

if nargin<6
    dimScale=[];
end

printFlag_vec=strings(size(pictureFormat_vec));
for n=1:length(pictureFormat_vec)
    if strcmpi(pictureFormat_vec{n},'emf')
        if ispc
            printFlag_vec(n)="meta";
        else
            error('Matlab cannot export emf except under Windows.');
        end
    else
        printFlag_vec(n)=lower(pictureFormat_vec(n));
    end
end

if min(size(fig_handle_vec,1),size(fig_handle_vec,2))~=1
    error('h must be 1 D vector'),
end

if ~isstring(filenames)
    error('filenames must be a string array');
end
    
if nargin>2
    if length(fig_handle_vec)~=length(filenames)
        error('fig_handle_vec & filenames must be of the same length');
    end
end

if ~isempty(Expand)
    if ischar(Expand)
        if (~strcmpi(Expand,'||') && ~strcmpi(Expand,'=='))
            error('you must input ''||'' or ''==''')    
        end
    end
end

for i=1:length(fig_handle_vec)
    f_OriginalUnit=get(fig_handle_vec(i),'Units');
    set(fig_handle_vec(i),'papertype','A4');
    if ~isempty(Expand)
        if ischar(Expand)
            if strcmpi(Expand(1:2),'||')
                 set(fig_handle_vec(i),'PaperOrientation','portrait');
            elseif strcmpi(Expand(1:2),'==')
               set(fig_handle_vec(i),'PaperOrientation','landscape');
            end
        end
        
        if ischar(Expand)
            if strcmpi(Expand,'||') || strcmpi(Expand,'==')
                a=get(fig_handle_vec(i),'papersize');
                set(fig_handle_vec(i),'PaperPositionMode','manual');
                set(fig_handle_vec(i),'PaperPosition',[0 0 a(1) a(2)]);
                set(fig_handle_vec(i),'Units',get(fig_handle_vec(i),'PaperUnits'));
                set(fig_handle_vec(i),'Position',[0 0 a(1) a(2)]);
                set(fig_handle_vec(i),'Units',f_OriginalUnit);
                set(0,'CurrentFigure',fig_handle_vec(i)),
                drawnow
            else
                set(fig_handle_vec(i),'PaperPositionMode','auto');
            end
        end
        if ~isempty(dimScale)
            pos=get(fig_handle_vec(i),'PaperPosition');
            set(fig_handle_vec(i),'PaperPositionMode','manual');
            set(fig_handle_vec(i),'PaperPosition',[pos(1:2),pos(3:4).*dimScale/max(dimScale)]);
        end
    end
end

for i=1:length(fig_handle_vec)
    for n=1:length(printFlag_vec)
        if any(printFlag_vec(n)==["meta","pdf","eps","epsc","svg"])
            renderer='-painters';
        elseif any(printFlag_vec(n),["png","jpg"])
            renderer='-opengl';
        end
		args={"-r"+resolution,renderer,"-d"+printFlag_vec(n),"-f"+double(fig_handle_vec(i))};
        if nargin>=3
			args=[args,filenames(i)+'.'+pictureFormat_vec(n)]; %#ok<AGROW> 
        end
		print(args{:});
    end
end

%If "strawberry perl" and Miketex is installed
if nargin>=3
    temp_env=getenv('LD_LIBRARY_PATH');
    setenv('LD_LIBRARY_PATH','')
    
    if any(strcmpi(pictureFormat_vec,'pdf'))
        [status,~]=system('where pdfcrop');
        if status,warning('pdfcrop is not installed. Please install it through TeXLive or MiKTeX.'),end
    end
    
    if any(strcmpi(pictureFormat_vec,'png')) || any(strcmpi(pictureFormat_vec,'jpg'))
        if ispc
            [status,~]=system('where magick');
            if status,warning('Imagemagick is not installed.'),end
        else
            [status,~]=system('where convert');
            if status,warning('Imagemagick is not installed.'),end
        end
    end

    for n=1:length(pictureFormat_vec)
        if strcmpi(pictureFormat_vec{n},'pdf')
            for i=1:length(fig_handle_vec)
               system(['pdfcrop "',filenames{i},'.pdf" "',filenames{i},'.pdf"']);
            end
        elseif any(strcmpi(pictureFormat_vec{n},{'png','jpg'}))
            for i=1:length(fig_handle_vec)
                system("magick convert """+filenames(i)+'.'+pictureFormat_vec(n)+""" -trim """+filenames(i)+'.'+pictureFormat_vec(n)+'"');
            end
        end
    end
    setenv('LD_LIBRARY_PATH',temp_env)
end