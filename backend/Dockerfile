# base image
FROM python:3.10

# Set the working directory
WORKDIR /app/

# Update os package and install necessary pakcage
RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean

# Copy the application code
COPY . .

# set the Python environment path
ENV PYTHONPATH=/app

# install python package
RUN pip install -r requirements.txt

# Expose the port that the app will run on
EXPOSE 8000
 
CMD ["uvicorn", "app.main:app", "--host",  "0.0.0.0", "--reload", "--port", "8000"]
