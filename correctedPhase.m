function H_angle_arr=correctedPhase(H_arr, ...
                                    maxPhaseLag) %Optional arguments
if nargin<2
    maxPhaseLag=-pi;
else
    if isempty(maxPhaseLag)
        maxPhaseLag=-pi;
    end
end

sz=size(H_arr);
if length(sz)>2,error('H_arr must be a vector or 2-D array.'),end
if sz(1)<sz(2)
    transpose_f=true;
    H_cols=H_arr.';
    N=sz(2);
    N_signal=sz(1);
else
    transpose_f=false;
    H_cols=H_arr;
    N=sz(1);
    N_signal=sz(2);
end

H_angle_cols=angle(H_cols);

H_angle_cols(abs(H_angle_cols)<1e3*eps)=0;
H_angle_cols(abs(H_angle_cols-pi)<1e3*eps)=pi;
H_angle_cols(abs(H_angle_cols+pi)<1e3*eps)=-pi;
H_angle_cols(abs(H_cols)==0)=nan;

%Force phase to be less than maxPhaseLag
indd=H_angle_cols-maxPhaseLag>0;
H_angle_cols(indd)=H_angle_cols(indd)-2*pi*ceil((H_angle_cols(indd)-maxPhaseLag)/2/pi);

%Force phase to be decreasing for jumps >= 45 deg
for n_signal=1:N_signal
    for n=1:N-1
        dd=H_angle_cols(n+1,n_signal)-H_angle_cols(n,n_signal);
        if dd>=pi/4
            H_angle_cols(n+1,n_signal)=H_angle_cols(n+1,n_signal)-2*pi*ceil(dd/2/pi);
        end
    end
end

H_angle_cols=unwrap(H_angle_cols,[],1);

if transpose_f
    H_angle_arr=H_angle_cols.';
else
    H_angle_arr=H_angle_cols;
end