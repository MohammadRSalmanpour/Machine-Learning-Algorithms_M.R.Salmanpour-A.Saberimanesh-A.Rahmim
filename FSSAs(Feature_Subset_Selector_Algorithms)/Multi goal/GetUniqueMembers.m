function UA=GetUniqueMembers(A)

    u=true(size(A));
    
    for i=2:numel(A)
        for j=1:i-1
            if IsSame(A(i),A(j))
                u(i)=false;
                break;
            end
        end
    end
    
    UA=A(u);

end

function e=IsSame(a,b)

    e=all(a.Position==b.Position);

end