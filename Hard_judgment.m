%硬判决--使用欧式距离/二范数
function out =  Hard_judgment(x)
%输入为[1,Frame_Len],输出为[1,Frame_Len]
global Frame_Len;  %---帧长,即T的长度；   
%方式一，使用二范数
a=sqrt(1/2)*[1+1i,1-1i,-1+1i,-1-1i];
for ii=1:length(x)
    m1=x(:,ii);
    for jj=1:1:length(a)
        b1(jj)=norm(m1-a(:,jj));
    end
    [~,index] =find(b1 == min(b1)); 
    out(ii)=a(:,index);   %方式二：二范数
end    


%方式二：欧式距离
% xpan(:,1) = real(x);
% xpan(:,2) = imag(x);
% z = sqrt(0.5);
% x1 = z*ones(Frame_Len,2);
% x2(:,1) = z*ones(Frame_Len,1);
% x2(:,2) = -1*z*ones(Frame_Len,1);
% x3(:,1) = -1*z*ones(Frame_Len,1);
% x3(:,2) = z*ones(Frame_Len,1);
% x4 = -1*z*ones(Frame_Len,2);
% dis(:,1) = sqrt(sum((xpan-x1).^2,2));    
% dis(:,2) = sqrt(sum((xpan-x2).^2,2));
% dis(:,3) = sqrt(sum((xpan-x3).^2,2));
% dis(:,4) = sqrt(sum((xpan-x4).^2,2));
% [~,pos] = min(dis,[],2); 
% loc1 = find(pos==1); loc2 = find(pos==2); loc3 = find(pos==3); loc4 = find(pos==4);
% out2(loc1) = z+1i*z; out2(loc2) = z-1i*z; out2(loc3) = -1*z+1i*z; out2(loc4) = -1*z-1i*z;
end


















