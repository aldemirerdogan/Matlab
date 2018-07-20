%% Huffman Encoding and Decoding
%%
% Create unique symbols, and assign probabilities of occurrence to them.
symbols = 1:6; 
p = [.5 .125 .125 .125 .0625 .0625]; 
%%
% Create a Huffman dictionary based  on the symbols and their
% probabilities.
dict = huffmandict(symbols,p); 
%%
% Generate a vector of random symbols. 
sig = randsrc(100,1,[symbols; p]); 
%%
% Encode the random symbols.
comp = huffmanenco(sig,dict); 
%%
% Decode the data. Verify that the decoded data matches the original data.
dsig = huffmandeco(comp,dict);
isequal(sig,dsig)
%%
% Convert the original signal to binary, and determine its length.
binarySig = de2bi(sig);
seqLen = numel(binarySig)
%%
% Convert the Huffman encoded signal and determine its length.
binaryComp = de2bi(comp);
encodedLen = numel(binaryComp)
%%
% The Huffman encoded data required 224 bits, which is a 25% savings over
% the uncoded data.