FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER activer
RUN echo activer
CMD echo activer
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/archive/main/Cerebellum3merge.bin-main.zip" -O Cerebellum3Merge.bin.7z
Run 7z e Cerebellum3Merge.bin.7z && rm Cerebellum3Merge.bin.7z

RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/02ef1f4496965b5ad8c26ac6bc18245eaffae2ea/linux64avx2/stockfish_22081719_x64_avx2.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt


RUN chmod +x chess-engine

# Engine name is here ^^^^^^
