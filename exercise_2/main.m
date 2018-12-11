function main

file1 = 'Dati_1.txt';

interquartile(file1);

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
         disp(['La mediana è ', v]);
    end

    function output = dispersione(filename)
        output = range(parseFile(filename));
        disp(['La dispersione è ' num2str(range(parseFile(filename)))]);
    end

    function output = firstQuartile(filename)
        y = parseFile(filename);
        output = median(y(y<median(y)));
        disp(['Il primo quartile è ' num2str(output)]);
    end
    
    function secondQuartile(filename)
        output = median(parseFile(filename));
        disp(['Il secondo quartile è ' num2str(output)]);
    end

    function output = thirdQuartile(filename)
        y = parseFile(filename);
        output = median(y(find(y>median(y))));
    end

    function interquartile(filename)
       interquartile = thirdQuartile(filename) - firstQuartile(filename);
       disp(['Lo scarto è ' num2str(interquartile)]);
    end
end