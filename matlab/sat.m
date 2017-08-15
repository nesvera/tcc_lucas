function y = sat(u, limit)
%#eml
y = zeros(length(u),1);

for j=1:length(u)
   if abs(u(j))<limit(j)
       y(j)=u(j)/limit(j);
   else
       y(j)=sign(u(j));
   end
end

end

