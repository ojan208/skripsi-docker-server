FROM ubuntu:latest

# di dokumentasinya katanya required git buat build, walau masih kurang tau buat apa
RUN apt-get update && \
    apt-get install -y git default-jre

WORKDIR /app

COPY . .

# gain permission to run script
RUN chmod +x run_server.sh

# untuk menjalankan server. 
ENTRYPOINT [ "./run_server.sh" ]

# Default argument kalau tidak diberikan oleh user
CMD [ "worker-server-1", "localhost:35353" ]
