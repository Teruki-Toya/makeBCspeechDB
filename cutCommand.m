%
%   'cutCommand.m'
%       データをコマンドごとにカットする
%	
%	Author:  Teruki Toya
%	Created: Sep. 25, 2020.
%

clear

% 事前に指定
% ---------------
Nm_folder = 's02'; % 収録話者（'s01' ~ 's10'）
Pg = 'Page1'; % ページごとに分割されている場合
Cond = 'nn'; % 条件（'nn', '55', '65', '75'）
% 収録がページごとに分割されている場合、
% 下記にページの最初のコマンド番号を指定する
% 通常は '1' でよい
init = 1;
% ---------------
% ラグ調整済の一括データを取得
load(['1_syncData/', Nm_folder, '/', Cond, '/dAll.mat'])

% 切れ目の時刻を取得（※ 事前に .csv ファイルを編集のこと）
t_cut = readmatrix('cut.csv');
if size(t_cut, 1) > 1
    t_cut = t_cut(1, :);
end
% 時刻をサンプルindexに変換
Pcut = round(t_cut * fs);

destDir = ['2_cutData/', Nm_folder, '/', Cond];
mkdir(['2_cutData/', Nm_folder])
mkdir(destDir)
% 一括切り出し処理
for n = 1 : length(Pcut) - 1
    xc = x(:, Pcut(n) : Pcut(n + 1));   % 切り出されたデータ
    Icom = init + n - 1;    % 音声コマンド番号
    if Icom < 10    % w01 ~ w09 の処理
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_AClip.wav'], xc(1, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ACNeck.wav'], xc(2, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_HG70.wav'], xc(3, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_M1.wav'], xc(4, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_M2.wav'], xc(5, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_X.wav'], xc(6, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_Y.wav'], xc(7, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_Z.wav'], xc(8, :), fs);
        audiowrite([destDir, '/w0', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_mixed.wav'], xc(9, :), fs);
    else   %  w10 以降の処理
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_AClip.wav'], xc(1, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ACNeck.wav'], xc(2, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_HG70.wav'], xc(3, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_M1.wav'], xc(4, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_M2.wav'], xc(5, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_X.wav'], xc(6, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_Y.wav'], xc(7, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_Z.wav'], xc(8, :), fs);
        audiowrite([destDir, '/w', num2str(Icom),...
                        '_', Nm_folder, '_', Cond,...
                                '_ST_mixed.wav'], xc(9, :), fs);
    end
end
