FROM python:3.8

COPY ./backend /backend

WORKDIR /backend

RUN pip install -r requirements/dev.txt

# COPY ./docker/dev/python/entrypoint.sh /entrypoint.sh

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN chown 1000:1000 /vol/web/media
RUN chmod -R 775 /vol/web/media

# RUN adduser --disabled-login user
# RUN chown -R user:user /vol/
# RUN chown -R 755 /vol/web

# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]

# USER user
