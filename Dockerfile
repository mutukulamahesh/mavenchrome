FROM maven:3.6.3-openjdk-15

#ENV HTTP_PROXY="$host:80"
#ENV HTTPS_PROXY="$host:80"

RUN cat /etc/os-release

ARG CHROME_VERSION=87.0.4280.141
ADD google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN microdnf install -y google-chrome-stable \
	&& sed -i 's/"$HERE\/chrome"/"$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

COPY auto/ auto/
COPY testdata/ testdata/
COPY generic/ generic/

COPY generic/chromedriver /opt/chromedriver
RUN chmod 755 /opt/chromedriver
RUN ln -fs /opt/chromedriver /usr/bin/chromedriver

ENTRYPOINT ["java","-jar","myapp.jar"]
