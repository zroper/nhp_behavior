%clear all

listing = dir;
list = {listing(4:5).name};
row = 1;

%load Cajal_170510_122303.mat
total_ec_size = Cajal_data.evnt.scalars.EVNT.data;
g=unique(Cajal_data.evnt.scalars.EVNT.data);
g_size=size(g);


for tt = 1:g_size(2)
    m = find(Cajal_data.evnt.scalars.EVNT.data==g(tt));
    m_size = size(m);
    h(tt) = m_size(2);
    if g(tt) == 2301 || g(tt) == 2810 || g(tt) == 2600 || g(tt) == 887 || g(tt) == 888 || g(tt) == 2756 || g(tt) == 2620 || g(tt) == 2651
        columns= [row, g(tt),h(tt)];
        data_pruned(row,:) = columns;
        row = row +1;
    end
end

t = [g',h'];

behavior.trialCodes = zeros(1,length(Cajal_data.evnt.scalars.EVNT.data));
behavior.rt = zeros(1,length(Cajal_data.evnt.scalars.EVNT.data));
behavior.rt_beg = zeros(1,length(Cajal_data.evnt.scalars.EVNT.data));

for ec = 1:1:length(Cajal_data.evnt.scalars.EVNT.data)-65
    if Cajal_data.evnt.scalars.EVNT.data(ec) == 2651 % Target Onset
        behavior.rt_beg(ec) = Cajal_data.evnt.scalars.EVNT.ts(ec);
        search_start = Cajal_data.evnt.scalars.EVNT.ts(ec+1);
        search_end = search_start+500;
        searching = 1;
        counter = 1;
        while searching ==1
            current_time = Cajal_data.evnt.scalars.EVNT.ts(ec+counter);
            if current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter) == 2600 %Correct Trial
                counter2 = counter;
                while searching ==1
                    if current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5045 %Right Target
                        behavior.trialCodes(ec) = 4;
                        behavior.rt(ec) = (current_time - behavior.rt_beg(ec));
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5090 %Right Target
                        behavior.trialCodes(ec) = 5;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5135 %Right Target
                        behavior.trialCodes(ec) = 6;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5225 %Left Target
                        behavior.trialCodes(ec) = 1;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5270 %Left Target
                        behavior.trialCodes(ec) = 2;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5315 %Left Target
                        behavior.trialCodes(ec) = 3;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5000 %Up Target
                        behavior.trialCodes(ec) = 7;
                        searching =0;
                    elseif current_time < search_end && Cajal_data.evnt.scalars.EVNT.data(ec+counter2) == 5180 %Down Target
                        behavior.trialCodes(ec) = 8;
                        searching =0;                        
                        
                    elseif current_time > search_end
                        searching = 0;
                    end;
                    counter2 = counter2 + 1;
                end
            elseif current_time > search_end
                searching = 0;
            end
            counter = counter + 1;
        end
    end
end