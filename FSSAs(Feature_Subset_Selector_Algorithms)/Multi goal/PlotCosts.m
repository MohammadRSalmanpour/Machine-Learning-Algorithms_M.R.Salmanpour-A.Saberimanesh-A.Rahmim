function PlotCosts(pop)

    Costs=[pop.Cost];
    
    plot(Costs(1,:),Costs(2,:),'r*','MarkerSize',8);
    xlabel('n_f');
    ylabel('E');
    grid on;

end