function gante(a,VArray)
%% Draw the Gantt chart
K=size(VArray,2);    
Vsum=max(a(:,2));    
figure;
w=0.5;              
set(gcf,'color','w');
for ii=1:Vsum
    x=a(ii,[3 3 4 4]);
    y=a(ii,1)+[-w/2 w/2 w/2 -w/2];
    if K == 2
        if ii<=VArray(1)
            patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
        else
            patch('xdata',x,'ydata',y,'facecolor','blue','edgecolor','blue','LineWidth',2,'FaceAlpha',.2);
        end
    else
        p=patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    end
    txt=sprintf('J_{%d}=%.1f',a(ii,2),a(ii,4)-a(ii,3));
    text(a(ii,3)+0.5,a(ii,1),txt,'fontsize',7);
end

tmax=max(a(:,4));

if Vsum > VArray(1)
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=1+[-w/2 w/2 w/2 -w/2];
    patch('xdata',x,'ydata',y,'facecolor','blue','edgecolor','blue','LineWidth',2,'FaceAlpha',.2);
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=2+[-w/2 w/2 w/2 -w/2];
    patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    text(tmax-2.5,1,'Project 2','fontsize',10);
    text(tmax-2.5,2,'Project 1','fontsize',10);
else
    x=[tmax-7 tmax-7 tmax-3 tmax-3];
    y=1+[-w/2 w/2 w/2 -w/2];
    p=patch('xdata',x,'ydata',y,'facecolor','red','edgecolor','red','LineWidth',2,'FaceAlpha',.2);
    text(tmax-2.5,1,'Project 1','fontsize',10);
end

title('Scheduling Gantt Chart');     
xlabel('time/week');
ylabel('Project Number');
xmax=max(a(:,2));
ymax=max(a(:,3));
axis([0 ymax+10 0 xmax+1]);
set(gca,'Box','on');
set(gca,'YTick',0:Vsum);
set(gca,'YTickLabel',[{''};num2str((1:Vsum)','J_{%d}');{''}]);
