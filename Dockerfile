FROM openjdk:14-jdk-oraclelinux7

ENV QTEST_TOKEN=fagasgakjgkjasglkjakslgjalksjg
ENV QTEST_HOST=HR_TEST
RUN mkdir /usr/local/qtest/

WORKDIR /usr/local/qtest/

COPY agentctl-2.2.2-linux-x64-full.tgz agentctl-2.2.2-linux-x64-full.tgz

RUN set -x \
    && tar xvzf agentctl-2.2.2-linux-x64-full.tgz -C /usr/local/qtest/ \
    && rm agentctl-2.2.2-linux-x64-full.tgz \
    && mv agentctl-2.2.2 agent

RUN ./agent/agentctl config -Phost=0.0.0.0 -Pport=6789

EXPOSE 6789

COPY entrypoint.sh /entrypoint.sh

RUN chmod u+wrx /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [${QTEST_HOST},${QTEST_TOKEN}]