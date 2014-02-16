%basedir - '/path/to/directory/containing/files/'
%shotnum - the number of the shot
%n - the number of files in the shot to include
%
%outputs a cell array of form '{basedir}{shotnum}-{1:n}.jpg'
function fnames = buildfnames(basedir,shotnum,n)
    for i = 1:n
        fnames{i} = [basedir, num2str(shotnum), '-', num2str(i), '.jpg'];
    end
end