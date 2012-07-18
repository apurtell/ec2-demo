exec >&2
redo-ifchange runpython.c
ARCHES=""
printf "Platforms: "
if [ -d /usr/libexec/gcc/darwin ]; then
    for d in /usr/libexec/gcc/darwin/*; do
        PLAT=$(basename "$d")
        [ "$PLAT" != "ppc64" ] || continue  # fails for some reason on my Mac
        ARCHES="$ARCHES -arch $PLAT"
        printf "$PLAT "
    done
fi
printf "\n"
gcc $ARCHES \
	-Wall -o $3 runpython.c \
	-I/usr/include/python2.5 \
	-lpython2.5
