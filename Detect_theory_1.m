%ML���           
function out =  Detect_theory_1(x)
global Frame_Len;  %---֡��,��T�ĳ��ȣ�  
global H_Vector;
global data_DTEC;
global amplite;

m = data_DTEC;
%ŷʽ�о�������ֵ
a= size(m);
for ii=1:a(1,1)
    m1=H_Vector*amplite*m(ii,:).';
    dim(ii)=norm(x-m1);   
end     

[~,index] = find(dim == min(dim)); 
out=m(index,:);           
    