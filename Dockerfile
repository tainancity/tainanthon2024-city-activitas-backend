FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# create data directory
RUN mkdir -p /app/data

COPY server /app/server

RUN useradd -r -s /bin/false appuser \
  && chown -R appuser:appuser /app

USER appuser 

ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["fastapi", "run", "server/main.py", "--host", "0.0.0.0", "--port", "8000"]
