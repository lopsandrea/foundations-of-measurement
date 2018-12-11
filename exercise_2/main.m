function main
mediana('Dati_1.txt');



    

    function v = parseFile(filename)
        v = importdata(filename,' ');
    end

    function v = istogramma(filename)
        % calcola il passo qui
        v = histogram(parseFile(filename));
    end

    function mediana(filename)
         v = num2str(median(parseFile(filename)));
         disp(['La mediana è ', v]);
    end
end