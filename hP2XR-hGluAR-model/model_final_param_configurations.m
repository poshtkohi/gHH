%----- Functions ---------------------------------------%
function [opt_final] = model_final_param_configurations(receptor_name)
    switch receptor_name
        case 'hp2x7'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [0.01; 0.1; 1; 3 ; 5; 10];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'mM';
            opt_final.agonist_unit_latex = 'mM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'nA';
            
            params1 = [128.67275405 0.14353135 0.00882734 0.09378991 7.82748492 451.10926785 0.14447326 0.38524165];    % ATP=0.01mM
            params2 = [22.12205257 0.54014527 0.03925017 0.08421317 14.63207575 449.18318005 0.32392309 1.29759498];    % ATP=0.1mM
            params3 = [2.96922897 0.64665576 0.05257313 0.10395597 17.59509514 314.61977430 4.71228129 16.54017220];    % ATP=1mM
            params4 = [2.31695576 2.50498891 0.03101165 0.11341120 57.65289512 272.11417131 117.41532166 38.00120340];  % ATP=3mM
            params5 = [1.31422089 1.43410896 0.01524274 0.04805126 10.66372609 20.22328487 101.10997655 0.69002584];    %ATP=5mM
            params6 = [0.51483211 0.89766373 0.01751558 0.07828340 10.10161258 16.04179159 131.42032680 112.52525437];  %ATP=10mM
            
            opt_final.params = [params1; params2; params3; params4; params5; params6];
        case 'hp2x6'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [30];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'nA';

            params1 = [1.50412547 0.58012212 0.91568309 1.24130396 0.08556877 0.57955031 25.87803467 0.07917669];      % ATP=30uM
            
            opt_final.params = [params1];
        case 'hp2x5'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [1 ;3 ; 10 ; 30; 100];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'nA';

            params1 = [1.25071777 0.72769193 0.11521186 0.11102052 10.78445324 19.28081944 0.02506054 1.51586808];      % ATP=1uM
            params2 = [0.65004667 0.98001934 0.33788166 0.07182468 12.03845180 6.10438827 0.02512058 0.83677461];       % ATP=3uM
            params3 = [1.02588755 0.13488475 0.50569979 1.46171915 21.38107487 8.45287271 0.03306187 0.13174615];       % ATP=10uM
            params4 = [0.31471760 0.16063505 5.30031923 3.23114416 27.36183106 18.26915637 0.02613895 0.01316769];      % ATP=30uM
            params5 = [0.02964688 0.21392866 1.44578267 0.56844942 16.47905909 9.33589903 0.13313383 0.09283465];       % ATP=100uM
            opt_final.params = [params1; params2; params3; params4; params5];
            %opt_final.params = [ params5];
        case 'hp2x4'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [0.5 ;1 ;5 ;10 ;50 ;100 ; 500];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'µA';
     
            params1 = [1.87759405 0.31559290 0.59100590 0.48915489 0.12046324 2.92970588 4.17883060 4.45926947];        % ATP=0.5uM
            params2 = [0.83871926 0.25739831 0.23153940 0.31918189 1.16584035 3.07657918 0.00876118 0.19665786];        % ATP=1uM
            params3 = [0.37635334 0.11359094 2.55139912 1.86954236 0.01402286 2.13417707 0.07095332 0.09279147];        % ATP=5uM
            params4 = [0.90082953 0.22423851 0.77746200 0.08153367 0.41447503 75.24536537 0.25110271 0.09843200];       % ATP=10uM
            params5 = [0.07889736 0.08768498 0.44070871 0.59502509 1.96881440 2.43327242 0.07297221 0.21354627];        % ATP=50uM
            params6 = [0.03437133 0.03100913 0.39460389 0.44904976 1.34568199 1.92444635 0.05502681 0.16091569];        % ATP=100uM
            params7 = [0.00454264 0.04608130 0.82422998 1.56363107 0.45000102 0.64682067 0.01554701 0.08469014];        % ATP=500uM
            
            opt_final.params = [params1; params2; params3; params4; params5; params6; params7];
        case 'hp2x3'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [0.1 ;0.3 ; 1 ; 3; 100];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'nA';
            
            params1 = [126.01543473 3.67787480 1.95565222 2.23605224 0.82149259 15.96578989 0.42635275 0.31840133];     % ATP=0.1uM
            params2 = [104.78606633 3.58097020 0.19335071 2.40690716 4.56285930 2.27391485 0.14063233 4.89100582];      % ATP=0.3uM
            params3 = [47.09859898 0.89733755 10.94089270 11.79588959 0.01885726 92.00652416 0.13844496 0.88215465];    % ATP=1uM
            params4 = [11.50951107 4.96530672 6.50406530 1.26925663 0.01000010 19.87377319 0.87997390 2.54055614];      % ATP=3uM
            params5 = [4.38829411 22.83416060 43.26474289 113.43012593 0.01001985 64.41490717 2.08947706 12.84974012];   % ATP=100uM  
            
            opt_final.params = [params1; params2; params3; params4; params5];
        case 'hp2x2'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [3; 10 ; 30; 100; 300];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'µA';
            
            params1 = [0.05061425 2.72981425 5.22218716 4.35178262 1.74666843 400.00506569 1.01722728 62.03465779];     % ATP=3uM
            params2 = [0.18609133 1.61176745 0.07924843 0.56039285 7.11851292 5.50260523 1.55899877 99.46095194];       % ATP=10uM
            params3 = [0.14197118 1.24842595 0.18096598 0.48167863 21.24091639 6.17161738 0.91402615 8.39227110];       % ATP=30uM
            params4 = [0.12176091 0.78203406 0.31094343 0.38437397 19.61914165 3.26679924 0.91819765 6.03133891];       % ATP=100uM
            params5 = [0.04005886 0.47020303 0.17926865 0.21335172 27.02493644 2.60967440 1.82697449 14.69648405];      % ATP=300uM
            
            opt_final.params = [params1; params2; params3; params4; params5];
        case 'hp2x1'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [0.1 ;0.3 ; 1 ; 3; 100];
            opt_final.agonist_name = 'ATP';
            opt_final.agonist_unit = 'uM';
            opt_final.agonist_unit_latex = 'µM';
            opt_final.time_unit = 's';
            opt_final.current_unit = 'µA';
					   
			params1 = [108.08881668 1.88745676 0.24925046 0.51096398 0.25147983 0.42015155 1.05142875 39.41963423];     % ATP=0.1uM
            params2 = [35.86122059 1.17745791 0.43751530 1.85769977 0.10202634 0.72838195 6.52754953 12.81338576];      % ATP=0.3uM
            params3 = [10.76741582 1.14698682 1.88349992 4.09735747 0.29642882 0.80853057 0.33172248 2.96433067];       % ATP=1uM
            params4 = [8.68104138 1.84662058 3.15080597 1.06254320 0.27794555 3.81190500 0.19014352 0.98521166];        % ATP=3uM
            params5 = [4.28053853 5.30842848 13.76010331 0.11831751 5.61303203 33.17466799 0.19408205 0.81188366];      %ATP=100uM
            
            opt_final.params = [params1; params2; params3; params4; params5];
        case 'hglua1'
            opt_final.receptor_name = receptor_name;
            opt_final.A = [0.1 ;1 ; 10];
            opt_final.agonist_name = 'Glu';
            opt_final.agonist_unit = 'mM';
            opt_final.agonist_unit_latex = 'mM';
            opt_final.time_unit = 'ms';
            opt_final.current_unit = 'pA';
            
            params1 = [5.72337012 0.14365571 241.41990208 4.16765359 3.85853191 15.98436451 0.01678642 0.15950891];     % Glu=0.1mM
            params2 = [2.01553819 0.11600672 13.09167538 1.35043807 5.89130649 3.65516540 0.03841107 0.21429429];       % Glu=1mM            
            params3 = [0.29079681 0.28012544 27.99527234 0.27172370 2.94690672 0.86727372 0.05504995 0.20527884];       % Glu=10mM
            
            opt_final.params = [params1; params2; params3;];
        otherwise
            opt_final.receptor_name = 'Uknown receptor name';
    end
    
    opt_final.receptor_name = receptor_name;
    opt_final.steps = 1;
end
%-------------------------------------------------------%