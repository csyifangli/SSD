function result = ssd(D,y,maxiter)
%This program aims to solve a undeterminated linear system by SSD algorithm.

%Initialization
t1 = clock;
[mmm nnn] = size(D);
indices = [];   %indices picked up
remain = [1:nnn];   %indices remained in D
kkk = 0;    %times of iterations
stack_matrix = zeros(nnn);  %matrix constructed by decimation
stack_y = zeros(nnn,1);     %y constructed by decimation 
beta = zeros(mmm,1);   %guidance vector

%Iteration
while( sum(abs(y))/mmm > 1.0e-5 )
   index = guidance_convex(D,y,beta,maxiter);
   indices = [indices;remain(index)];     %Put real index into the indices.
   dindex = D(:,index);
   dindex_2 = norm(dindex)^2;
   
   for iii = 1:nnn-kkk
       if iii == index
           stack_matrix(kkk+1,remain(iii))=1;
       else
           overlap_di_dindex = (D(:,iii)'*dindex) / dindex_2;
           stack_matrix(kkk+1,remain(iii)) = overlap_di_dindex;
           D(:,iii) = D(:,iii) - overlap_di_dindex * dindex;
       end
      
   end
   overlap_y_dindex = (y'*dindex) / dindex_2;
   stack_y(kkk+1) = overlap_y_dindex; 
   y = y - overlap_y_dindex * dindex;
   
   D(:,index) = [];
   remain(index) = [];
   kkk = kkk+1;
   if nnn>5000
   disp([num2str(kkk),'th iteration is done. The residual y is ',num2str(sum(abs(y))/mmm),'.'])
   end
end

%Solve and Output
x_nonzero = stack_matrix(1:kkk,indices) \ stack_y(1:kkk);
result = zeros(nnn,1);
result(indices) = x_nonzero;
t2 = clock;
timecost = etime(t2,t1);
disp(['Over! Total time cost is ',num2str(timecost),'1']);
end

