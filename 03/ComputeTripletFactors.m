function factors = ComputeTripletFactors (images, tripletList, K)
% This function computes the triplet factor values for one word.
%
% Input:
%   images: An array of structs containing the 'img' value for each
%     character in the word.
%   tripletList: An array of the character triplets we will consider (other
%     factor values should be 1). tripletList(i).chars gives character
%     assignment, and triplistList(i).factorVal gives the value for that
%     entry in the factor table.
%   K: The alphabet size (accessible in imageModel.K for the provided
%     imageModel).
%
% Hint: Every character triple in the word will use the same 'val' table.
%   Consider computing that array once and then resusing for each factor.
%
% Copyright (C) Daphne Koller, Stanford University, 2012


n = length(images);

% If the word has fewer than three characters, then return an empty list.
if (n < 3)
    factors = [];
    return
end

factors = repmat(struct('var', [], 'card', [], 'val', []), n - 2, 1);

% Your code here:
for ii=1:n-2
   factors(ii).var = [ii, ii+1, ii+2];
   factors(ii).card = [K, K, K];
   factors(ii).val(1:prod(factors(ii).card)) = 1;
   for jj=1:length(tripletList)
     assignment = tripletList(jj).chars;
     ind = AssignmentToIndex(assignment, factors(ii).card);
     factors(ii).val(ind) = tripletList(jj).factorVal;
   end
   factors(ii).val = factors(ii).val./tripletList(end).factorVal;
end

end
