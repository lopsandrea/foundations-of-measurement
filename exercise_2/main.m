function main
clear
clearvars
clc

disp('******************')
disp('****  Welcome ****')
disp('******************')
disp(' ')
disp(' ')
disp(' ')

choice = 0;
disp('What kind of data do you want to analyze?')

while(choice~=7) % set data type
    choice = 0;
    while(choice<1||choice>6)
        disp('1 - Resistance of superalloys')
        disp('2 - Systolic blood pressure (even number of samples)')
        disp('3 - Systolic blood pressure (odd number of samples)')
        disp('4 - Splitting Tensile Strength of Concrete Cylinders')
        disp('5 - Random noise with Gaussian distribution (5000 samples)')
        disp('6 - Random noise with Uniform distribution (5000 samples)')
        choice = input('Insert choice: ');
    end
    
    if(choice==1)
        file1 = 'Dati_1.txt';
        eseguiEsercizio(file1);
        break
    elseif(choice==2)
        file1 = 'Dati_2.txt';
        eseguiEsercizio(file1);
        break
    elseif(choice==3)
        file1 = 'Dati_3.txt';
        eseguiEsercizio(file1);
        break
    elseif(choice==4)
        file1 = 'Dati_4.txt';
        eseguiEsercizio(file1);
        break
     elseif(choice==5)
        distribuzioneGaussiana()
        break
    elseif(choice==6)
        distribuzioneUniforme()
        break
    end
end

disp(' ')
disp(' ')


    function eseguiEsercizio(filename)
        v = parseFile(filename);
        % mostra istogramma
        istogramma(v);
        
        % calcola mediana e disperzione
        disp(strcat(['The median is ' num2str(mediana(v))]));
        disp(strcat(['The dispersion is ' num2str(dispersione(v))]));
        
        % calcola quartili
        disp(strcat(['The first quartile is ' num2str(firstQuartile(v))]));
        disp(strcat(['The second quartile is' num2str(secondQuartile(v))]));
        disp(strcat(['The third quartile is' num2str(thirdQuartile(v))]));
       
        % calcola interquartile
        disp(strcat(['The interquartile is ' num2str(interquartile(v))]));
        
        % calcola outliers
        OUTLIERS = outliers(v);
        if (isempty(OUTLIERS))
            disp('Non ci sono outliers');
        else
            disp('Gli outliers sono:');
            disp(OUTLIERS);
        end
        
        % mostra boxplot
        % apre nuova finestra per il grafico con figure;
        figure;
        dispBoxplot(v);
        hold off;
        
        
    end

% OUTLIERS = outliers(file1);
% 
% if (isempty(OUTLIERS))
%     disp('Non ci sono outliers');            
% else
%     disp(OUTLIERS);
% end

%  CHISQUARETEST = chiSquareTest(file1);
%  if (CHIQUARETEST < 0.5)
%      disp('La curva potrebbe essere una gaussiana');
%  else
%      disp('La curva non è una gaussiana');
%  end



% genrate uniform distribution
%distribuzioneUniforme();

% genera distribuzione gaussiana
%distribuzioneGaussiana();

    function v = parseFile(filename)
        file1 = importdata(filename,' ');
        v = sort(file1);
    end

    function output = istogramma(v)
        % calcola il passo qui
        output = histogram(v);
    end

    function output = mediana(v)
         output = median(v);
    end

    function output = dispersione(v)
        output = range(v);
    end

    function output = firstQuartile(v)
        output = median(v(v<median(v)));
    end
    
    function output = secondQuartile(v)
        output = median(v);
    end

    function output = thirdQuartile(v)
        output = median(v(find(v>median(v))));
    end

    function output = interquartile(v)
       output = (thirdQuartile(v) - firstQuartile(v));
    end

    function totOutliers = outliers(v)
        IQR = interquartile(v);
        Q(1) = firstQuartile(v);
        
        iy = find(v<Q(1)-3*IQR);
        if (isempty(iy))
            outliersQ1 = v(iy);
        else
            outliersQ1 = [];
        end
        
        % determine extreme Q3 outliers (e.g., x > Q1 + 3*IQR)
        iy = find(v>Q(1)+3*IQR);
        if (isempty(iy))
            outliersQ3 = v(iy);
        else
            outliersQ3 = [];
        end
        
        totOutliers = [outliersQ1 outliersQ3];
    end

    function dispBoxplot(v)
        figure;
        boxplot(v);
    end

    function dispQQPlot(v)
       figure;
       qqplot(v); 
    end

    function output = chiSquareTest(v)
        % 0 può essere gaussiana, 1 non lo è
        output = chi2gof(v);
    end

    function output = varianza(v)
       output = var(v); 
    end

    function output = media(v)
       output = mean(v); 
    end

    function output = distribuzioneUniforme()
        output = rand(1, 5000);
    end

    function output = distribuzioneGaussiana()
       output = randn(1, 5000); 
    end

end