% Contain 2 codes
% 1st: Graphs "Error" X Image width
%   % Grid or Strip
%   % Fixed ratio. 4, 8, 16 and 32 available
%   % Fixed phantom. Several available
% 
% 2nd: Graphs "Error" X # projection angle

clear all
img_index_set = [1,2,3,5];
ratio_set = [4,8,16,32];
img_sz_set = [32,64,128,256,512];
type_set=[0,1];
data=[];
for typecod = type_set
    if typecod==0
        type = 'Grid';
        typeshort = 'G';
    else
        type = 'Strip';
        typeshort = 'S';
    end
    for img_index = img_index_set
        for ratio = ratio_set
            aux = 1;
            ratio
            for img_sz = img_sz_set
                img_sz
                [data] = core(type,img_index,ratio,img_sz,aux,data);
                aux=aux+1;
            end
            % ---------- Graphics -------------
            it = img_sz_set;
            figura = semilogy(it,data.s(:,1),'r-x','LineWidth',1.2,'MarkerSize',7);
            hold on
            semilogy(it,data.Rr(:,1),'b-s','LineWidth',1.2,'MarkerSize',7);

            legend('U','E')
            hold off;
            xlabel('Image width','fontsize',14)
            ylabel('Fraction of pixels','fontsize',14)
            %
            img = num2str(img_index);
            rat = num2str(ratio);
            filename = strcat('U+E-',typeshort,'-Im',img,'-r',rat,'.fig');
            saveas(figura,filename);
            clear figura;

            % ---------- Graphics -------------
            figura =semilogy(it,data.V(:,1),'r-x','LineWidth',1.2,'MarkerSize',7);
            hold on
            semilogy(it,data.V1(:,1),'b-s','LineWidth',1.2,'MarkerSize',7);
            semilogy(it,data.V2(:,1),'m-+','LineWidth',1.2,'MarkerSize',7);

            legend('V','V1','V2')
            hold off;
            xlabel('Image width','fontsize',14)
            ylabel('Fraction of pixels','fontsize',14)
            %
            img = num2str(img_index);
            rat = num2str(ratio);
            filename = strcat('3V-',typeshort,'-Im',img,'-r',rat,'.fig');
            saveas(figura,filename);
            clear figura;
            data=[];
        end
    end
end