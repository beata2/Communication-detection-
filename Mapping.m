%解调，映射回去
function bit_detect =  Mapping(x,BIT_num)
%输入[1,Frame_Len]，输出为[Frame_Len*BIT_num,1]
global Frame_Len;  %---帧长,即T的长度； 

 xMap(:,1) = real(x);
 xMap(:,2) = imag(x);
 temp_y_data(find(xMap ==sqrt(0.5) )) =0 ;
 temp_y_data(find(xMap ==-sqrt(0.5))) = 1;
 bit_detect=reshape(temp_y_data,Frame_Len*BIT_num,1);
end