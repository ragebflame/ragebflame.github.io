---
layout: post
title: Simulate CPU load with Python
tags:
  - programming
excerpt: Cool
summary: Enjoy
image: /assets/img/python.webp
---

{% include figure.html url="python.webp" alt="sssss" caption="" %}

```python
#!/usr/bin/env python
from multiprocessing import Pool
from multiprocessing import cpu_count
import signal

stop_loop = 0

def exit_chld(x, y):
    global stop_loop
    stop_loop = 1

def f(x):
    global stop_loop
    while not stop_loop:
        x*x

signal.signal(signal.SIGINT, exit_chld)

if __name__ == '__main__':
    processes = cpu_count()
    print('-' * 20)
    print('Running load on CPU(s)')
    print('Utilizing %d cores' % processes)
    print('-' * 20)
    pool = Pool(processes)
    pool.map(f, range(processes))
```

Produces:

```text
--------------------
Running load on CPU(s)
Utilizing 8 cores
--------------------
```