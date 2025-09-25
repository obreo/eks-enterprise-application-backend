FROM python:3.12-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

EXPOSE 5000
CMD ["gunicorn", "--bind", "[::]:5000", "main:app"]