db = readtable('treeDatabase.csv')

db.Date = datetime(db.Date, 'ConvertFrom', double) 
% Connot convert from double to datetime.

db.Date = datetime(string(db.Date), 'InputFormat', 'yyyy') 
% By converting the date column to a string I was able to convert it to a DateTime

unique(db.Collector) % Checks for unique Collector
% Returns list of 53 unique contributor with some spelling errors which
% generate duplicates

db(db.Collector == 'Comercial', 'Collector') % Cannot use == with cell

% convert 'Collectors' to string
db.Collector = string(db.Collector)

% Try to correct spelling mistake
db(db.Collector == 'Comercial', 'Collector') = "Commercial" % must be table or array

db(db.Collector == 'Prof. e. Fritz', 'Collector') = {'Prof. E. Fritz'} % requires that you define the variable as a cell
db(db.Collector == 'E. Fritz', 'Collector') = {'Prof. E. Fritz'}
db(db.Collector == 'E.J.Z', 'Collector') = {'E.J. Zavitz'}
db(db.Collector == 'E.J.Z.', 'Collector') = {'E.J. Zavitz'}
db(db.Collector == 'J.H.W.', 'Collector') = {'J.H. White'}
db(db.Collector == 'J.H.White', 'Collector') = {'J.H. White'}
db(db.Collector == 'Professor. Fritz', 'Collector') = {'Prof. E. Fritz'}
db(db.Collector == 'Comercial', 'Collector') = {'Commercial'}
% Correct all spelling mistakes for Collector identified by unique

% Double Check that there are no duplicates.
unique(db.Collector)


% I noticed that there was some white spaces before and after some of the
% entries in the Contributors column, so I was able to clean that up using
% the strtirm() function
db.Contributor = strtrim(db.Contributor)

unique(db.Contributor) % checks to see if there are any duplicate issues with the names
% This returns a list of 37 unique Contributors, with some spelling errors which generate duplicates. 
% with some of whom are the names of collectors, these names will need to
% be moved to the collectors column.

db.Contributor = string(db.Contributor)
%Convert db.Contributor to string

db(db.Contributor == 'Botanical station', 'Contributor') = {'Botanical Station'};
db(db.Contributor == 'Department of lands and mines', 'Contributor') = {'Department of Lands and Mines'};
db(db.Contributor == 'Forest Service', 'Contributor') = {'Forest Services'};
% Correct all the duplicate entries

%Double Check to makes sure the correction worked
unique(db.Contributor)

% check to see if there are any doubles where the contributor and collector
% are the same. This is to try and see if there are names of the collectors
% in the contributor column.
db(db.Contributor == db.Collector & db.Contributor ~= '', :)

db(db.Contributor == 'E.J.Z.' & db.Collector == '', 'Collector') = {'E.J. Zavitz'}
db(db.Contributor == 'J.H. White' & db.Collector == '', 'Collector') = {'J.H. White'}
db(db.Contributor == 'J.R. Cosgrove' & db.Collector == '', 'Collector') = {'J.R. Cosgrove'}
db(db.Contributor == 'R.G. Chesbro' & db.Collector == '', 'Collector') = {'R.G. Chesbro'}

db(db.Contributor == 'E.J.Z.', 'Contributor') = {''}
db(db.Contributor == 'J.H. White', 'Contributor') = {''}
db(db.Contributor == 'J.R. Cosgrove', 'Contributor') = {''}
db(db.Contributor == 'R.G. Chesbro', 'Contributor') = {''}

% Double Check to make sure that the contributors are all unique now
unique(db.Contributor)

%Capitalize all the first letters of the Genus
unique(db.Genus)
db.Genus = char(db.Genus)
db.Genus(:,1:1) = upper(db.Genus(:,1:1))
db.Genus = string(db.Genus)
db.Genus = strtrim(db.Genus) 
unique(db.Genus)

% Call function to capitalize the first letters of all species caps.m
db.Species = caps(db.Species)

% Double check that all Species are unique and capitalized
unique(db.Species) 

% Capitalize first letter of all Families

db.Family = caps(db.Family)
unique(db.Family) % Double check that all names were capitalized and are unique.

% Capitalize first letter all ComName
db.ComName = caps(db.ComName)
unique(db.ComName) % Double check that all names were capitalized and are unique.

% Capitalize all Location
db.Location = caps(db.Location)
unique(db.Location)

