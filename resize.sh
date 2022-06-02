#!/bin/bash
cd /d
tmp="whde_tmp"
dir=$(echo `pwd`)

find . -name "*.bmp" -o -name "*.jpg" -name "*.jpeg" -o -name "*.png" -o -name "*.tif" -o -name "*.gif" -o -name "*.pcx" -o -name "*.tga" -o -name "*.exif" -o -name "*.fpx" -o -name "*.svg" -o -name "*.psd" -o -name "*.cdr" -o -name "*.pcd" -o -name "*.dxf" -o -name "*.ufo" -o -name "*.eps" -o -name "*.ai" -o -name "*.raw" -o -name "*.WMF" -o -name "*.webp" -o -name "*.avif" -o -name "*.apng" -o -name "*.BMP" -o -name "*.JPG" -name "*.JPEG" -o -name "*.PNG" -o -name "*.TIF" -o -name "*.GIF" -o -name "*.PCX" -o -name "*.TGA" -o -name "*.EXIF" -o -name "*.FPX" -o -name "*.SVG" -o -name "*.PSD" -o -name "*.CDR" -o -name "*.PCD" -o -name "*.DXF" -o -name "*.UFO" -o -name "*.EPS" -o -name "*.AI" -o -name "*.RAW" -o -name "*.WMF" -o -name "*.WEBP" -o -name "*.AVIF" -o -name "*.APNG" | while read -r item; do
    if [[ $item =~ $tmp ]]; then
        echo '过滤掉含whde_tmp'
    else
        name=$(basename "$item")
        echo "$item"
        path=$(dirname "$item")
        tmp_file="$dir/$path/$tmp/$name"
        if [ -f "$tmp_file" ]; then
            echo "过滤已生成"
        else
            tmp_path="$dir/$path/$tmp"
            if [ -d "$tmp_path" ]; then
                 echo "不重复创建whde_tmp"
            else
                mkdir "$tmp_path"
            fi

            echo "magick $dir/$item"
            magick "$dir/$item" -resize 100 "$tmp_file"
        fi
    fi
done
sleep 1000
