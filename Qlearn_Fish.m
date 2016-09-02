function iStra=Qlearn_Fish(NS,NA,R)


% NA = 10;
% NS = 10;

Q = zeros(NS,NA);
% R = [-1 -1 -1 -1  0 -1;
%     -1 -1 -1  0 -1  100;
%     -1 -1 -1  0 -1 -1;
%     -1  0  0 -1  0 -1;
%     0 -1 -1  0 -1  100;
%     -1  0 -1 -1  0  100];

% R = 3- ones(NS,1)*[2.771645964, 2.783483562, 2.791952364, 2.760713406, 2.74342257, 2.772012354, 2.82915417, 2.86940475, 2.875204698, 2.810502378];
% R = 3 - ones(NS,1)*[2.849237346,2.832270984,2.799873048,2.829850224,2.81956953,2.771836032,2.737286328,2.78535423,2.836535046,2.873305188,2.76192333];
maxIter = 200000;

Gamma = 0.8;

% [r,c] = find(R+1);

% action = 6;

for i_iter = 1:maxIter
    
%     if action == 6
        ran = rand(1);
        complete = 0;
        state = 1;
        sum = 1/NS;
        while 0==complete
            
            if ran<sum
                
                complete=1;
                
            else
                
                state=state+1;
                
                sum=sum+1/NS;
                
            end
        end
%     end
    
%     action_candi = find(r==state);
    
    
    ran = rand(1);
%     n_candi = length(action_candi);
    candidate = 1;
    sum = 1/NS;
    complete = 0;
    while 0==complete
        
        if ran<sum
            
            complete=1;
            
        else
            
            candidate = candidate +1;
            
            sum=sum+1/NS;
            
        end
    end
    
    action = candidate;
    
%     num_next = find(r==action);
    
%     ar = r(num_next);
%     ac = c(num_next);
    
    Q(state,action) = R(state, action) + 0.8 * max(Q(action,:));
    
    state = action;
    
end

[vStra,iStra]= max(max(Q));
end
