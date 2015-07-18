% explanation
clear all;
img_sz_set = [16,32];%,64,128,256,512];
img_index_set = [1,2,3,5];
type_set = 0;%[0,1];
data = initialize;

for typecod = type_set
    if typecod==0
        type = 'grid';
    else
        type = 'strip';
    end
    for img_sz = img_sz_set
        if img_sz==16
            N_proj_set = [2,4,6,8];%[1,2,4,6,8];
        elseif img_sz==32
            N_proj_set = [2,4,6,8];%[1,2,4,6,8];%,10,12,14,16];
        elseif img_sz==64
            N_proj_set = [2,4,8,12,16];%,20,24,28,32];
        elseif img_sz==128
            N_proj_set = [4,8,16,20,24,28,32];%,40,48,56,64];
        elseif img_sz==256
            N_proj_set = [8,16,32,40,48,56,64];%,72,80,88,96,104];
        elseif img_sz==512
            N_proj_set = [8,16,32,48,64,72,80,88,96,104,112,120];%,136,152,168,184,200];
        end
        
        for img_index = img_index_set;
            aux = 1;
            for N_proj = N_proj_set;
                [data] = core_quadratic(type,img_index,N_proj,img_sz,aux,data);
                aux = aux+1;
            end
            % graphs
            it = N_proj_set;
%             figura = semilogy(it,data.s_imp,'m-+','LineWidth',1.2,'MarkerSize',7);
            figura = semilogy(it,data.sq6,'m-+','LineWidth',1.2,'MarkerSize',7);
            hold on
            semilogy(it,data.sq10,'k-o','LineWidth',1.2,'MarkerSize',7);
            semilogy(it,data.sq,'g-s','LineWidth',1.2,'MarkerSize',7);
            semilogy(it,data.Rr,'r-x','LineWidth',1.2,'MarkerSize',7);
            
            legend('lim-ones','quad','quadv2','true error')
            hold off;
            xlabel('Number of angles','fontsize',14)
            ylabel('Fraction of pixels','fontsize',14)
            %
            img = num2str(img_index);
            sz = num2str(img_sz);
            
            chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/conference/';
            filename = strcat(chemin,'d(r,x)',type,'-Im',img,'-sz',sz,'.fig');
            saveas(figura,filename);
            clear figura
            %--------------------------------------------------------------
%             figura = semilogy(it,data.V,'m-+','LineWidth',1.2,'MarkerSize',7);
%             hold on
%             semilogy(it,data.Vq1,'k-o','LineWidth',1.2,'MarkerSize',7);
%             semilogy(it,data.Vq2,'r-x','LineWidth',1.2,'MarkerSize',7);
%             
%             legend('d(x,y)-old','d(x,y)-quadv1','d(x,y)-quadv2')
%             hold off;
%             xlabel('Number of angles','fontsize',14)
%             ylabel('Fraction of pixels','fontsize',14)
%             %
%             img = num2str(img_index);
%             sz = num2str(img_sz);
%             
%             chemin='/ufs/fortes/Desktop/PhD_m_files/tomography/conference/';
%             filename = strcat(chemin,'d(x,y)',type,'-Im',img,'-sz',sz,'.fig');
%             saveas(figura,filename);
%             clear figura
            
            data = initialize;
        end
    end
end
