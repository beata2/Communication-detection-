%Ӳ�о�--ʹ��ŷʽ����/������
function out =  Hard_judgment(x)
%����Ϊ[1,Frame_Len],���Ϊ[1,Frame_Len]
global Frame_Len;  %---֡��,��T�ĳ��ȣ�   
%��ʽһ��ʹ�ö�����
a=sqrt(1/2)*[1+1i,1-1i,-1+1i,-1-1i];
for ii=1:length(x)
    m1=x(:,ii);
    for jj=1:1:length(a)
        b1(jj)=norm(m1-a(:,jj));
    end
    [~,index] =find(b1 == min(b1)); 
    out(ii)=a(:,index);   %��ʽ����������
end    


%��ʽ����ŷʽ����
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


















