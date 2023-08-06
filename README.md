# zplug-blame
A zsh plugin for zplug that lets you see how long it took for each zplug plugin to load
<img src="https://github.com/jkcdarunday/zplug-blame/assets/4564810/e562774a-24b5-4ba3-8cb9-58584e53bceb" width="800" />

## Usage
Make sure that this plugin is loaded before any other plugins.

### Print plugin load times with zplug's total load time
If you want to print the total time since zplug has loaded, you can follow the ff. example in your .zshrc:
```zsh
export ZPLUG_BLAME_START_TIME=$(date +%s%N)
. /usr/share/zsh/scripts/zplug/init.zsh

zplug 'jkcdarunday/zplug-blame'
# Your other zplug plugins go here

zplug check || zplug install
zplug load
zplug_blame::print_load_time
```

### Print plugin load times only
If you don't want to print the zplug load time, you can omit the `export` and `print_load_time` lines like in the ff. example:
```zsh
. /usr/share/zsh/scripts/zplug/init.zsh

zplug 'jkcdarunday/zplug-blame'
# Your other zplug plugins go here

zplug check || zplug install
zplug load
```

