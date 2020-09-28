%
%   'syncronize.m'
%       データのタイミングをそろえる
%	
%	Author:  Teruki Toya
%	Created: Sep. 25, 2020.
%

clear

% 事前に指定
% ---------------
Nm_folder = 's02'; % 収録話者（'s01' ~ 's10'）
Pg = 'Page1'; % ページごとに分割されている場合（'Page1', 'Page2', 'Page3'）
Cond = 'nn';  % 条件（'nn', '55', '65', '75'）
% ---------------

%% 
% 基準データ（口唇）
bfInf = dir([Nm_folder, '/', Pg, '*', Cond, '*AClip.wav']);
[x0, fs] = audioread([Nm_folder, '/', bfInf(1).name]);
if size(x0, 1) > 3
    x0 = x0';
end

% 全データ
rdInf = dir([Nm_folder, '/', Pg, '*', Cond, '*.wav']);
x = zeros(length(rdInf), length(x0));

d = zeros(length(rdInf), 1);    % ラグサンプル数
% タイムラグ調整
destDir = ['1_syncData/', Nm_folder, '/', Cond];
mkdir(['1_syncData/', Nm_folder]);
mkdir(destDir)    % 調整済データ用ディレクトリ
for n = 1 : length(rdInf)
    [x_tmp, ~] = audioread([Nm_folder, '/', rdInf(n).name]);
    if size(x_tmp, 1) > 3
        x_tmp = x_tmp';
    end
    % データ長が基準データ長より短いときは、0埋めで揃える
    if length(x_tmp) < length(x0)
        x_tmp = [x_tmp, zeros(1, length(x0) - length(x_tmp))];
    end
    % ラグ調整（相互相関）
    if n < 5    % ST_M1までのデータについては愚直にラグ調整
        [c, lag] = xcorr(x_tmp, x0);
        d(n) = lag(c == max(c));
    else        % それ以降のST基盤からのデータについては、ST_M1に合わせる
        d(n) = d(4);
    end
    
    % タイムラグが 1/100 s 以下なら調整しない
    if abs(d(n)) <= fs/100
        d(n) = 0;
    end
    
    if d(n) > 0  % d > 0（遅れ）のとき : 前にずらす
        x_tmp = [x_tmp(d(n)+1 : end), x_tmp(1:d(n))];
    elseif d(n) < 0 % d < 0（進み）のとき : 後ろにずらす
        x_tmp = [x_tmp(end+d(n)+1 : end), x_tmp(1:end+d(n))];
    end
    
    % データ長を基準データ長に揃える
    if length(x_tmp) > length(x0)
        x_tmp = x_tmp(1:length(x0));
    end
    
    x(n, :) = x_tmp; % 一括処理できるように、ひとつの変数に格納
    % オーディオ書き出し
    audiowrite([destDir, '/', rdInf(n).name(1:end-4),...
                                '_o.wav'], x_tmp, fs)
end
save([destDir, '/dAll.mat'], 'x', 'fs')

%% プロット
tau = (0 : length(x0) - 1) ./ fs;

for k = 1 : size(x, 1)
    figure
    plot(tau, x(k, :))
end