FROM python:3.10.12

# Recieving chromedriver url
ARG CHROME_DRIVER_URL

# Verifying value of CHROME_DRIVER_URL
RUN if [ -z "$CHROME_DRIVER_URL" ]; then echo "CHROME_DRIVER_URL is not defined"; exit 1; else wget $CHROME_DRIVER_URL; fi

# Adding the Google's signature key to the package manager
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# Updating packages and Installing Google Chrome
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

#Installing Unzip
RUN apt-get install -yqq unzip
# Downloading a specific verison of Chromedriver
RUN wget $CHROME_DRIVER_URL
RUN unzip chromedriver-linux64.zip
# Moving Chromedriver
RUN mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && chown root:root /usr/local/bin/chromedriver && chmod +x /usr/local/bin/chromedriver

# Checking versions
RUN google-chrome --version
RUN chromedriver --version

# installing font for other languages and cleanning cache
RUN apt-get update && \
    apt-get install -y \
        fonts-ipafont-gothic fonts-ipafont-mincho \
        ttf-wqy-microhei fonts-wqy-microhei       \
        fonts-tlwg-loma fonts-tlwg-loma-otf       \
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Updating pip
RUN python3 -m pip install --upgrade pip
COPY ./libraries.txt /tmp/libraries.txt
RUN  pip3 install -r /tmp/libraries.txt
