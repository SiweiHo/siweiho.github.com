% This program is used to convert daily data to monthly.
% inputs are: daily data, start_year, start_mon, end_year, end_mon, algorithm kind.
% Syntax:
%     monthly_data = d2m(dailydata,start_year,start_mon,end_year,end_mon,kind)
%
% where:
%     dailydata = N x 1, N must greater than 56
%     start_year = like 1999
%     start_mon = any month between Jan and Dec, like 3
%     kind = 'sum' or 'mean'
%
% Written by Siwei He, 08/28/2013, 
% If there exist any problem, please let me know, hesiweide@163.com

function monthly_out=d2m(dailydata,start_year,start_mon,end_year,end_mon,kind)
    [len,m]=size(dailydata);
    if (m==1) && len>56
        num=1;
        mon_index=0;
        if start_year==end_year
            monthly_out=zeros((end_mon-start_mon+1),1);
            for i=start_mon:end_mon
                mon_index=mon_index+1;
                day=eomday(start_year,i);
                if strcmp(kind,'sum')
                    monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                elseif strcmp(kind,'mean')
                    monthly_out(mon_index)=mean(dailydata((num:num+day-1)));                
                else
                    error('WRONG INPUT PARAMETER OF kind')
                end
                num=num+day;
            end
        end
            
        if start_year==(end_year-1)
            monthly_out=zeros(((13-start_mon)+end_mon),1);            
            for year=start_year:(end_year-1)
                for i=start_mon:12
                    day=eomday(year,i);
                    mon_index=mon_index+1;
                    if strcmp(kind,'sum')
                        monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                    elseif strcmp(kind,'mean')
                        monthly_out(mon_index)=mean(dailydata((num:num+day-1))); 
                    else
                        error('WRONG INPUT PARAMETER OF kind')
                    end
                    num=num+day;
                end
            end
            for i=1:end_mon
                day=eomday(end_year,i);
                mon_index=mon_index+1;
                if strcmp(kind,'sum')
                    monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                elseif strcmp(kind,'mean')
                    monthly_out(mon_index)=mean(dailydata((num:num+day-1))); 
                else
                    error('WRONG INPUT PARAMETER OF kind')
                end
                num=num+day;
            end
        end
        
        if start_year<(end_year-1)
            monthly_out=zeros(((13-start_mon)+end_mon+(start_year-end_year)*12),1);            
            for i=start_mon:12
                day=eomday(start_year,i);
                mon_index=mon_index+1;
                if strcmp(kind,'sum')
                    monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                elseif strcmp(kind,'mean')
                    monthly_out(mon_index)=mean(dailydata((num:num+day-1))); 
                else
                    error('WRONG INPUT PARAMETER OF kind')
                end
                num=num+day;
            end
                
            for year=(start_year+1):(end_year-1)
                for i=1:12
                    day=eomday(year,i);
                    mon_index=mon_index+1;
                    if strcmp(kind,'sum')
                        monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                    elseif strcmp(kind,'mean')
                        monthly_out(mon_index)=mean(dailydata((num:num+day-1))); 
                    else
                        error('WRONG INPUT PARAMETER OF kind')
                    end
                    num=num+day;
                end
            end
            for i=1:end_mon
                day=eomday(end_year,i);
                mon_index=mon_index+1;
                if strcmp(kind,'sum')
                    monthly_out(mon_index)=sum(dailydata(num:num+day-1));
                elseif strcmp(kind,'mean')
                    monthly_out(mon_index)=mean(dailydata((num:num+day-1))); 
                else
                    error('WRONG INPUT PARAMETER OF kind')
                end
                num=num+day;
            end
        end
            
    else
        error('WRONG HOURLY DATA FORMAT')
    end
    monthly_out=monthly_out';
end