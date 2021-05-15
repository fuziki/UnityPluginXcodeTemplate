#!/bin/sh
# Shell Script to export unitypackage

echo "export unitypackage!"

if [ $# -ne 1 ]; then
    echo "Set the export directory!"
    exit 1
fi

output_path=$1

tmp_directory="tmp"

abs_output_path=$(cd $output_path && pwd)

echo "abs_output_path -> ${abs_output_path}"

metafile_list=`find Assets -name "*.meta"`

for metafile in $metafile_list; do
    echo "target meta file -> ${metafile}"
    assetfile=`dirname $metafile`/`basename $metafile .meta`
    echo "asset file -> ${assetfile}"

    guidline=`grep "guid: " $metafile`
    guid=${guidline:6} # "guid: " を切り抜く
    echo "guid -> ${guid}"
    
    tmp_asset_directory=$tmp_directory/$guid
    
    # make guid directory
    mkdir -p $tmp_asset_directory

    # copy meta file
    cp -f $metafile $tmp_asset_directory/asset.meta
    
    # make pathname file
    echo $assetfile > $tmp_asset_directory/pathname
    
    if [ ! -d $assetfile ]; then
        echo "copy file ${assetfile} to ${tmp_asset_directory}/asset"
        # copy asset file
        cp -f $assetfile $tmp_asset_directory/asset
    fi
done

(cd $tmp_directory;tar -zcvf ${abs_output_path}/SwiftPmPlugin.unitypackage .;)

rm -r $tmp_directory
