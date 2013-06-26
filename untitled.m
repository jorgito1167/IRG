z = fopen(data.rtp);
mu = cell(1, length(z)+1);
cov = cell(1,length(z)+1);

A_t = [1 0; 0 1];


R_t = [? ?;? ?];

C_t = [1 0; 0 1];

Q_t = [? ?;? ?];

%Initial Conditions
mu{1} = [0;0];
cov{1} = [? ?; ? ?];

for t=2:length(data)+1
    
   mu{t} = A_t*mu{t-1};
   
   cov{t} = A_t*mu{t-1}*A_t' + R_t;
   
   
   K_t = cov{t}*C_t'*(C_t*cov{t}*C_t' + Q_t)^-1;
   
   
   mu{t} = mu{t} + K_t( z(t) - C_t*mu{t});
   
   cov{t} = (I - K_t*C_t)*cov{t};
   
end
   