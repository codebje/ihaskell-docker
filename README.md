# IHaskell in a container

This Dockerfile installs [Jupyter] and the [IHaskell] kernel, and `expose`s
port 8888.

The fastest way to get up and running is:

    docker run -d --name ihaskell -p 127.0.0.1:8888:8888 codebje/ihaskell

You can mount a volume into `/books` if you'd like external persistence of
your notebooks, and you can require a password by setting the `password`
environment variable when launching the container.

The notebook server runs as user ID 1000.

Be cautious about letting Docker expose ports without a specific IP address
binding, as the default run state of Jupyter has no security and will allow
anyone who finds your notebook server to execute arbitrary code inside your
container.

[Jupyter]: https://jupyter.org/
[IHaskell]: https://github.com/gibiansky/IHaskell
