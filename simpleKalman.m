clear
close all
[time,data] = rtpload('try4.rtp');

flow_x = data.velocity_x;
flow_y = data.velocity_y;
z = horzcat(flow_x, flow_y);
mu = cell(1, length(z));
cov = cell(1,length(z));

A_t = [1 0; 0 1];


R_t = [0 0;0 0];

C_t = [1 0; 0 1];

Q_t = [var(flow_x) 0;0 var(flow_y)];

%Initial Conditions
mu{1} = [mean(flow_x);mean(flow_y)];
cov{1} = [0.2 0; 0 0.2];

for t=2:length(z)
    
   mu{t} = A_t*mu{t-1};
   
   
   cov{t} = A_t*cov{t-1}*A_t' + R_t;
   
   
   K_t = cov{t}*C_t'*inv(C_t*cov{t}*C_t' + Q_t);
   
   
   mu{t} = mu{t} + K_t*(z(t-1) - C_t*mu{t});
   
   cov{t} = (eye(2) - K_t*C_t)*cov{t};
   
end

filter_flow = cell2mat(mu);
filter_flow_x = filter_flow(1,:);
filter_flow_y = filter_flow(2,:);
plot(time,flow_x,time,filter_flow_x);

