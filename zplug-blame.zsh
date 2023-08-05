if typeset -f __zplug::core::load::as_plugin > /dev/null; then
    eval original_"$(declare -f __zplug::core::load::as_plugin)"
    
    __zplug::core::load::as_plugin() {
        local plugin_file=$(echo $3 | sed -e 's/.*repos\///')
        local start=$(($(date +%s%N)/1000000))
        original___zplug::core::load::as_plugin "$@"
        local end=$(($(date +%s%N)/1000000))
        echo "Loaded plugin file $plugin_file ($((end - start))ms)"
    }
else
    echo "Plugin load function not found!"
fi




