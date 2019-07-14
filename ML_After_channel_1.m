%ML检测，用qpsk（过信道检测）

clear all;
clc;
close all;
warning off;

global K;       %ML迭代次数
global arf;     %ML迭代参数
global Frame_Len;  %---帧长,即T的长度； 
global H_Vector;

global data_DTEC;
global amplite;

data_DTEC = data_DTECfcn();


%---参数设置----
Frame_Len =4;  %---设置帧长,即T的长度；
NUM=10^6;   %发送帧的个数
M_antenna=4;
K_ChannelDim =4;  %信道的维度
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
        %数据产生
        [x_data_bit,x_data] = data_gen(Frame_Len, BIT_num); 
        x_data_1 = x_data.';
        x_data1=amplite*x_data_1;     

        %过信道，加噪声
        H_Vector = sqrt(0.5/M_antenna)*( randn(M_antenna,Frame_Len) + 1i*randn(M_antenna,Frame_Len) );      
        y_data1 = H_Vector*x_data1.';  
        y_data = y_data1 +sqrt(0.5)*( randn(M_antenna,1) + 1i*randn(M_antenna,1) ) ;    
        
        %ML检测  
%         detect_po=(1/sqrt(Ex)*pinv(H_Vector)*y_data).';     %MF匹配滤波检测
        detect_po=(1/amplite*pinv(H_Vector'*H_Vector)*H_Vector'*y_data).';     %ZF破零检测
        detect_theory= Detect_theory_1(y_data);    %ML检测
        detect_mmse=(pinv(H_Vector'*H_Vector+(1/Ex)*eye(4,4))*H_Vector'*(y_data/amplite)).';    %mmse检测
        %判决
        y_bit_detect_po=Hard_judgment(detect_po);
        y_bit_detect_theory=Hard_judgment(detect_theory);
        y_bit_detect_mmse=Hard_judgment(detect_mmse);
%         
        %映射
        bit_detect_po =  Mapping(y_bit_detect_po,BIT_num);
        bit_detect_theory =  Mapping(y_bit_detect_theory,BIT_num);
        bit_detect_mmse =  Mapping(y_bit_detect_mmse,BIT_num);
        
        %误码个数
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
xlabel('信噪比（SNR）');
ylabel('误码率');
legend('BER_po','BER_theory','BER_mmse');