u=0:0.02:1
state=1:2:400

x=[]
y=[]
z=[]
for i=u
    for j=10000:10000
        x(end+1)=i;
        y(end+1)=j;
        z(end+1)= func(i,j,12+273);
    end
end
%plot3(x,y,z,'*')
plot(x,z)