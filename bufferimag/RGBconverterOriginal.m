originalimage = imread("empty.png");
resizedimage = imresize(originalimage, [52 52]);

		
%Extract RED, GREEN and BLUE components from the image
R = resizedimage(:,:,1);			
G = resizedimage(:,:,2);
B = resizedimage(:,:,3);

%make the numbers to be of double format for 
R = double(R);	
G = double(G);
B = double(B);

%Raise each member of the component by appropriate value. 
R = R.^(3/8); % 8 bits -> 3 bits
G = G.^(3/8); % 8 bits -> 3 bits
B = B.^(1/4); % 8 bits -> 2 bits

%tranlate to integer
R = uint8(R); % float -> uint8
G = uint8(G);
B = uint8(B);

%minus one cause sometimes conversion to integers rounds up the numbers wrongly
R = R-1; % 3 bits -> max value is 111 (bin) -> 7 (dec)(hex)
G = G-1;
B = B-1; % 11 (bin) -> 3 (dec)(hex)

%shift bits and construct one Byte from 3 + 3 + 2 bits
G = bitshift(G, 3); % 3 << G (shift by 3 bits)
B = bitshift(B, 6); % 6 << B (shift by 6 bits)
COLOR = R+G+B;      % R + 3 << G + 6 << B

%save variable COLOR to a file in HEX format for the chip to read
fileID = fopen (['empty.list'], 'w');
for i = 1:size(COLOR(:), 1)-1
    fprintf (fileID, '%x\n', COLOR(i)); % COLOR (dec) -> print to file (hex)
end
fprintf (fileID, '%x', COLOR(size(COLOR(:), 1))); % COLOR (dec) -> print to file (hex)
fclose (fileID);
