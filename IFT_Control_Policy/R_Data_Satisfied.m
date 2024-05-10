function Result = R_Data_Satisfied(R,r)

n=size(R,2);
count=0;

for i=1:n
    if R(i)>=r(i)
        count=count+1;
    end
end

if count==n
    Result=1;
else
    Result=0;
end
