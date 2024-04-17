FROM python:3.6-alpine
LABEL maintener="GBANE Assouman"
LABEL email="gbane.assouman@gmail.com"
WORKDIR /opt
RUN pip install flask==1.1.2
COPY ./app /opt/ 
EXPOSE 8080
ENV ODOO_URL='https://www.odoo.com/'
ENV PGADMIN_URL='https://www.pgadmin.org/'
ENTRYPOINT ["python","app.py"]

