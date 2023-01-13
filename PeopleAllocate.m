function PeopleAllocate(People_allocate)
Vsum=size(People_allocate,2);

fid=fopen('People_allocate.txt','w');
for i=1:Vsum
    fprintf(fid,'************Project %d (Human Resource Assignment)*************\n',i);
    if ~isempty(People_allocate(i).R1)
        fprintf(fid,'\tWorker R1:%d\t',People_allocate(i).R1');
    end
    if ~isempty(People_allocate(i).R2)
        fprintf(fid,'\n');
        fprintf(fid,'\tWorker R2:%d\t',People_allocate(i).R2');
    else
        fprintf(fid,'\n');
    end
    if ~isempty(People_allocate(i).R3)
        fprintf(fid,'\n');
        fprintf(fid,'\tWorker R3:%d\t',People_allocate(i).R3');
    else
        fprintf(fid,'\n');
    end
    fprintf(fid,'\n');
end
fclose(fid);
end

