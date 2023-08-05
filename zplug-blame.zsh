autoload colors; colors

initialize_zplug_blame() {
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
        local start=$(($(date +%s%N)/1000000))

        original_$fn_name "$@"

        local end=$(($(date +%s%N)/1000000))
        local time_taken=$((end - start))
        local fg_color=$fg[green]
        [ $time_taken -gt 100 ] && fg_color=$fg[yellow]
        [ $time_taken -gt 200 ] && fg_color=$fg[red]

        local plugin_file=$(echo $3 | sed -e 's/.*repos\///')
        echo "Loaded $plugin_file ($fg_color$time_taken ms$reset_color)"
    }
}

initialize_zplug_blame

