function data_DTEC =  data_DTECfcn(x)
%生成256种供检测数据
a1=sqrt(1/2)*[1+1i,1-1i,-1+1i,-1-1i];
y=0;
for a=1:1:4
    for b=1:1:4
        for c=1:1:4
            for d=1:1:4
                 y=y+1;
                 m(y,1)=a1(1,a);
                 m(y,2)=a1(1,b);
                 m(y,3)=a1(1,c);
                 m(y,4)=a1(1,d);
            end
        end
    end
end
data_DTEC=m;



