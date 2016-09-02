clear
clc

load('Average.mat');
NS = 10;
NA = 10;
R = zeros(NS,NA)
C_iStra = [];

for i = 1:size(Average,2)   %  循环矩阵的列数60次

    j = int16(Average(2,i)/0.2+1);  % 10个相位差，1~1.8pi 每隔0.2pi相位差 
    
    if j >10
        
        j = j -10;
        
    end
    
    Average(1,j)  %  ans值为矩阵第一行，第j列的值 
    
    R(:,j) = 3 - ones(NS,1)*Average(1,i);  % 每个相位差的瞬时收益，通过j值得变化更新当前相位差的R值
    

%     R = 3 - ones(NS,1)*[2.737286328,2.78535423,2.836535046,2.873305188,2.76192333,2.849237346,2.832270984,2.799873048,2.829850224,2.81956953,2.771836032];

    
    iStra = Qlearn_Fish(NS,NA,R)  %把R值输入Q-learning里面计算  
    
    C_iStra(end+1) = iStra;   %得出最优相位差（相对应的策略）
    
end

plot(C_iStra)