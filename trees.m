% University of Toronto Wood Collection

% Download database file
db = readtable('database.txt') % This produced and error "unable to open file 'database.txt'

% Luckly I had the original .xlsx file
db = readtable('documents/uoftCatClean.xlsx') 

% Wanted to confirm if the date column was a datetime type or cell?
class(db.Date)  % returns cell


db.Date = datetime(db.Date, 'InputFormat', '%{yyyy}D') 

class(db.Date)

dates = db.Date
