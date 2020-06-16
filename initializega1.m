function [pop] = initializega1(num, bounds, evalFN, evalOps, options)
% function [pop]=initializega(populationSize, variableBounds,evalFN,
%                           evalOps,options)
%    initializega creates a matrix of random numbers with 
%    a number of rows equal to the populationSize and a number
%    columns equal to the number of rows in bounds plus 1 for
%    the f(x) value which is found by applying the evalFN.
%    This is used by the ga to create the population if it
%    is not supplied.
%
% pop            - the initial, evaluated, random population 
% populatoinSize - the size of the population, i.e. the number to create
% variableBounds - a matrix which contains the bounds of each variable, i.e.
%                  [var1_high var1_low; var2_high var2_low; ....]
% evalFN         - the evaluation fn, usually the name of the .m file for 
%                  evaluation
% evalOps        - 是一个结构体，包含 inputNum, hiddenNum, outputNum, net, XTrain, TTrain ，用于计算适应度值
% options        - options to the initialize function, ie. 
%                  [type prec] where eps is the epsilon value 
%                  and the second option is 1 for float and 0 for binary, 
%                  prec is the precision of the variables defaults [1e-6 1]


% Binary and Real-Valued Simulation Evolution for Matlab GAOT V2 
% Copyright (C) 1998 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

if nargin < 5
    options = [1e-6 1]; % 输入参数个数小于5，则由程序给补上第5个参数
end
if nargin < 4
    disp('Insufficient arguements') ;    % 输入参数个数小于5，则由程序给补上第5个参数
    return;
end
inputNum  = evalOps.inputNum;
hiddenNum = evalOps.hiddenNum;
outputNum = evalOps.outputNum;
net = evalOps.net;
XTrain = evalOps.XTrain;
TTrain = evalOps.TTrain;
if any( evalFN < 48 ) % Not a .m file %为什么是48？
    if options(2) == 1 % Float GA % options为精度及编码形式，1为浮点编码，0为二进制编码；
        estr = ['x=pop(i,1); pop(i,xZomeLength)=', evalFN ';'];  
    else % Binary GA
        estr = ['x=b2f(pop(i,:),bounds,bits); pop(i,xZomeLength)=', evalFN ';'];
    end

else %A .m file
    if options(2) == 1 %Float GA
        estr = ['pop(i,xZomeLength)=' evalFN...
		'(pop(i,:), inputNum, hiddenNum, outputNum, net, XTrain, TTrain);']; 
    else %Binary GA
        estr = ['x=b2f(pop(i,:),bounds,bits);v=' evalFN ...
		        '(x, inputNum, hiddenNum, outputNum, net, XTrain, TTrain);pop(i,:)=[f2b(x,bounds,bits) v];']; 

    end
  
end


numVars = size(bounds, 1); 		%Number of variables
rng = ( bounds(:, 2) - bounds(:, 1) )'; %The variable ranges'

if options(2) == 1 %Float GA
  xZomeLength = numVars + 1; 		%Length of string is numVar + fit
  pop = zeros(num, xZomeLength); 	%Allocate the new population
  pop(:, 1 : numVars) = (ones(num, 1) * rng).*(rand(num, numVars)) + ...
    ( ones(num, 1) * bounds(:, 1)' );
else %Binary GA
  bits = calcbits(bounds, options(1));
  xZomeLength = sum(bits) + 1; 		%Length of string is numVar + fit
  pop = round( rand(num, sum(bits)+1) );
end

for i = 1 : num
  eval(estr);
end
% initPpp = initializega(popu,aa,'gabpEval',[],[1e-6 1]); 种群大小为50，编码长度为114
% initializega生成初代种群，分为两步：
% 一、随机生成initPpp50行中每一行前114个值；
% 二、调用gabpEval(内部再调用gadecod)，由initPpp每一行前114个值生成第115个值（即适应度函数值）
% 第二步程序代码只有3行：79,80,81