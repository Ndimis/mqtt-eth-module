FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install paho-mqtt web3
CMD ["python", "app.py"]
