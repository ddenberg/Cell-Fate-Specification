function splitVectors = splitVector(inputVector, n)

% Calculate the size of each sub-vector
subVectorSize = floor(length(inputVector) / n);

% Calculate the number of sub-vectors that will have one extra element
extraElements = rem(length(inputVector), n);

% Initialize the cell array to store sub-vectors
splitVectors = cell(1, n);

% Split the vector into approximately equal sized sub-vectors
startIndex = 1;
for i = 1:n
    % Calculate the size of the sub-vector
    if i <= extraElements
        endIndex = startIndex + subVectorSize;
    else
        endIndex = startIndex + subVectorSize - 1;
    end
    
    % Assign the sub-vector
    splitVectors{i} = inputVector(startIndex:endIndex);
    startIndex = endIndex + 1;
end

end