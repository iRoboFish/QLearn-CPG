% Updated Q-learning algorithm

%一个强化学习的小程序，关于机器鱼的。Leader可以随机给相位，
% Follower根据Q-learning找最节省能力的自身相位，经过长时间的演化最终获的稳定的最优相位差。
% 缺点是需要相当长的实验重复，Leader随机20个相位，Follower需要大概重复3000次才能找到最优相位。
% 跟之前的版本最大区别在于，机器鱼的状态设置为时间状态，比如Leader有20个相位，
% 则Follower就有20个状态，每个状态对应10个Action，目标是20个状态走完以后使得整体能量消耗最小。

% choose_action()
% load('Average.mat');
% Phase_Leader = [4*ones(1,4), 8*ones(1,4),1*ones(1,20)];
Phase_Leader = randi([1 10],1,20);

% Rewards are based on the experimental tests.
Reward_array = [2.77164596400000,2.78348356200000,2.79195236400000,2.76071340600000,2.74342257000000,2.77201235400000,2.82915417000000,2.86940475000000,2.87520469800000,2.81050237800000];


N_stra = 10 ;
N_state = length(Phase_Leader);
N_episode = 10;     % number of experiment repeating 

EPSILON = 0.99;  % greedy police
LAMBDA = 0.1;   %discount factor
ALPHA = 1;    %learning rate

Q_table = 3*ones(N_state,N_stra);


%%%%%%%%%%%%%%% Main loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for episode = 1: N_episode
    for i = 1 : length(Phase_Leader)
        %%%%%%%%%%%%%%% Choose actions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        state_actions = Q_table(i,:);  % i means state here
        if rand >EPSILON
            action = randi([1 10]);
        else
            [Reward,Temp_action] = min(state_actions);
            if length(Temp_action)>1
                action = Temp_action(randi([1 length(Temp_action)]));
            else
                action = Temp_action;
            end
        end
        
        %%%%%%%%%%%%%%% Get envent reward %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        PD = action-Phase_Leader(i)+1;
        if PD <=0
           PD = PD +10; 
        end
        
        Reward_now = Reward_array(PD);
        
        Q_predict = Q_table(i,action);
        
        if i < N_state
        [Reward,Temp_action] = min(Q_table(i+1,:));
        
        Q_target = Reward_now + LAMBDA*Reward(1);
        else
         Q_target = Reward_now  ; 
        end
        
        Q_table(i,action) = Q_table(i,action) + ALPHA * (Q_target - Q_predict);
           
    end
    
end

[v,iv] = min(Q_table,[],2)

% disp(['++++++++ Leader Phase =' num2str(Phase_Leader) ' ++++++++++'])
% disp(['++++++++ Follower Phase =' num2str(iv) ' ++++++++++'])

PD = iv' - Phase_Leader + 1

