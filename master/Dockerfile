FROM ubuntu:latest

# di dokumentasinya katanya required git buat build, walau masih kurang tau buat apa
RUN apt-get update && \
    apt-get install -y git && \
    apt-get install -y default-jre

WORKDIR /app

COPY . .

# beri permission pada container buat file yg telah dicopy
RUN chmod +x multipaper-master-2.12.3-all.jar

# untuk menjalankan server
ENTRYPOINT [ "java", "-jar", "multipaper-master-2.12.3-all.jar" ]

# Default argument to run the server
CMD [ "35353" ]