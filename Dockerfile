# Utilise une image légère avec Python
FROM python:3.9-slim

# Installe les dépendances système
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Copie le code du dépôt
COPY . /app
WORKDIR /app

# Installe les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Installe ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    rm ngrok-stable-linux-amd64.zip && \
    mv ngrok /usr/local/bin/

# Expose le port de Flask
EXPOSE 5000

# Commande de démarrage
CMD ["python", "app.py"]