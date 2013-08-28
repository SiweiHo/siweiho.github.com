% This program is used to convert sub-daily data to daily.
% inputs are: sub-daily data, sub-daily step, algorithm kind.
% Syntax:
%     daily_data = h2d(hourlydata, step, kind)
%
% where:
%     hourlydata = N x 1
%     step = an interger between 1 and 23 (hour)%
%     kind = 'sum' or 'mean'
%
% Written by Siwei He, 08/28/2013, 
% If there exist any problem, please let me know, hesiweide@163.com

function daily_out=h2d(hourlydata, step, kind)
    [len,m]=size(hourlydata);
    if (m==1) && (mod(len,step)==0)
        daily_out=zeros(len/step,1);
        for i=1:len/step
            if strcmp(kind,'sum')
                daily_out(i)=sum(hourlydata(1+(i-1)*step:i*step));
            elseif strcmp(kind,'mean')
                daily_out(i)=mean(hourlydata(1+(i-1)*step:i*step));
            else
                error('WRONG INPUT PARAMETER OF kind')
            end
        end
    else
        error('WRONG HOURLY DATA FORMAT')
    end
end