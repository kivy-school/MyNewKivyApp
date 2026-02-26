
# create .venv by
uv sync

# make build-wheels executable
chmod +x wheel_sources/build-wheels.sh

# build custom wheels for local wheels/simple
./wheel_sources/build-wheels.sh

# update pyproject.toml to use current location of wheels folder
sed -i '' 's|url = "file://.*wheels/simple"|url = "file://'"$PWD"'/wheels/simple"|' pyproject.toml

# update simple index
uv run psproject update simple

# update xcode project site-packages
uv run psproject update site-packages