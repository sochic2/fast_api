FROM python:3.10-slim

RUN echo "Asia/Seoul" > /etc/timezone

COPY ./app /app

COPY ./test /test

WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

RUN alembic revision --autogenerate

RUN alembic upgrade head

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
