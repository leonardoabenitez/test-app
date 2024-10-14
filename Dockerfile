FROM python:3.12-alpine3.19

WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    apk add --no-cache  curl

COPY . .

CMD ["python", "app.py"]
