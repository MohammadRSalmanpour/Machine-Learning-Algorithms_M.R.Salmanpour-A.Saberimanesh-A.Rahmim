function tour2=CreateNeighbor(tour1)

    pSwap=0.2;
    pReversion=0.5;
    pInsertion=1-pSwap-pReversion;
    
    p=[pSwap pReversion pInsertion];
    
    METHOD=RouletteWheelSelection(p);
    
    switch METHOD
        case 1
            % Swap
            tour2=ApplySwap(tour1);
            
        case 2
            % Reversion
            tour2=ApplyReversion(tour1);
            
        case 3
            % Insertion
            tour2=ApplyInsertion(tour1);
            
    end

end