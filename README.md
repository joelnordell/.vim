.vim
====

My VIM dir, using github to keep in sync across machines

### Initial Setup

Important: if you are using a Mac, _do not use the pre-installed system vim_, install vim from Homebrew instead.

Verify that your `vim` has `python3` support enabled.

```
$ vim --version |grep +python3
```

After cloning this repository into your `~/.vim` directory, open `vim` and run this command:

```
:PlugInstall
```

### Command-T Plugin

The Command-T plugin requires a native Ruby extension to be compiled before it will work.

To compile:

    cd ~/.vim/ruby/command-t
    /usr/bin/ruby extconf.rb
    make

### YouCompleteMe Plugin

After installing this plugin, you might see a message like this:

```
The ycmd server SHUT DOWN (restart with ':YcmRestartServer')...efore using it. Follow the instructions in the documentation.
```

If you see that, follow the [installation instructions](https://github.com/ycm-core/YouCompleteMe#installation)
