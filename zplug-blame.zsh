if typeset -f __zplug::core::arguments::exec > /dev/null; then
    eval original_"$(declare -f __zplug::core::arguments::exec)"

    __zplug::core::arguments::exec() {
        local start=$(($(date +%s%N)/1000000))
        echo "Caching plugins..."
        original___zplug::core::arguments::exec "$@"
        env=$(($(date +%s%N)/1000000))
        echo "Cached plugins $@ ($((end - start))ms))"
    }
else
    echo "Zplug function not found!"
fi


if typeset -f __zplug::core::load::from_cache > /dev/null; then
    eval original_"$(declare -f __zplug::core::load::from_cache)"
    
    __zplug::core::load::from_cache() {
        local start=$(($(date +%s%N)/1000000))
        echo "Loading cached plugins $@..."
        original___zplug::core::load::from_cache "$@"
        local end=$(($(date +%s%N)/1000000))
        echo "Loaded cached plugins $@ ($((end - start))ms)"
    }
else
    echo "Cache function not found!"
fi

if typeset -f __zplug::core::load::as_plugin > /dev/null; then
    eval original_"$(declare -f __zplug::core::load::as_plugin)"
    
    __zplug::core::load::as_plugin() {
        local plugin_file=$(echo $3 | sed -e 's/.*repos\///')
        local start=$(($(date +%s%N)/1000000))
        original___zplug::core::load::as_plugin "$@"
        local end=$(($(date +%s%N)/1000000))
        echo "\tLoaded plugin file $plugin_file ($((end - start))ms)"
    }
else
    echo "Plugin load function not found!"
fi




