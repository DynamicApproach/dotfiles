def run-url [url] {
    let fetched_script = (http get $url | to text)
    echo $fetched_script | save -f fetched-script.sh
    chmod u+x fetched-script.sh
    ./fetched-script.sh
}

mkdir ~/.local/share/atuin
^atuin init nu | save -f --raw ~/.local/share/atuin/init.nu

# Updating NuShell config with Atuin initialization
let content = (open ~/.config/nushell/config.nu | to text)
let updated_content = $content + "\nsource ~/.local/share/atuin/init.nu"
echo $updated_content | save -f ~/.config/nushell/config.nu

# Installing Starship
run-url "https://starship.rs/install.sh"

# Updating NuShell config with Starship initialization
let current_config = (open ~/.config/nushell/config.nu | to text)
let new_commands = "mkdir -p ~/.cache/starship\nstarship init nu | save -f --raw ~/.cache/starship/init.nu\n"
let updated_config = $current_config + $new_commands
echo $updated_config | save -f ~/.config/nushell/config.nu

# Adding nuopen command and sourcing Starship in NuShell config
let current_config = (open ~/.config/nushell/config.nu | to text)
let new_commands = "def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }\nalias open = ^micro\nsource ~/.cache/starship/init.nu\n"
let updated_config = $current_config + $new_commands
echo $updated_config | save -f ~/.config/nushell/config.nu

# Installing micro editor
run-url "https://getmic.ro"
^sudo mv ./micro /usr/bin/

mkdir ~/.config
touch ~/.config/starship.toml
cp ./starship.toml ~/.config/starship.toml

