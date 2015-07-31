function build_graph_error_bounds(data,proj)
% Build three graphs
%
%--------------------------------------------------------------------------
%
if ~isempty(data.V1)
    figure;
    semilogy(proj,data.V1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
    hold on
    semilogy(proj,data.V2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
    semilogy(proj,data.V3(:,1),'k-o','LineWidth',2,'MarkerSize',8);
    semilogy(proj,data.V4(:,1),'r-x','LineWidth',2,'MarkerSize',8);
    
    legend('EB1','EB2','EB3','EB4')
    hold off;
    set(gca,'fontsize',15)
    xlabel('Number of angles','fontsize',20)
    ylabel('Fraction of pixels','fontsize',20)
    title('Error bounds on the difference between 2 binary solutions','fontsize',12)
end
%
%--------------------------------------------------------------------------
%
if ~isempty(data.U1)
    figure;
    semilogy(proj,data.U1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
    hold on
    semilogy(proj,data.U2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
    semilogy(proj,data.Pr(:,1),'k-o','LineWidth',2,'MarkerSize',8);
    
    legend('EB1','EB2','Pr')
    hold off;
    set(gca,'fontsize',15)
    xlabel('Number of angles','fontsize',20)
    ylabel('Fraction of pixels','fontsize',20)
    title('Error bounds on the difference between r and any binary solution','fontsize',12)
end
%
%--------------------------------------------------------------------------
%
if ~isempty(data.Pv)
    figure;
    semilogy(proj,data.VX1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
    hold on
    semilogy(proj,data.VX2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
    semilogy(proj,data.VX3(:,1),'k-o','LineWidth',2,'MarkerSize',8);
    semilogy(proj,data.Pv(:,1),'r-x','LineWidth',2,'MarkerSize',8);
    
    legend('EB1','EB2','EB3','Pv')
    hold off;
    set(gca,'fontsize',15)
    xlabel('Number of angles','fontsize',20)
    ylabel('Fraction of pixels','fontsize',20)
    title('Error bounds on the difference between a binary vector and any binary solution','fontsize',12)
end
