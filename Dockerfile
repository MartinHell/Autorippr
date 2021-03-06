FROM ubuntu:18.04

COPY /build/* /

RUN apt-get update &&\
    apt-get install -y software-properties-common &&\
    add-apt-repository ppa:stebbins/handbrake-releases &&\
    apt-get update &&\
    apt-get install -y python-pip handbrake-cli libssl1.0.0 libexpat1 libavutil55 libavformat57 libavcodec-dev libavcodec-extra57 libgl1-mesa-glx unzip libmediainfo0v5 &&\
    rm -rf /var/lib/apt/lists/*
#RUN echo "deb http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu xenial main ">/etc/apt/sources.list.d/handbreak.list && apt-get update && apt-get install --allow-unauthenticated -y python-pip handbrake-cli libssl1.0.0 libexpat1 libavcodec-ffmpeg56 libgl1-mesa-glx unzip 
#libavcodec-ffmpeg-extra56


ADD https://github.com/MartinHell/Autorippr/archive/v1.8.0.zip autorippr-1.8.0.zip
ADD "http://downloads.sourceforge.net/project/filebot/filebot/FileBot_4.7.2/filebot_4.7.2_amd64.deb?r=http%3A%2F%2Fwww.filebot.net%2F&ts=1473715379&use_mirror=freefr" filebot_4.7.2_amd64.deb
RUN pip install tendo pyyaml peewee pymediainfo
RUN unzip /autorippr-1.8.0.zip
RUN dpkg -i filebot_4.7.2_amd64.deb

ADD settings.example.cfg /Autorippr-1.8.0/settings.cfg

ENTRYPOINT ["python", "/Autorippr-1.8.0/autorippr.py"]

