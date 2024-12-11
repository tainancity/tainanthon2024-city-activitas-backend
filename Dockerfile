FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
  sqlite3 \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# create data directory
RUN mkdir -p /app/data

COPY server /app/server

ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["fastapi", "run", "server/main.py", "--host", "0.0.0.0", "--port", "8000"]
