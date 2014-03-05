function [object1Present, object2Present] = isObjectPresent(points1, points2, centers)

found1 = find(points1);
found2 = find(points2);

object1Present = false;
object2Present = false;

if ~isempty(found1)
    object1Present = true;
end

if ~isempty(found2)
    object2Present = true;
end

if isempty(found1) & ~isempty(found2) & length(centers) > 2
    object1Present = true;
end

if ~isempty(found1) & isempty(found2) & length(centers) > 2
    object2Present = true;
end
    
if  isempty(centers)
    object1Present = false;
    object2Present = false;
else
    object1Present = true;
end

end

