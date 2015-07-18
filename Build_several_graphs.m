
clear all
img_sz_set = [32,64,128,256,512];
img_index_set = [1,2,3,5];
type_set = [0,1];
data = initialize;

for img_sz = img_sz_set
    for typecod = type_set
        if typecod==0
            type = 'grid';
        else
            type = 'strip';
        end
        for img_index = img_index_set
            aux = 1;
            
            img = num2str(img_index);
            sz = num2str(img_sz);
            file = strcat('data-',type,'-Im',img,'-sz',sz,'.mat');
            load(file)
            
%             for proj_index = [1:length(data.proj)]
%                 proj = num2str(data.proj(proj_index));
%                 
%                 xls = reshape(data.R{proj_index},img_sz,img_sz);
% %                 xls_name = strcat('xls-',type,'-Im',img,'-sz',sz,'-proj',proj,'.png');
% %                 imwrite(xls,xls_name,'png')
%                 r = reshape(data.r{proj_index},img_sz,img_sz);
% %                 r_name = strcat('r-',type,'-Im',img,'-sz',sz,'-proj',proj,'.png');
% %                 imwrite(r,r_name,'png')
%                 
%                 P = reshape(data.P{1},img_sz,img_sz);
%                 z = double(P/max(max(P)))-r;
%                 z=imshow(z,[min(z(:)) max(z(:))]);
%                 filename = strcat('P-r-',type,'-Im',img,'-sz',sz,'-proj',proj,'.fig');
%                 saveas(z,filename);
%                 clear z;
%                 
%                 z = double(P/max(max(P)))-xls;
%                 z=imshow(z,[min(z(:)) max(z(:))]);
%                 filename = strcat('P-xls-',type,'-Im',img,'-sz',sz,'-proj',proj,'.fig');
%                 saveas(z,filename);
%                 clear z;
%                 
%                 aux = aux+1;
%             end
            % ---------- Graphics -------------
% %             onepix = ones(length(data.proj),1)/img_sz^2;
%             it = data.proj;
%             figura =semilogy(it,data.s,'m-+','LineWidth',2,'MarkerSize',8);
%             hold on
%             semilogy(it,data.s_imp,'b-s','LineWidth',2,'MarkerSize',8);
%             semilogy(it,data.Rr,'r-x','LineWidth',2,'MarkerSize',8);
% %             semilogy(it,onepix,'k-','LineWidth',2,'MarkerSize',8);
%             
%             legend('Theorem 2','Theorem 5','True error')
%             hold off;
%             set(gca,'fontsize',15)
%             xlabel('Number of angles','fontsize',20)
%             ylabel('Fraction of pixels','fontsize',20)
%             %
%             img = num2str(img_index);
%             sz = num2str(img_sz);
%             filename = strcat('2UE-',type,'-Im',img,'-sz',sz,'.fig');
%             saveas(figura,filename);
%             clear figura
%--------------------------------------------------------------------------
%             V_best = min(data.V4,min(data.V3,min(data.V2,min(data.V,data.V1))));
            V_best = min(data.V3,min(data.V2,min(data.V,data.V1)));
            s_best = min(data.s,data.s_imp);
            
            it = data.proj;
            figura =semilogy(it,V_best,'m-+','LineWidth',2,'MarkerSize',8);
            hold on
            semilogy(it,s_best,'b-s','LineWidth',2,'MarkerSize',8);
            semilogy(it,data.Rr,'r-x','LineWidth',2,'MarkerSize',8);
%             semilogy(it,onepix,'k-','LineWidth',2,'MarkerSize',8);
            
            legend('U_d','U_s','E_s')
            hold off;
            set(gca,'fontsize',15)
            xlabel('Number of angles','fontsize',20)
            ylabel('Fraction of pixels','fontsize',20)
            %
            img = num2str(img_index);
            sz = num2str(img_sz);
            filename = strcat('VUEbest-',type,'-Im',img,'-sz',sz,'.fig');
            saveas(figura,filename);
            clear figura
            
            data=[];
        end
    end
end