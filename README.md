# libpy

An experiment on Python environments

## Usage

In `python.edn` change the sample path to your environment path. It must be a base path, such as:

```shell
/home/username/miniconda3/envs/myenv
```

After this you can use leiningen as usual by adding `python` to your commands.

```shell
lein python run # or any other task
```

## Explanation

This simply exploits a leiningen plugin ([lein-with-env-vars](https://github.com/athos/lein-with-env-vars)) to load the `PYTHONHOME` env variable **before** doing anything else.

This lets us have access to the path at runtime and with this we can prepend it to the usual `:java-library-path`. It must be prepended (even better if completely overwritten, and after initialization reset to the initial state), otherwise we might end up finding other Python versions along the usual path.

Moreover, some environments on some systems have everything inside the `bin` and `lib` folders, while others have the python binaries inside the base path. So `/my/python/path/lib` and `/my/python/path/bin` are generated and added in order after the base path, but before the default `:java-library-path`.

At this point the Python session was getting lost because for some reason when started like this it doesn't get the current env, so the VM was starting, but it couldn't load anything and it was breaking. Be aware that this breaks because Python tries looking for itself within `PYTHONHOME`, but if the latter is empty than it falls back to `/usr/local` (source: https://docs.python.org/3.7/using/cmdline.html#envvar-PYTHONHOME).

This fact means that you might start the VM from your wanted environment, Python gets loaded from `/usr/local` if it can be found there and then everything breaks when you try to import things from your environment.

With [lein-with-env-vars](https://github.com/athos/lein-with-env-vars) + some code before `initialize!` we can be (somewhat) sure to start everything from the wanted folder.