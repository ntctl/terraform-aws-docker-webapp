*Will be updated soon*


#### Clone the repository

```bash
git clone https://github.com/tchyba/dockerized-flask-todo.git
```

#### Build the Docker image

```bash
docker build -t todo-app .
```

#### Run it

```bash
docker run -d --name todo-app -p 127.0.0.1:8080:8080 todo-app
```

#### Enter the IP and port in the address bar

```bash
127.0.0.1:8080
```

#### Stop or start the container

```bash
docker stop/start todo-app
```