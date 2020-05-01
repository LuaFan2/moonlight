name="gamemode"

rm -rf $name
mkdir $name

# Compile the MoonScript code into Lua.
moonc -t $name src

mv -v $name/src/* $name
rmdir $name/src