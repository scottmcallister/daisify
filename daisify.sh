#!/bin/bash

## check if inside a Rails project at root
if [ ! -f "Gemfile" ] || [ ! -d "app" ]; then
  echo "This script must be run from the root of a Rails project."
  exit 1
fi

theme=$1

valid_themes=(
  "light" "dark" "cupcake" "bumblebee" "emerald" "corporate" "synthwave" "retro"
  "cyberpunk" "valentine" "halloween" "garden" "forest" "aqua" "lofi"
  "pastel" "fantasy" "wireframe" "black" "luxury" "dracula"
  "cmyk" "autumn" "business" "acid" "lemonade" "night" "coffee" "winter"
  "dim" "nord" "sunset" "caramallatte" "abyss" "silk"
)

if [ -z "$theme" ]; then
  theme="cupcake"
fi

if [[ ! " ${valid_themes[@]} " =~ " ${theme} " ]]; then
  echo "Invalid theme: $theme"
  echo "Valid themes are: ${valid_themes[*]}"
  exit 1
fi

echo "Downloading DaisyUI..."

curl -sLo app/assets/tailwind/daisyui.js https://github.com/saadeghi/daisyui/releases/latest/download/daisyui.js
curl -sLo app/assets/tailwind/daisyui-theme.js https://github.com/saadeghi/daisyui/releases/latest/download/daisyui-theme.js

echo "Writing to application.css..."

app_css="
@import \"tailwindcss\" source(none);
@source \"../../../public/*.html\";
@source \"../../../app/helpers/**/*.rb\";
@source \"../../../app/javascript/**/*.js\";
@source \"../../../app/views/**/*\";

@plugin \"./daisyui.js\" {
	themes: all;
}

/* Optional for custom themes – Docs: https://daisyui.com/docs/themes/#how-to-add-a-new-custom-theme */
@plugin \"./daisyui-theme.js\"{
  /* custom theme here */
};
";

echo "$app_css" > app/assets/tailwind/application.css

echo "Updating application layout..."

sed -i "s|<html>|<html data-theme=\"$theme\">|g" app/views/layouts/application.html.erb

echo "DaisyUI has been added with the '$theme' theme!"
