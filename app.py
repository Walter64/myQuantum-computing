#  importing 3 packages
import time
import redis
from flask import Flask

# flask is a web application

# new Flask instance, name is file name 'app'
app = Flask(__name__)

# connect to Redis instance defined in docker-compose file
cache = redis.Redis(host='redis', port=6379)

# trying to connect to redis - 5 tries
def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits') # returns value from redis
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

# what to do when someone tries to visit using forward slash, localhost
@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello from Docker! I have been seen {} times.\n'.format(count)
