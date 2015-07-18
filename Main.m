% Graphs Error X # projection angle
% Grid or Strip
% Fixed image width. Several available
% Fixed phantom. Several available
%
clear all
load invader.mat
img_sz_set = 13;%[32,128,512];
img_index_set = 1;%[1,2,3,5];
type_set = 0;%[0,1];
data = initialize;
data.invader = invader;


for img_sz = img_sz_set
    if img_sz==13
        N_proj_set = [2,4,6,8];
    elseif img_sz==32
        N_proj_set = [1,2,4,6,8,10,12,14,16];
    elseif img_sz==64
        N_proj_set = [2,4,8,12,16,20,24,28,32];
    elseif img_sz==128
        N_proj_set = [4,8,16,20,24,28,32,40,48,56,64];
    elseif img_sz==256
        N_proj_set = [8,16,32,40,48,56,64,72,80,88,96,104];
    elseif img_sz==512
        N_proj_set = [8,16,32,48,64,72,80,88,96,104,112,120,136,152,168,184,200];
    end
    for typecod = type_set
        if typecod==0
            type = 'grid';
        elseif typecod==1
            type = 'strip';
        end
        for img_index = img_index_set;
            aux = 1;
            
            for N_proj = N_proj_set;
                
                [data] = core(type,img_index,N_proj,img_sz,aux,data);
                aux = aux+1;
            end
            % ---------- Graphics -------------
            it = N_proj_set;
            
%             figura =semilogy(it,data.V(:,1),'g-','LineWidth',2,'MarkerSize',8);
%             hold on
%             semilogy(it,data.V1(:,1),'b-s','LineWidth',2,'MarkerSize',8);
%             semilogy(it,data.V2(:,1),'m-+','LineWidth',2,'MarkerSize',8);
%             semilogy(it,data.V3(:,1),'k-o','LineWidth',2,'MarkerSize',8);
%             semilogy(it,data.V5(:,1),'r-x','LineWidth',2,'MarkerSize',8);
%             
%             legend('U_d(1)','U_d(2)','U_d(3)','U_d(4)','U_d(5)')
%             hold off;
%             set(gca,'fontsize',15)
%             xlabel('Number of angles','fontsize',20)
%             ylabel('Fraction of pixels','fontsize',20)
            %
%             img = num2str(img_index);
%             sz = num2str(img_sz);
%             filename = strcat('5V-',type,'-Im',img,'-sz',sz,'.fig');
%             saveas(figura,filename);
%             clear figura
            %
            % ---------- Graphics -------------
            %
            V_best = min(data.V3,min(data.V2,min(data.V,data.V1)));
            s_best = min(data.s,data.s_imp);
%             
%             figure;
%             fiigura =semilogy(it,V_best,'m-+','LineWidth',2,'MarkerSize',8);
%             hold on
%             semilogy(it,s_best,'b-s','LineWidth',2,'MarkerSize',8);
%             semilogy(it,data.Rr,'r-x','LineWidth',2,'MarkerSize',8);
%             %
%             
%             legend('U_d','U_s','E_s')
%             hold off;
%             set(gca,'fontsize',15)
%             xlabel('Number of angles','fontsize',20)
%             ylabel('Fraction of pixels','fontsize',20)
%             %
%             img = num2str(img_index);
%             sz = num2str(img_sz);
%             filename = strcat('VUEbest-',type,'-Im',img,'-sz',sz,'.fig');
%             saveas(figura,filename);
%             clear figura
%             nome = strcat('data-',type,'-Im',img,'-sz',sz,'.mat');
%             save(nome,'data');
            
            data=initialize;
        end
    end
end