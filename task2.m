% Параметры
load DSPhsound.mat;
fc = 100000;
ripple = 3;
n = 5;
Wn = fc/(Fs/2);
wp = 2*Fs*tan(pi*Wn/Fs);
[b, a] = butter(n, wp, 's');
[bl, al] = lp2lp(b, a, Wn);
[bz, az] = bilinear(bl, al, Fs);
bz = round(bz*1e4)/1e4;
az = round(az*1e4)/1e4;

% Анализ устойчивости фильтра с использованием tf2zpk и zplane
[z, p, k] = tf2zpk(bz, az);
zplane(z, p);
if any(abs(p) >= 1)
    disp('Фильтр неустойчив');
else
    disp('Фильтр устойчив');
end

% Продолжаем округлять и следим за устойчивостью фильтра
for i = 3:-1:0
    bz = round(bz*10^i)/10^i;
    az = round(az*10^i)/10^i;
    [z, p, k] = tf2zpk(bz, az);
    zplane(z, p);
    if any(abs(p) >= 1)
        disp(['Фильтр неустойчив при округлении до ', num2str(i), ' знаков']);
        break;
    end
end
