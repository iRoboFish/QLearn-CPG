%% Updated Q-learning algorithm

%一个强化学习的小程序，关于机器鱼的。Leader可以随机给相位，
% Follower根据Q-learning找最节省能力的自身相位，经过长时间的演化最终获的稳定的最优相位差。
% 缺点是需要相当长的实验重复，Leader随机20个相位，Follower需要大概重复3000次才能找到最优相位。
% 跟之前的版本最大区别在于，机器鱼的状态设置为时间状态，比如Leader有20个相位，
% 则Follower就有20个状态，每个状态对应10个Action，目标是20个状态走完以后使得整体能量消耗最小。
% 2017.4.18 添加了收敛方向的选择，添加了贪婪系数刚开始小最后大的收敛过程，添加了最后能量总和的绘制。

%% Format Preset
close all
clc
clear
%=========================================
set(0,'DefaultTextFontName','Times New Roman');
set(0,'defaultlinelinewidth',2)
set(0,'defaultaxeslinewidth',2);
set(0,'defaultaxesfontsize',16);
set(0,'defaulttextfontsize',16);
set(0,'DefaultLineMarkerSize',7);
set(0,'defaulttextinterpreter','latex')

%% Rewards are based on the experimental tests.
% choose_action()
% load('Average.mat');
% Phase_Leader = [4*ones(1,4), 8*ones(1,4),1*ones(1,20)];
Phase_Leader = randi([1 10],1,10);
Reward_array_original = [2.77164596400000,2.78348356200000,2.79195236400000,...
    2.76071340600000,2.74342257000000,2.77201235400000,2.82915417000000,...
    2.86940475000000,2.87520469800000,2.81050237800000];

Opt_direction = 'Bett_Min';


N_stra = 10 ;
N_state = length(Phase_Leader);
N_episode = 30;     % number of experiment repeating 

EPSILON = 0.1;  % greedy police
LAMBDA = 0.1;   %discount factor
ALPHA = 1;    %learning rate

if strcmp(Opt_direction,'Bett_Min')
% Minimum is better
Reward_array = 1*Reward_array_original/(max(Reward_array_original)-min(Reward_array_original));
Q_table = 30000*ones(N_state,N_stra);
elseif strcmp(Opt_direction,'Bett_Max')
% Maximum is better
Reward_array = 100-1*Reward_array_original/(max(Reward_array_original)-min(Reward_array_original));
Q_table = zeros(N_state,N_stra);
else
    disp('Opt_direction is wrong')
end


%%%%%%%%%%%%%%% Main loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for episode = 1: N_episode
    Temp_All_Cost = 0;
    for i = 1 : length(Phase_Leader)
        %%%%%%%%%%%%%%% Choose actions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        state_actions = Q_table(i,:);  % i means state here
        
        T_EPSILON = EPSILON + (1-EPSILON)*(episode-1)/N_episode; 
%         T_EPSILON = EPSILON;
        if rand >T_EPSILON
            action = randi([1 10]);
        else
            if strcmp(Opt_direction,'Bett_Min')
                [Reward,Temp_action] = min(state_actions);
            elseif strcmp(Opt_direction,'Bett_Max')
                [Reward,Temp_action] = max(state_actions);
            end
            if length(Temp_action)>1
                action = Temp_action(randi([1 length(Temp_action)]));
            else
                action = Temp_action;
            end
        end
        
        %%%%%%%%%%%%%%% Get envent reward %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        iPD = action-Phase_Leader(i)+1;
        if iPD <=0
           iPD = iPD +10; 
        end
        PD(i) = iPD;
        Phase(i) = action;
%         Reward_now = Reward_array(PD);
        Reward_now = Reward_array(iPD);  % add noise
        
        Temp_All_Cost = Temp_All_Cost + Reward_now;
%         disp(['---- Temp_All_Cost' num2str(iPD) '---' num2str(Temp_All_Cost) '-----'])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Q_predict = Q_table(i,action);
        
        if i < N_state
            if strcmp(Opt_direction,'Bett_Min')
        [Reward,Temp_action] = min(Q_table(i+1,:));
            elseif strcmp(Opt_direction,'Bett_Max')
        [Reward,Temp_action] = max(Q_table(i+1,:));       
            end
%         T_LAMBDA = LAMBDA + (1-LAMBDA)*(episode-5)/N_episode;
        T_LAMBDA = LAMBDA;
        Q_target = Reward_now + T_LAMBDA*Reward(1);
        else
         Q_target = Reward_now  ; 
        end
        
        Q_table(i,action) = Q_table(i,action) + ALPHA * (Q_target - Q_predict);
           
    end
    All_Cost(episode) = Temp_All_Cost;

% disp(['++++++++ Leader Phase =' num2str(Phase_Leader) ' ++++++++++'])
% disp(['++++++++ Follower Phase =' num2str(iv) ' ++++++++++'])

    disp(['+++episode' num2str(episode) '+++Phase' num2str(Phase) '+++ PD =' num2str(PD) ' ++++++++++'])
end

[v,iv] = min(Q_table,[],2)

% disp(['++++++++ Leader Phase =' num2str(Phase_Leader) ' ++++++++++'])
% disp(['++++++++ Follower Phase =' num2str(iv) ' ++++++++++'])

PD = iv' - Phase_Leader + 1

plot(All_Cost)

