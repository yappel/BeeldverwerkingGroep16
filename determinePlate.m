function [ plate ] = determinePlate( result, patternid )
%DETERMINEPLATE Summary of this function goes here
%   Detailed explanation goes here


%Contains the 6 characters determined by the charRecogn function
character = ['' '' '' '' '' ''];
for i = 1:6
    character(i) = char(result{i}(1,1));
end

%For every element check if it is a letter or a number
check = isletter(character);
%Create an id for the char sequence
id = [num2str(check(1)) num2str(check(2)) num2str(check(3)) num2str(check(4)) num2str(check(5)) num2str(check(6))];

%With the patternid we can decide how the plate id needs to look like
if patternid==5
    allowed = {'100011' '011100'};
elseif patternid==6
    allowed = {'001111' '111100'};
elseif patternid==7
    allowed = {'110001' '001110'};
else
    allowed = {};
end

%Check if the intial char sequence is a valid license plate
iscorrect = ismember(id, allowed);

if iscorrect == 1
    plate = addLines(character, id); %Add lines between chars on the right places
elseif numel(allowed) ==0
    plate = ''; %If this happens we do not know how the license plate is supposed to look like
else
    %There always 2 id allowed and our current id is not one of those
    %Calculate how much characters in the current id are different 
    difference = zeros(6,2); %difference(:,1) holds the differnce with allowed id 1
    for i = 1:6
        allowed1{1} = allowed{1}(i);
        allowed1{2} = allowed{2}(i);
        difference(i,:) = strcmp(id(i),allowed1);
    end
    
    %If the id closer to allowed id number 1
    if sum(difference(:,1)) > sum(difference(:,2))
        %Get the indexes of the chars that need to be changed
        [notimportant, charWrongIndex] = min(difference(:,1));
        %Change everyone of them
        for k = 1:length(charWrongIndex)
            for i = 1:(6-sum(difference(:,1)))
                character = changeWrongChar(character, charWrongIndex(k), result);
            end
        end
    %If the id closer to allowed id number 2
    elseif sum(difference(:,1)) < sum(difference(:,2))
        [notimportant, charWrongIndex] = min(difference(:,2));
        for k = 1:length(charWrongIndex)
            for i = 1:(6-sum(difference(:,2)))
               character = changeWrongChar(character, charWrongIndex(k), result);
            end
        end
    else
        %If both allowed id are equally likely to be the right one:
        
        characterOptions = cell(2,1);
        characterOptions{1} = character;
        characterOptions{2} = character;
        Likelyhood =[0, 0]; %Sum of all the % correct of all the chars
        for i = 1:6
            Likelyhood(1) =  Likelyhood(1) + result{i}(1,2);
            Likelyhood(2) =  Likelyhood(2) + result{i}(1,2);
        end

        amountRight = sum(difference(:,1)); %== sum(difference(:,2)
        
        for kk = 1:2
            [notimportant, charWrongIndex] = min(difference(:,kk));%Get indexes of chars that needs to be changed
            for k = 1:length(charWrongIndex) 
                for i = 1:(6-amountRight)
                    out = changeWrongChar(character, charWrongIndex(k), result, Likelyhood(k));
                    characterOptions{k} = out{1};
                    Likelyhood(k) = out{2};
                end
            end
        end
        
        if Likelyhood(1) > Likelyhood(2)
            character = characterOptions{1};
        else
            character = characterOptions{2};
        end
    end   
    
    %Calculate the id of the new char sequence and check if it is now
    %correct
    check = isletter(character);
    id = [num2str(check(1)) num2str(check(2)) num2str(check(3)) num2str(check(4)) num2str(check(5)) num2str(check(6))];
    iscorrect = ismember(id, allowed);
         
    if iscorrect == 1
        plate = addLines(character, id);
    else
%         plate = [character(1) character(2) character(3) character(4) character(5) character(6)];
          plate = '';
    end
    
end

end

function [plate] = addLines(character, id) 
    if strcmp(id, '100011')
            plate = [character(1) '-' character(2) character(3) character(4) '-' character(5) character(6)];
        elseif strcmp(id, '110001')
            plate = [character(1) character(2) '-' character(3) character(4) character(5) '-' character(6)];
        elseif strcmp(id, '011100')
            plate = [character(1) '-' character(2) character(3) character(4) '-' character(5) character(6)];
        elseif strcmp(id, '001110')
            plate = [character(1) character(2) '-' character(3) character(4) character(5) '-' character(6)];
        elseif strcmp(id, '001111')
            plate = [character(1) character(2) '-' character(3) character(4) '-' character(5) character(6)];
        elseif strcmp(id, '111100')
            plate = [character(1) character(2) '-' character(3) character(4) '-' character(5) character(6)];
    end
end



function [out] = changeWrongChar(character, index, result, likelyhood)
    
    isLetter = isletter(character(index));
    option1 = char(result{index}(2,1));
    option2 = char(result{index}(3,1));
    
    if isletter(option1) ~= isLetter
        character(index) = option1;
        if nargin == 4
            likelyhood = likelyhood - result{index}(1,2) + result{index}(2,2);
        end
    elseif isletter(option2) ~= isLetter
        character(index) = option2;
        if nargin == 4
            likelyhood = likelyhood - result{index}(1,2) + result{index}(3,2);
        end
    end
    
    if nargin == 3
        out = character;
    elseif nargin == 4
        out = {character, likelyhood};
    end
    
end


