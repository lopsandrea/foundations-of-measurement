function main

bar(parseFile('Dati_1.txt'));

    function v = parseFile(filename)
        v = importdata(filename,'%s');
    end
end