function [x_data_bit,x_data] =  data_gen(Frame_Len, BIT_num)
%产生[Frame_Len,1]的x_data数据，[1,BIT_num*Frame_Len]的x_data_bit数据
     Temp_data = 1-2*rand(Frame_Len,BIT_num);
     x_data_bit(find(Temp_data >=0 )) = 1;
     x_data_bit(find(Temp_data <0 )) = 0;     
     temp_x_data(find(x_data_bit ==0 )) = sqrt(0.5);
     temp_x_data(find(x_data_bit ==1 )) = -sqrt(0.5);

     temp_x_data_1=reshape(temp_x_data,Frame_Len,BIT_num);
     x_data = temp_x_data_1(:,1) +1i*temp_x_data_1(:,2);    
end