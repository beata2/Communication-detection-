%�����ӳ���ȥ
function bit_detect =  Mapping(x,BIT_num)
%����[1,Frame_Len]�����Ϊ[Frame_Len*BIT_num,1]
global Frame_Len;  %---֡��,��T�ĳ��ȣ� 

 xMap(:,1) = real(x);
 xMap(:,2) = imag(x);
 temp_y_data(find(xMap ==sqrt(0.5) )) =0 ;
 temp_y_data(find(xMap ==-sqrt(0.5))) = 1;
 bit_detect=reshape(temp_y_data,Frame_Len*BIT_num,1);
end