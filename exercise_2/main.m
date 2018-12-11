function main
clc;
clear;

file1 = 'Dati_1.txt';

OUTLIERS = outliers(file1);

if (isempty(OUTLIERS))
    disp('Non ci sono outliers');            
else
    disp(OUTLIERS);
end

dispBoxplot(file1);


    function v = parseFile(filename)
        data = importdata(filename,' ');
        v = sort(data);
    end

    function v = istogramma(filename)
        % calcola il passo qui
        v = histogram(parseFile(filename));
    end

    function mediana(filename)
         v = num2str(median(parseFile(filename)));
    end

    function output = dispersione(filename)
        output = range(parseFile(filename));
    end

    function output = firstQuartile(filename)
        y = parseFile(filename);
        output = median(y(y<median(y)));
    end
    
    function secondQuartile(filename)
        output = median(parseFile(filename));
    end

    function output = thirdQuartile(filename)
        y = parseFile(filename);
        output = median(y(find(y>median(y))));
    end

    function output = interquartile(filename)
       output = (thirdQuartile(filename) - firstQuartile(filename));
    end

    function totOutliers = outliers(filename)
        v = parseFile(filename);
        IQR = interquartile(filename);
        Q(1) = firstQuartile(filename);
        
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

    function dispBoxplot(filename)
        boxplot(parseFile(filename));
        figure;
    end
end