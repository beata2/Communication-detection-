%ML��⣬��qpsk�����ŵ���⣩

clear all;
clc;
close all;
warning off;

global K;       %ML��������
global arf;     %ML��������
global Frame_Len;  %---֡��,��T�ĳ��ȣ� 
global H_Vector;

global data_DTEC;
global amplite;

data_DTEC = data_DTECfcn();


%---��������----
Frame_Len =4;  %---����֡��,��T�ĳ��ȣ�
NUM=10^6;   %����֡�ĸ���
M_antenna=4;
K_ChannelDim =4;  %�ŵ���ά��
BIT_num=2;   %QPSK-2
m1=0;    
m2=0;
m4=0; 

tic
SNR =-10:5:30;   
for jj= 1:1:length(SNR)
    for k=1:1:NUM
        SNR_Current = SNR(jj);
        Ex = 10^(0.1*SNR_Current) ;
        amplite = sqrt(Ex);
        %���ݲ���
        [x_data_bit,x_data] = data_gen(Frame_Len, BIT_num); 
        x_data_1 = x_data.';
        x_data1=amplite*x_data_1;     

        %���ŵ���������
        H_Vector = sqrt(0.5/M_antenna)*( randn(M_antenna,Frame_Len) + 1i*randn(M_antenna,Frame_Len) );      
        y_data1 = H_Vector*x_data1.';  
        y_data = y_data1 +sqrt(0.5)*( randn(M_antenna,1) + 1i*randn(M_antenna,1) ) ;    
        
        %ML���  
%         detect_po=(1/sqrt(Ex)*pinv(H_Vector)*y_data).';     %MFƥ���˲����
        detect_po=(1/amplite*pinv(H_Vector'*H_Vector)*H_Vector'*y_data).';     %ZF������
        detect_theory= Detect_theory_1(y_data);    %ML���
        detect_mmse=(pinv(H_Vector'*H_Vector+(1/Ex)*eye(4,4))*H_Vector'*(y_data/amplite)).';    %mmse���
        %�о�
        y_bit_detect_po=Hard_judgment(detect_po);
        y_bit_detect_theory=Hard_judgment(detect_theory);
        y_bit_detect_mmse=Hard_judgment(detect_mmse);
%         
        %ӳ��
        bit_detect_po =  Mapping(y_bit_detect_po,BIT_num);
        bit_detect_theory =  Mapping(y_bit_detect_theory,BIT_num);
        bit_detect_mmse =  Mapping(y_bit_detect_mmse,BIT_num);
        
        %�������
        x_po=(x_data_bit-bit_detect_po.').^2;
        m1=sum(x_po)+m1;   
        
        x_theory=(x_data_bit-bit_detect_theory.').^2;
        m2=sum(x_theory)+m2;  

        x_mmse=(x_data_bit-bit_detect_mmse.').^2;
        m4=sum(x_mmse)+m4;  
    end
        %BERb  
        BER_po(jj) = m1/(Frame_Len*BIT_num*NUM);  
        disp(SNR(jj));
        disp(BER_po(jj));
        m1=0;    
        
        BER_theory(jj) = m2/(Frame_Len*BIT_num*NUM);  
        disp(BER_theory(jj));
        m2=0; 
        
        BER_mmse(jj) = m4/(Frame_Len*BIT_num*NUM);  
        disp(BER_mmse(jj));
        m4=0; 
end    
semilogy(SNR,BER_po,'-ro',SNR,BER_formula,'-g*',SNR,BER_mmse,'-s')
xlabel('����ȣ�SNR��');
ylabel('������');
legend('BER_po','BER_theory','BER_mmse');