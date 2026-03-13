#!/system/bin/sh

# Function to find the first available XML permission file
find_origin() {
    for file in \
        /odm/etc/permissions/com.gnss.bds_preference.xml; do
        if [ -e "$file" ]; then
            echo "$file"
            return
        fi
    done
    abort "No suitable permission file found!"
}

origin=$(find_origin)
target=$MODPATH$origin

DIR_OF_TARGET=$(dirname $target)
mkdir -p $DIR_OF_TARGET
cp -f $origin $target
sed -i '/cn.google.services/d' $target
sed -i '/services_updater/d' $target

ui_print "modify $origin"
