numRight=0;
wrong=0;

% yhat=yhat-beeeeeeeest;
for i = 1 : 98
    % Compute the scores for both categories.
    % Validate the result.
    if Yh2(i)==Ytst(i)
        numRight = numRight + 1;
    else
        wrong = wrong + 1;
    end
end
numRight
wrong
numRight/98
figure;
plot(Yh2,'r*');
hold on;
plot(Ytst,'go');
legend('output','lblTest'); 
% xlabel('Time')
% ylabel('Value')
% title(['Linear function with ' num2str(nn) ' neurons.'])
% hold off
