% ObserveEvidence Modify a vector of factors given some evidence.
%   F = ObserveEvidence(F, E) sets all entries in the vector of factors, F,
%   that are not consistent with the evidence, E, to zero. F is a vector of
%   factors, each a data structure with the following fields:
%     .var    Vector of variables in the factor, e.g. [1 2 3]
%     .card   Vector of cardinalities corresponding to .var, e.g. [2 2 2]
%     .val    Value table of size prod(.card)
%   E is an N-by-2 matrix, where each row consists of a variable/value pair. 
%     Variables are in the first column and values are in the second column.

function F = ObserveEvidence(F, E)

% Iterate through all evidence

for i = 1:size(E, 1),
    v = E(i, 1); % variable
    x = E(i, 2); % value

    % Check validity of evidence
    if (x == 0),
        warning(['Evidence not set for variable ', int2str(v)]);
        continue;
    end;

    for j = 1:length(F),
		  % Does factor contain variable?
        indx = find(F(j).var == v);

        if (~isempty(indx)),
        
		  	   % Check validity of evidence
            if (x > F(j).card(indx) || x < 0 ),
                error(['Invalid evidence, X_', int2str(v), ' = ', int2str(x)]);
            end;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % YOUR CODE HERE
            % Adjust the factor F(j) to account for observed evidence
            % Hint: You might find it helpful to use IndexToAssignment
            %       and SetValueOfAssignment
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %prob = 0.0;
            %if E(i,2)-1 > 0,
            %  prob = 1.0; 
            %end;
            %idxF = IndexToAssignment(1:length(F(j).val), F(j).card);
            %F(j) = SetValueOfAssignment(F(j), idxF(idxF(:,indx) == mod(F(j).card(indx), E(i,1)) + 1, :), prob);
            %assF = AssignmentToIndex(1:length(F(j).val), F(j).card);
            %AssignmentToIndex(A, D)
            %F(j) = SetValueOfAssignment(F(j), idxF(idxF(:,indx) == v, :), prob);
            
            assignment = IndexToAssignment(1:length(F(j).val),F(j).card);
            for i = 1: size(assignment,1),
                if assignment(i,indx) != x,
                    F(j) = SetValueOfAssignment(F(j),assignment(i,:),0);
                end;
            end;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

				% Check validity of evidence / resulting factor
            if (all(F(j).val == 0)),
                warning(['Factor ', int2str(j), ' makes variable assignment impossible']);
            end;

        end;
    end;
end;

end
