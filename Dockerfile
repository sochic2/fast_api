FROM python:3.10-slim

RUN apt-get install -y docker-compose

RUN echo "Asia/Seoul" > /etc/timezone

COPY ./app /app

RUN pip install --no-cache-dir -r /app/requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
