% Загрузка сигнала
load DSPhsound.mat;

% Задание частоты среза
fc = 1150;

% Вычисление коэффициентов фильтра
Nmin = 33; % Длина фильтра
n = -(Nmin-1)/2:(Nmin-1)/2; % Вектор отсчетов времени
wc = 2*pi*fc/Fs; % Цифровая частота среза
b = wc/pi*sinc(wc/pi*n); % Идеальный фильтр
w = blackman(Nmin); % Окно Блекмана
b = b.*w'; % Применение окна

% Фильтрация сигнала
y_Nmin = filter(b, 1, y);
b_Nmin_2 = b(1:end-2);
y_Nmin_2 = filter(b_Nmin_2, 1, y);

% Воспроизведение сигналов
sound(y, Fs); % Исходный сигнал
pause(length(y)/Fs); % Пауза между воспроизведениями
sound(y_Nmin_2, Fs); % Фильтр длины Nmin-2
pause(length(y_Nmin_2)/Fs); % Пауза между воспроизведениями
sound(y_Nmin, Fs); % Фильтр длины Nmin
