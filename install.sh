{
    np2_has() {
        type "$1" > /dev/null 2>&1
    }

    np2_install_dir() {
        command printf %s "${NP2_DIR:-"$HOME/.np2"}"
    }

    np2_latest_version() {
        echo "v0.0.1"
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

        mkdir -p "$INSTALL_DIR"

        if [ -f "$INSTALL_DIR/np2" ]; then
            echo "=> np2 is already installed in $INSTALL_DIR, trying to update the script"
        else
            echo "=> Downloading np2 as script to '$INSTALL_DIR'"
        fi

        np2_download -s "$NP2_SOURCE_LOCAL" -o "$INSTALL_DIR/np2" || {
            echo >&2 "Failed to download '$NP2_SOURCE_LOCAL'"
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

        ln -s "$INSTALL_DIR/np2" /usr/local/bin
    }

    install
}
