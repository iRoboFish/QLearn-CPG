clc 
clear all
close all

NS = 10; %10 States
NA = 10; %10 Actions
D_save = [];
R = 3*ones(NS,NA);

CPGPara = [12 22 27 1.396 2.094 0.85];
TestSendCPGPara12(CPGPara);
pause(10);
s = daq.createSession('ni');
addAnalogInputChannel(s,'cDAQ1Mod1', 1, 'Current');
s.Rate = 5000;
s.DurationInSeconds = 20;
data = s.startForeground;
%%

pause(2); % Wait for the robot swimming stable
iStra=1;
for i = 1:40 % test at least 20 times at each stable phase of leader
    data = s.startForeground;
    Mdate = mean(data)*6.0;
    R(:,iStra) = 3 - ones(NS,1)*Mdate;
%     R = mean(data);
    iStra = Qlearn_Fish(NS,NA,R);  %get the stratgy according to QLearning
    D_save(:,end+1) = [0;iStra;Mdate]; % save the leader's stratgy and the follower's stratgy
    CPGPara = [(iStra-1)*0.2*pi (iStra-1)*0.2*pi (iStra-1)*0.2*pi 0.698 2.513 3]; % sent the stratgies
    TestSendCPGPara2(CPGPara); 
    pause(2);
    if i == 20
        %% Change another phase of the Leader
        CPGPara = [-0.8*pi -0.8*pi -0.8*pi 0.698 2.513 3];
        TestSendCPGPara1(CPGPara);
        pause(12);
    end
end

CPGPara = [0 0 0 0 0 0];  % Stop 
TestSendCPGPara12(CPGPara);
pause(2);

save('D_save.mat','D_save')
