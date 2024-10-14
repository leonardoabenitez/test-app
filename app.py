from flask import Flask
import controlador_data
from redis import Redis
from prometheus_client import make_wsgi_app, Counter, Histogram
from werkzeug.middleware.dispatcher import DispatcherMiddleware
import time



app = Flask(__name__)
redis = Redis(host='redis', port=6379, db=0)

app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
    '/metrics': make_wsgi_app()
})

request_count = Counter(
    'app_request_count',
    'Application Request Count',
    ['method', 'endpoint', 'http_status']
)
request_latency = Histogram(
    'app_request_latency_seconds',
    'Application Request Latency',
    ['method', 'endpoint']
)


## path root to say Hello Koro 
@app.route("/hello")
def hello_world():
    start_time = time.time()
    request_count.labels('GET', '/hello', 200).inc()
    request_latency.labels('GET', '/hello').observe(time.time() - start_time)
    return "Hello, Koronet Team!"

## Database connection to get items
@app.route("/listado")
def listado():
    listado = controlador_data.obtener_data()
    return render_template("listado.html", listado=listado)


### increment redis hits 
@app.route('/redis_hits')
def index():
    redis.incr('hits')
    return 'This page has been visited {} times.'.format(redis.get('hits'))


if __name__ == "__main__":
    app.run(host='0.0.0.0')
