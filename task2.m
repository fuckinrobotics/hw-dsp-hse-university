% загрузка файла
load('DSPhsound.mat'); % загрузка файла

% входные параметры
Fc = 1150;
ripple = 3;
n = 5;

% расчет коэффициентов фильтра Баттерворта
[b, a] = butter(5, 2*Fc/Fs, 'low', 's');

% предварительное деформирование частоты
Wc = 2*Fs*tan(pi*Fc/Fs);

% преобразование ФНЧ-фильтра Баттерворта в ФНЧ-фильтр заданного типа
[bl, al] = lp2lp(b, a, Wc);

% билинейное преобразование для получения дискретного аналога
[bz, az] = bilinear(bl, al, Fs);

% округление
bz = round(bz*1e4)/1e4;
az = round(az*1e4)/1e4;

% Анализ устойчивости фильтра с использованием tf2zpk и zplane
[z, p, k] = tf2zpk(bz, az);
zplane(z, p);
if any(abs(p) >= 1)
   disp('Фильтр неустойчив изначально');
else
   disp('Фильтр устойчив изначально');
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
