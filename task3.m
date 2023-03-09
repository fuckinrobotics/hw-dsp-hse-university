% Загрузка аудио сигнала
load DSPhsound.mat;

% Граничная частота для фильтра
Fc = 1000;

% Длина фильтра
Nmin =1111;

% Окно Блэкмана
w = blackman(Nmin);

% Проектирование FIR-фильтра
b = fir1(Nmin-1, Fc/(Fs/2), 'low', w);

% Фильтрация сигнала
y_filtered = filter(b, 1, y);

% Воспроизведение отфильтрованного звука
sound(y_filtered, Fs);
