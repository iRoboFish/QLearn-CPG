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

%% Load Data 
% load('Q_learn_Results.mat');
% RL_Data = Data.All_Cost;
% load('Radom_Results.mat')
% Random_Data = Data.All_Cost;

%%%%%%%%% 10 Envieronment  %%%%%%%

load('Q_learn_Results_10Evn.mat');
RL_Data = Data.All_Cost;
RL_Follower_Phase = [Data.Phase_Follower(end,:),Data.Phase_Follower(end,end)];
RL_Phase_Leader = [Data.Phase_Leader,Data.Phase_Leader(end)];
load('Radom_Results_10Evn.mat')
Random_Data = Data.All_Cost;
Random_Follower_Phase = [Data.Phase_Follower(end,:),Data.Phase_Follower(end,end)];
Random_Phase_Leader = [Data.Phase_Leader,Data.Phase_Leader(end)];

%% 绘制图
CouzinColor=[235 45 46;
             241 161 43;
             0 170 79;
             0 174 239;
             35 31 32]/255;
         
TV = 20; %字体12
LW = 2 ; % Linewidth

nf =1;   %%%%设定figure的值
% PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
hf(nf) =figure(nf); 
set(hf(nf),'Name','RL—Results','NumberTitle','off'); %%%%设定值


Col = 1;  %%%%设定值，几列图片
Row =2; %%%%设定值，几行图片
figure_num = Col*Row; %作图个数
space_bottom=0.1;  % 底部间距 %%%%设定值
space_top=0.04;%顶部间距  %%%%设定值
space_left=0.15;%左间距  %%%%设定值
space_right=0.05;%右间距  %%%%设定值
space_UD=0.05;%图片上下间距  %%%%设定值
space_LR = 0.09; % 图片左右间距  %%%%设定值
space_legend=0 ;  %图和标注之间的距离设置  %%%%设定值
FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值

WidthSubFig = 6 ; % 子图宽度为5 %%%%设定值
HighSubFig = 0.9*WidthSubFig;   %%%%设定值

set(hf(nf),'Units', 'centimeters','Position',[55.4872    6.2653   18.8172   18.4563], 'WindowStyle','normal' )

% set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])

StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols 


StrLegend = {'Power Cost of Left Robotic Fish', ...
             'Power Cost of Right Robotic Fish', ...
             'Swimming Speed of Schooling fish',...
             'Swimming Speed of alone fish'};  % 设定 Legend 的字符
         
% LocaLegend = [0.58 0.926453690834256 0.197974905237045 0.053981279662739;
%                         0.58 0.703780922617089 0.220472053772767 0.053981279662739;
%                         0.58 0.487181041873621 0.289088356806719 0.053981279662739;
%                         0.58 0.260459671344211 0.289088356806719 0.053981279662739];
% TextPosition = [ 2.35,4.0;
%                           4.7, 0.036;
%                           2.35,9;
%                           4.7,0.36;
%                           2.35,9;
%                           4.75,0.36;
%                           2.35,9;
%                           4.7,0.36];
                     
f =1 ;
% 绘制
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);

% shadedErrorBar(PD,MeanPowerLeft,StdPowerLeft,{'linewidth',1.2,'Color',CouzinColor(1,:)},1)

plot (RL_Data,'linewidth',LW,'Color',CouzinColor(1,:))
% hold on
% shadedErrorBar(PD,MeanPowerRight,StdPowerRight,{'linewidth',1.2,'Color',CouzinColor(3,:)},1)
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
set(gca,'XTickLabel',{},'FontSize',TV);  
box off;
ylabel('Average energy cost [W]','FontSize',TV,'Rotation',90);
legend('Fin sensory feedback')
legend boxoff

f = 2;
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
plot(Random_Data,'linewidth',LW,'Color',CouzinColor(2,:))
% shadedErrorBar(PD,MeanSpeed, StdSpeed,{'linewidth',LW,'Color',CouzinColor(4,:)},1);
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
% shadedErrorBar(iPD,iMeanSpeed, iStdSpeed,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
% set(gca,'XTickLabel',{},'FontSize',TV);  
set(gca,'FontSize',TV);  
box off;
ylabel('Average energy cost [W]','FontSize',TV,'Rotation',90);
legend('No feedback')
legend boxoff
xlabel('Episode','FontSize',TV)

set(gcf,'paperposition',get(gcf,'position'))

% print(gcf,'RL_Random_4paper_100Evn', '-dpng', '-r300')



%% 
% close all
TV = 20; %字体12
LW = 2 ; % Linewidth

nf =2;   %%%%设定figure的值
% PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
hf(nf) =figure(nf); 
set(hf(nf),'Name','RL—Results','NumberTitle','off'); %%%%设定值


Col = 1;  %%%%设定值，几列图片
Row =4; %%%%设定值，几行图片
figure_num = Col*Row; %作图个数
space_bottom=0.1;  % 底部间距 %%%%设定值
space_top=0.04;%顶部间距  %%%%设定值
space_left=0.15;%左间距  %%%%设定值
space_right=0.05;%右间距  %%%%设定值
space_UD=0.05;%图片上下间距  %%%%设定值
space_LR = 0.09; % 图片左右间距  %%%%设定值
space_legend=0 ;  %图和标注之间的距离设置  %%%%设定值
FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值

WidthSubFig = 18 ; % 子图宽度为5 %%%%设定值
HighSubFig = 0.3*WidthSubFig;   %%%%设定值

set(hf(nf),'Units', 'centimeters','Position',[55.4872    6.2653   WidthSubFig*Col   HighSubFig*Row], 'WindowStyle','normal' )

% set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])

StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols 


StrLegend = {'Power Cost of Left Robotic Fish', ...
             'Power Cost of Right Robotic Fish', ...
             'Swimming Speed of Schooling fish',...
             'Swimming Speed of alone fish'};  % 设定 Legend 的字符
         
% LocaLegend = [0.58 0.926453690834256 0.197974905237045 0.053981279662739;
%                         0.58 0.703780922617089 0.220472053772767 0.053981279662739;
%                         0.58 0.487181041873621 0.289088356806719 0.053981279662739;
%                         0.58 0.260459671344211 0.289088356806719 0.053981279662739];
% TextPosition = [ 2.35,4.0;
%                           4.7, 0.036;
%                           2.35,9;
%                           4.7,0.36;
%                           2.35,9;
%                           4.75,0.36;
%                           2.35,9;
%                           4.7,0.36];
t = 0:10;
f =1 ;
% 绘制
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);

% shadedErrorBar(PD,MeanPowerLeft,StdPowerLeft,{'linewidth',1.2,'Color',CouzinColor(1,:)},1)

stairs (t,RL_Phase_Leader,'linewidth',LW,'Color',CouzinColor(f,:))
% hold on
% shadedErrorBar(PD,MeanPowerRight,StdPowerRight,{'linewidth',1.2,'Color',CouzinColor(3,:)},1)
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
set(gca,'XTickLabel',{},'FontSize',TV);  
set(gca,'YTickLabel',{'0','\pi','2\pi'},...
    'YTick',[0 5 10]);
box off;
ylabel('$\Psi_{Leader}$','FontSize',TV,'Rotation',90);
hl(f)=legend('Turbulent environments');
set(hl(f),'position',[0.4134    0.7855    0.4549    0.0376]);
legend boxoff
axis([0,10,0,10])
ht = text(0.2,8,'(a)','FontSize',TV,'FontWeight','bold');

f =2 ;
% 绘制
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);

% shadedErrorBar(PD,MeanPowerLeft,StdPowerLeft,{'linewidth',1.2,'Color',CouzinColor(1,:)},1)

stairs (t,RL_Follower_Phase,'linewidth',LW,'Color',CouzinColor(f,:))
% hold on
% shadedErrorBar(PD,MeanPowerRight,StdPowerRight,{'linewidth',1.2,'Color',CouzinColor(3,:)},1)
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
set(gca,'XTickLabel',{},'FontSize',TV);  
set(gca,'YTickLabel',{'0','\pi','2\pi'},...
    'YTick',[0 5 10]);
box off;
ylabel('$\Psi_{Follower}$','FontSize',TV,'Rotation',90);
hl(f)=legend('Fin sensory feedback');
set(hl(f),'position',[ 0.3919    0.5569    0.4196    0.0376]);
legend boxoff
axis([0,10,0,10])
ht = text(0.2,9,'(b)','FontSize',TV,'FontWeight','bold');

f = 3;
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
stairs(t,Random_Phase_Leader,'linewidth',LW,'Color',CouzinColor(f,:))
% shadedErrorBar(PD,MeanSpeed, StdSpeed,{'linewidth',LW,'Color',CouzinColor(4,:)},1);
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
% shadedErrorBar(iPD,iMeanSpeed, iStdSpeed,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
% set(gca,'XTickLabel',{},'FontSize',TV);  
set(gca,'XTickLabel',{},'FontSize',TV);
set(gca,'YTickLabel',{'0','\pi','2\pi'},...
    'YTick',[0 5 10]);
box off;
ylabel('$\Psi_{Leader}$','FontSize',TV,'Rotation',90);
hl(f)=legend('Turbulent environments');
set(hl(f),'position',[0.3996    0.4705    0.4549    0.0376]);
legend boxoff
% xlabel('Episode','FontSize',TV)
axis([0,10,0,10])
ht = text(0.2,9,'(c)','FontSize',TV,'FontWeight','bold');

f = 4;
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
stairs(t,Random_Follower_Phase,'linewidth',LW,'Color',CouzinColor(f,:))
% shadedErrorBar(PD,MeanSpeed, StdSpeed,{'linewidth',LW,'Color',CouzinColor(4,:)},1);
% set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
%     'XTick',[1 2 3 4 5 6 7 8 9]);
% shadedErrorBar(iPD,iMeanSpeed, iStdSpeed,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);
set(gca,'XTickLabel',{'0','2T','4T','6T','8T','10T'},...
    'XTick',[0 2  4  6  8 10]);
set(gca,'YTickLabel',{'0','\pi','2\pi'},...
    'YTick',[0 5 10]);
% set(gca,'XTickLabel',{},'FontSize',TV);  
set(gca,'FontSize',TV);  
box off;
ylabel('$\Psi_{Follower}$','FontSize',TV,'Rotation',90);
hl(f)=legend('No feedback');
set(hl(f),'position',[0.4175    0.2434    0.2822    0.0376]);
legend boxoff
xlabel('Time [s]','FontSize',TV)

set(gcf,'paperposition',get(gcf,'position'))
axis([0,10,0,10])
ht = text(0.2,8,'(d)','FontSize',TV,'FontWeight','bold');

% print(gcf,'RL_Random_4paper_PD', '-dpng', '-r300')

