
function [signal, t] = generate_sine(f, duration)
    Fs = 100; % Частота дискретизации
    t = 0:1/Fs:duration-1/Fs; % Временная шкала
    signal = sin(2*pi*f*t);
end


function interpolated = interpolate_2x(signal)
    x = 1:length(signal);
    xi = 1:0.5:length(signal)+0.5;
    interpolated = interp1(x, signal, xi, 'linear','extrap');
end

function decimated = decimate_2x(signal)
    decimated = signal(1:2:end);
end

frequencies = 0:1:50; % Частоты 
duration = 1; % Длительность сигнала в секундах
errors = zeros(size(frequencies));
    
    for i = 1:length(frequencies)
        f = frequencies(i);
        
        [original, t] = generate_sine(f, duration);
      
        decimated = decimate_2x(original);
        interpolated = interpolate_2x(decimated);

        subplot(3,1,1);
        plot(round(original,10));
        xlabel('Частота сигнала, Гц');
        ylabel('Амплитуда');
        title(['Исходный сигнал при ' num2str(f) ' Гц']);

        subplot(3,1,2);
        plot(round(decimated,10));
        xlabel('Частота сигнала, Гц');
        ylabel('Амплитуда');
        title('Cигнал после децимации');
        subplot(3,1,3);
        plot(round(interpolated,10));
        xlabel('Частота сигнала, Гц');
        ylabel('Амплитуда');
        title('Cигнал после интерполяции');

        errors(i) = sqrt(mean((original - interpolated).^2));
    end
    

    figure;
    plot(frequencies, errors, 'b-o');
    xlabel('Частота сигнала, Гц');
    ylabel('Ошибка (СКО)');
    title('Зависимость ошибки от частоты сигнала');
    grid on;