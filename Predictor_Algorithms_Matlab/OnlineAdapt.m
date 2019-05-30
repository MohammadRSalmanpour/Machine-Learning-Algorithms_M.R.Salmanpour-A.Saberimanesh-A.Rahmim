function [ C V ] = OnlineAdapt( C, V, th )
%Author: Abdolreza shirvani.
%ver: .1
[index1 index2] = find(phi(Xtrn,C,V) >= th);