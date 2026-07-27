FROM python:3.11-slim

WORKDIR /app

# Instala dependências do sistema e limpa cache (se precisar conectar a banco, etc)
RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Práticas de Segurança: rodar com usuário sem privilégios root
RUN addgroup --system appgroup && adduser --system --group appuser
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]
