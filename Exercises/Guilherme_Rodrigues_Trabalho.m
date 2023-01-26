clear;
clc;

% Enunciado;
n = 30;
h = 0.1;
A(1,1) = -2*(1 + (h*h));
A(1,2) = 1;
A(n,n-1) = 1;
A(n,n) = -2*(1 + (h*h));
b = zeros(n,1);
b(1,1) = 1;
b(n,1) = 1;

for i=1:n
    x(i, 1) = 0;    % Faz matriz coluna;
    y(i, 1) = 0;    % Faz matriz coluna;
end

% Matriz A;
for i = 2:n-1
    A(i, i-1) = 1;
    A(i,i) = -2 * (1 + (h * h));
    A(i, i+1) = 1;
end

% Triangulariza Matriz aux;
aux = A;
for k=1:n-1
    for i=k+1:n
        m(i,k)=aux(i,k)/aux(k,k);
        aux(i,k)=0;
        for j=k+1:n
            aux(i,j)=aux(i,j)-m(i,k)*aux(k,j);
        end 
        b(i)=b(i)-m(i,k)*b(k);
    end 
end 

% Fatores L U;
U = aux;
for i=2:n
    for j=1:i-1
        L(i,j)=m(i,j);
    end
end
for i=1:n
    L(i,i)=1;
end

% Substituição Regressiva Inferior;
for i=1:n
    soma=b(i);
    for k=i+1:n
        soma=soma-L(i,k)*y(k);
    end
    y(i)=soma/L(i,i);
end

% Substituição Regressiva Superior;
for i=n:-1:1
    soma=y(i);
    for k=i+1:n
        soma=soma-U(i,k)*x(k);
    end
    x(i)=soma/U(i,i);
end

% Resultado do sistema;
x