[ -z "$ZPLUG_BLAME_START_TIME" ] && export ZPLUG_BLAME_START_TIME=$(date +%s%N)

autoload colors; colors

__zplug_blame::init() {
    fn_name="__zplug::core::load::as_plugin"

    if typeset -f original_$fn_name > /dev/null; then
        echo "Zplug blame already initialized!"
        return
    fi

    if ! typeset -f $fn_name > /dev/null; then
        echo "Zplug not loaded!"
        return
    fi

    eval original_"$(declare -f $fn_name)"
    $fn_name() {
        local start=$(date +%s%N)

        original_$fn_name "$@"

        local end=$(date +%s%N)
        local time_taken=$(((end - start)/1000000))
        local fg_color=$fg[green]
        [ $time_taken -gt 100 ] && fg_color=$fg[yellow]
        [ $time_taken -gt 200 ] && fg_color=$fg[red]

        local plugin_file=$(echo $3 | sed -e 's/.*repos\///')
        echo "Loaded $plugin_file ($fg_color$time_taken ms$reset_color)"
    }
}

zplug_blame::print_load_time() {
    local end=$(date +%s%N)
    local time_taken=$(((end - ZPLUG_BLAME_START_TIME)/1000000))
    local fg_color=$fg[green]
    [ $time_taken -gt 500 ] && fg_color=$fg[yellow]
    [ $time_taken -gt 1000 ] && fg_color=$fg[red]

    echo "Finished loading in $fg_color$time_taken ms$reset_color"
}

__zplug_blame::init

