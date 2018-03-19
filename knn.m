%tubes AI KNN
clear all;
clc;

k = 83; %579
train = importdata('Train.mat');
test = importdata('Test.mat');

%PERHITUNGAN AKURASI DATA TRAIN
%hitung akurasi data train
trainT = train(:,1:11);
[a b] = size(trainT);
akurasi = 0;
bener = 0;
for i = 1:a
    clc;
    disp('perhitungan akurasi data train');
    disp(['data ke-' num2str(i) ' dari 90000']);
    disp(['akurasi sementara ' num2str(akurasi*100) '%'])
    i
    
    dte = trainT(i,:);
    arrayD = repmat(-1,k+1,2);
    [c dd] = size(train);
    for j = 1:c
        if j~=i
            tmpT = [];
            dta = train(j,:);

            %cari euclidan distance
            d = sqrt((dte(2)-dta(2))^2+(dte(3)-dta(3))^2+(dte(4)-dta(4))^2+(dte(5)-dta(5))^2+(dte(6)-dta(6))^2+(dte(7)-dta(7))^2+(dte(8)-dta(8))^2+(dte(9)-dta(9))^2+(dte(10)-dta(10))^2+(dte(11)-dta(11))^2);
            bin = dta(12);

            %masukkan ke array penampungan
            tmpT(1,1) = d;
            tmpT(1,2) = bin;
            
            %proses pencocokan
            tdkBerhenti = true;
            p = k;
            
            while tdkBerhenti && (p~=0)
                %masukin ke data 6 lalu di sort
                arrayD(p+1,:) = tmpT;
                if arrayD(p,1) > arrayD(p+1,1) || arrayD(p,1) == -1
                    %mangga di sort
                    arrayTmp = arrayD(p+1,:);
                    arrayD(p+1,:) = arrayD(p,:);
                    arrayD(p,:) = arrayTmp;
                    p = p-1;
                else
                    tdkBerhenti = false;
                end
            end            
        end
        
    end
    
    tempT = arrayD;

    for j = 1:k
        satu = 0;
        nol = 0;
        kla = tempT(j,2);

        if kla == 1
            satu = satu+1;
        else
            nol = nol+1;
        end

        if satu>nol
            data = 1;
        else
            data = 0;
        end
    end

    if data == train(i,12)
        bener = bener+1
    end
    akurasi = bener/i;
    %test_jawabanT(i,:) = [dte data];
end

%PERHITUNGAN DATA TEST
%looping data test
[a b] = size(test);
for i = 1:a
    clc;
%     disp(['akurasi data train ' num2str(akurasi*100) '%']);
    disp('ektrak jawaban ke data test');
    disp(['data ke-' num2str(i) ' dari 10000']);
    i
    
    dte = test(i,:);
    arrayD = repmat(-1,k+1,2);
    [c d] = size(train);
    for j = 1:c
        dta = train(j,:);
        tmp = [];
        
%         cari euclidan distance
        d = sqrt((dte(2)-dta(2))^2+(dte(3)-dta(3))^2+(dte(4)-dta(4))^2+(dte(5)-dta(5))^2+(dte(6)-dta(6))^2+(dte(7)-dta(7))^2+(dte(8)-dta(8))^2+(dte(9)-dta(9))^2+(dte(10)-dta(10))^2+(dte(11)-dta(11))^2);
        bin = dta(12);
        
%         masukkan ke array penampungan
        tmp(1,1) = d;
        tmp(1,2) = bin;
        
        %proses pencocokan
         tdkBerhenti = true;
         p = k;
            
         while tdkBerhenti && (p~=0)
             %masukin ke data 6 lalu di sort
             arrayD(p+1,:) = tmp;
             if arrayD(p,1) > arrayD(p+1,1) || arrayD(p,1) == -1
                 %mangga di sort
                 arrayTmp = arrayD(p+1,:);
                 arrayD(p+1,:) = arrayD(p,:);
                 arrayD(p,:) = arrayTmp;
                 p = p-1;
             else
                 tdkBerhenti = false;
             end
         end
    end
    
%     klasifikasi data test
    temp = arrayD;
    
    for j = 1:k
        satu = 0;
        nol = 0;
        kla = temp(j,2);
        
        if kla == 1
            satu = satu+1;
        else
            nol = nol+1;
        end
        
        if satu>nol
            data = 1;
        else
            data = 0;
        end
    end
    
%     masukin ke array jawaban
    test_jawaban(i,:) = [dte data];
end

save('data_tubes.mat','akurasi','test_jawaban');
disp('selesai');
