{
    np2_has() {
        type "$1" > /dev/null 2>&1
    }

    np2_install_dir() {
        command printf %s "${NP2_DIR:-"$HOME/.np2"}"
    }

    np2_latest_version() {
        cat "${NP2_DIR}/version"
    }

    np2_download() {
        if np2_has "curl"; then
            curl --compressed -q "$@"
        elif np2_has "wget"; then
            # Emulate curl with wget
            ARGS=$(echo "$*" | command sed -e 's/--progress-bar /--progress=bar /' \
                                       -e 's/-L //' \
                                       -e 's/--compressed //' \
                                       -e 's/-I /--server-response /' \
                                       -e 's/-s /-q /' \
                                       -e 's/-o /-O /' \
                                       -e 's/-C - /-c /')
            # shellcheck disable=SC2086
            eval wget $ARGS
        fi
    }

    install() {
        INSTALL_DIR="$(np2_install_dir)"
        NP2_SOURCE_LOCAL="https://raw.githubusercontent.com/vcinly/np2/master"

        mkdir -p "$INSTALL_DIR"

        if [ -f "$INSTALL_DIR/np2" ]; then
            echo "=> np2 is already installed in $INSTALL_DIR, trying to update the script"
            
        else
            echo "=> Downloading np2 as script to '$INSTALL_DIR'"
        fi

        np2_download -s "$NP2_SOURCE_LOCAL/np2" -o "$INSTALL_DIR/np2" || {
            echo >&2 "Failed to download '$NP2_SOURCE_LOCAL/np2'"
            return 1
        } &

        np2_download -s "$NP2_SOURCE_LOCAL/install.sh" -o "$INSTALL_DIR/install.sh" || {
            echo >&2 "Failed to download '$NP2_SOURCE_LOCAL/install.sh'"
            return 1
        } &

        np2_download -s "$NP2_SOURCE_LOCAL/version" -o "$INSTALL_DIR/version" || {
            echo >&2 "Failed to download '$NP2_SOURCE_LOCAL/version'"
            return 1
        } &

        for job in $(jobs -p | command sort)
        do
            wait "$job" || return $?
        done

        chmod a+x "$INSTALL_DIR/np2" || {
            echo >&2 "Failed to mark '$INSTALL_DIR/np2' as executable"
            return 3
        }

        if [ -f "/usr/local/bin/np2" ]
        then
	          rm -f "/usr/local/bin/np2"
        fi
        ln -s "$INSTALL_DIR/np2" /usr/local/bin

        echo "NP2 install or update success!"
        echo "Use \`np2 -h\` to get help."
    }

    install
}
