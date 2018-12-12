classdef BK_Windows

    properties
        i_win
    end
    
    methods
        function obj=BK_Windows(i_win)
           obj.i_win=i_win;
        end
        
        function a_roww=a_row(obj)
            a_mat=[1,0,0,0,0;
                   1,1,0,0,0;
                   1,1.24,.244,.00305,0;  %B&K Windows to FFT Analysis Part I (best)
%                    1,1.298,.244,.003,0;  %B&K Windows to FFT Analysis Part II (worst)
%                    [402,498,99,1,0]/402     %Mathematica
                   1,1.933,1.286,.388,.032];

            a_roww=a_mat(obj.i_win,:);
        end
        
        function win_namee=win_name(obj)
           win_name_vec={'rectangular','Hann','Kaiser-Bessel','flat-top'};

            win_namee=win_name_vec{obj.i_win};
        end
        
        function w_col=w_vec(obj,K)
            k_col=(0:K-1).';
            w_col=(obj.a_row()*cos((0:2:8).'*pi*(k_col/K-1/2).')).';
        end
        
        function W_sym_col=W_sym_exact_vec(obj,f_max_by_D_f,N)
            f_sym_by_D_f_row=linspace(-f_max_by_D_f,f_max_by_D_f,N);
            W_sym_col=.5*(obj.a_row*(sinc(ones(5,1)*f_sym_by_D_f_row-(0:4).'*ones(1,N))+sinc(ones(5,1)*f_sym_by_D_f_row+(0:4).'*ones(1,N)))).';
        end
    end
end

