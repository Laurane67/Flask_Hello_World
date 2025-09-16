# Utilise une image légère avec Python
FROM python:3.9-slim

# Installe les dépendances système nécessaires
RUN apt-get update && \
    apt-get install -y wget unzip git && \
    rm -rf /var/lib/apt/lists/*

# Copie le code du dépôt
COPY . /app
WORKDIR /app

# Installe les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Télécharge et installe ngrok (URL officielle)
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -xvzf ngrok-v3-stable-linux-amd64.tgz && \
    rm ngrok-v3-stable-linux-amd64.tgz && \
    mv ngrok /usr/local/bin/

# Expose le port de Flask
EXPOSE 5000

# Commande de démarrage
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]