% Apply a number of corrections to the db.Location column 
db(db.Location == 'Austrailia', 'Location') = {'Australia'}
db(db.Location == 'Britiah Guiana', 'Location') = {'British Guiana'}
db(db.Location == 'Burma', 'Location') = {'Burma, India'}
db(db.Location == 'Caeylon', 'Location') = {'Ceylon, Sk, Canada'}
db(db.Location == 'Ceylon', 'Location') = {'Ceylon, Sk, Canada'}
db(db.Location == 'Fiji Ids.', 'Location') = {'Fiji'}
db(db.Location == 'From Cotswold Hills, Gloucestershire', 'Location') = {'Cotswold Hills, Gloucestershire'}
db(db.Location == 'From Forest of Dean, Gloucestershire', 'Location') = {'Forest of Dean, Gloucestershire'}
db(db.Location == 'From Gloucestershire', 'Location') = {'Gloucestershire'}
db(db.Location == 'From tree grown in Gloucester city', 'Location') = {'Gloucester City'}
db(db.Location == 'Interior mill, B.C.', 'Location') = {'Interior, B.C.'}
db(db.Location == 'J.H.White', 'Collector') = {'J.H. White'}
db(db.Location == 'J.H.White', 'Location') = {''}
db(db.Location == 'J.R. Cosgrove', 'Collector') = {'J.R. Cosgrove'}
db(db.Location == 'J.R. Cosgrove', 'Location') = {''}
db(db.Location == 'Malay', 'Location') = {'Malay States'}
db(db.Location == 'QUeensland', 'Location') = {'Queensland'}
db(db.Location == 'S.J. Record', 'Collector') = {'S.J. Record'}
db(db.Location == 'S.J. Record', 'Location') = {''}
db(db.Location == 'St Williams, Ont.', 'Location') = {'St. Williams, Ont.'}
db(db.Location == 'St. Williams', 'Location') = {'St. Williams, Ont.'}
db(db.Location == 'Strts. Settlement', 'Location') = {'Atrts. Settlements'}
db(db.Location == 'Strts. Settlements', 'Location') = {'Atrts. Settlements'}
db(db.Location == 'Ststs. Settlements', 'Location') = {'Atrts. Settlements'}
db(db.Location == 'Toronto', 'Location') = {'Toronto, Ontario'}
db(db.Location == 'Vancouver', 'Location') = {'Vancouver, B.C.'}
db(db.Location == 'Wycliffe, B.C', 'Location') = {'Wycliffe, B.C.'}

% Verify that the corrections were applied
unique(db.Location)

% If the Genus, Species, Family, or ComName are blank, change to unknown
db(db.Genus == '', 'Genus') = {'Unknown'}
db(db.Species == '', 'Species') = {'Unknown'}
db(db.Family == '', 'Family') = {'Unknown'}
db(db.ComName == '', 'ComName') = {'Unknown'}

% Convert to string
db.Family = string(db.Family);
% Apply a number of corrections to the tree Family names
db(db.Family == 'Aposynaceae', 'Family') = {'Apocynaceae'};
db(db.Family == 'Araucariacea', 'Family') = {'Araucariaceae'};
db(db.Family == 'Bombaceae', 'Family') = {'Bombacacea'};
db(db.Family == 'Bombacacea', 'Family') = {'Bombacaceae'};
db(db.Family == 'Dipterocapaceae', 'Family') = {'Dipterocarpaceae'};
db(db.Family == 'Dipterocardaceae', 'Family') = {'Dipterocarpaceae'};
db(db.Family == 'Dipterucampaceae', 'Family') = {'Dipterocarpaceae'};
db(db.Family == 'Eupnorbiaceae', 'Family') = {'Euphorbiaceae'};
db(db.Family == 'Juglandacere', 'Family') = {'Juglandaceae'};
db(db.Family == 'Lytheraceae', 'Family') = {'Lythraceae'};
db(db.Family == 'Meliaceaw', 'Family') = {'Meliaceae'};
db(db.Family == 'Monimoaceae', 'Family') = {'Monimiaceae'};
db(db.Family == 'Oleaxeae', 'Family') = {'Oleaceae'};
db(db.Family == 'Pinacee', 'Family') = {'Pinaceae'};
db(db.Family == 'Simarubrceae', 'Family') = {'Simarubaceae'};
db(db.Family == 'Taraceae', 'Family') = {'Taxaceae'};
db(db.Family == 'Olacaceae', 'Family') = {'Oleaceae'};
db(db.Family == 'Mraxeae' , 'Family') = {'Moraceae'};
db(db.Family == 'Meliceae' , 'Family') = {'Meliaceae'};
% Double check that there are no more spelling mistakes. 
unique(db.Family)


writetable(db, 'treeDatabase.csv') % Save database to root


data = jsonencode(db);

fid = fopen('myJson.js', 'w')
fwrite(fid, data, 'char')
fclose(fid);
