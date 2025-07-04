FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho
# Isso garante que os comandos subsequentes sejam executados neste diretório dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o `requirements.txt` primeiro para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 6: Comando para executar a aplicação
# Usamos "0.0.0.0" para tornar a aplicação acessível de fora do contêiner.
# O `--reload` não é usado em produção, então o removemos.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]