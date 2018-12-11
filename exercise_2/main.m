function main
clc;
clear;

file1 = 'Dati_1.txt';

eseguiEsercizio(file1);

    function eseguiEsercizio(filename)
        v = parseFile(filename);
        
        % mostra istogramma
        istogramma(v);
        
        % calcola mediana e disperzione
        disp(strcat(['La mediana è ' num2str(mediana(v))]));
        
        % installa toolbox per questo
        % disp(strcat(['La dispersione è ' num2str(dispersione(v))]));
        
        % calcola quartili
        disp(strcat(['Il primo quartile è ' num2str(firstQuartile(v))]));
        disp(strcat(['Il secondo quartile è ' num2str(secondQuartile(v))]));
        disp(strcat(['Il terzo quartile è ' num2str(thirdQuartile(v))]));
       
        % calcola interquartile e outliers

        
    end

OUTLIERS = outliers(file1);

if (isempty(OUTLIERS))
    disp('Non ci sono outliers');            
else
    disp(OUTLIERS);
end

%  CHISQUARETEST = chiSquareTest(file1);
%  if (CHIQUARETEST < 0.5)
%      disp('La curva potrebbe essere una gaussiana');
%  else
%      disp('La curva non è una gaussiana');
%  end


% variance
disp(['La varianza è: ' num2str(varianza(file1))]);

% genrate uniform distribution
%distribuzioneUniforme();

% genera distribuzione gaussiana
%distribuzioneGaussiana();

    function v = parseFile(filename)
        data = importdata(filename,' ');
        v = sort(data);
    end

    function v = istogramma(v)
        % calcola il passo qui
        v = histogram(v);
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
        boxplot(filename);
    end

    function dispQQPlot(v)
        figure;
       qqplot(filename); 
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
       output = randn(1, 5000) 
    end

end