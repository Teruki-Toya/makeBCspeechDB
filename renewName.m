%
%   'renewName.m'
%       データ名を変更する
%
%   前提: ディレクトリ内のファイル名表記が
%        '冒頭を基準として'部分的に統一されていること
%	
%	Author:  Teruki Toya
%	Created: Sep. 26, 2020.
%

clear

mkdir 1_syncData
mkdir 2_cutData

% 事前に指定
% -------------------
Nm_folder = 's01';  % 収録話者（'s01' ~ 's10'）
% -------------------

if strcmp(Nm_folder, 's10') == 1
    addNm = Nm_folder;
else
    addNm = [Nm_folder(1), Nm_folder(3)];
end

%% AClip 関連の名前変更
objct = 'AClip';
dInf = dir([Nm_folder, '/*', objct, '*.wav']);
for n = 1 : length(dInf)
    Nm_f = dInf(n).name(1:11);
    Nm_l = dInf(n).name(12:end);
    movefile([Nm_folder, '/', dInf(n).name],...
                    [Nm_folder '/', Nm_f, addNm, '_', Nm_l]);
end
clear objct dInf

%% ACneck 関連の名前変更
objct = 'ACneck';
dInf = dir([Nm_folder, '/*', objct, '*.wav']);
for n = 1 : length(dInf)
    Nm_f = dInf(n).name(1:11);
    Nm_l = dInf(n).name(12:end);
    movefile([Nm_folder, '/', dInf(n).name],...
                    [Nm_folder '/', Nm_f, addNm, '_', Nm_l]);
end
clear objct dInf

%% HG70 関連の名前変更
objct = 'HG70';
dInf = dir([Nm_folder, '/*', objct, '*.wav']);
for n = 1 : length(dInf)
    Nm_f = dInf(n).name(1:11);
    Nm_l = dInf(n).name(12:end);
    movefile([Nm_folder, '/', dInf(n).name],...
                    [Nm_folder '/', Nm_f, addNm, '_', Nm_l]);
end
clear objct dInf

%% 母音データの隔離
mkdir([Nm_folder, '/aiu'])
dInf = dir([Nm_folder, '/aiu*.wav']);
for n = 1 : length(dInf)
    movefile([Nm_folder, '/', dInf(n).name], [Nm_folder, '/aiu']);
end

%% 話者インデックスの表記を訂正
if length(addNm) == 2
    dInf = dir([Nm_folder, '/*.wav']);
    for n = 1 : length(dInf)
        Nm_f = dInf(n).name(1:10);
        Nm_l = dInf(n).name(11:end);
        movefile([Nm_folder, '/', dInf(n).name],...
                    [Nm_folder, '/', Nm_f, '0', Nm_l]);
    end
end