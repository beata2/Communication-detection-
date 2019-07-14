%ML检测           
function out =  Detect_theory_1(x)
global Frame_Len;  %---帧长,即T的长度；  
global H_Vector;
global data_DTEC;
global amplite;

m = data_DTEC;
%欧式判决迭代找值
a= size(m);
for ii=1:a(1,1)
    m1=H_Vector*amplite*m(ii,:).';
    dim(ii)=norm(x-m1);   
end     

[~,index] = find(dim == min(dim)); 
out=m(index,:);           
    