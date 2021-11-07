classdef cBK_Windows

    properties
        i_win
    end

    properties (Constant)
        a_mat=[1,0,0,0,0;
               1,1,0,0,0;
               1,1.24,.244,.00305,0;  %B&K Windows to FFT Analysis Part I (best)
%                1,1.298,.244,.003,0;  %B&K Windows to FFT Analysis Part II (worst)
%                [402,498,99,1,0]/402     %Mathematica
               1,1.933,1.286,.388,.032];
        
        win_name_vec=["rectangular","Hann","Kaiser-Bessel","flat-top"];
    end

    methods
        %Constructor
        function oThisClass=cBK_Windows(i_win)
            if nargin == 1
                oThisClass.i_win=i_win;
            end
        end
        
        function a_row=a_row(oThisClass)
            a_row=oThisClass.a_mat(oThisClass.i_win,:);
        end
                
        function win_name=win_name(oThisClass)
            win_name=oThisClass.win_name_vec(oThisClass.i_win);
        end
        
        function w_col=w(oThisClass,K_plus_1)
            K=K_plus_1-1;
            k_col=(0:K).';
            w_col=(oThisClass.a_row*cos((0:2:8).'*pi*(k_col/K-.5).')).';
        end
        
        function W_sym_mul_D_f_col=W_sym_mul_D_f(oThisClass,f_max_by_D_f,N_plus_1)
            f_sym_by_D_f_row=f_max_by_D_f*linspace(-1,1,N_plus_1);
            W_sym_mul_D_f_col=.5*(oThisClass.a_row*(sinc(ones(5,1)*f_sym_by_D_f_row-(0:4).'*ones(1,N_plus_1))+sinc(ones(5,1)*f_sym_by_D_f_row+(0:4).'*ones(1,N_plus_1)))).';
        end
    end
end