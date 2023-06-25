catalogs=$1
subcatalogs_first=$2
subcatalogs_second=$3
files=$4

create_catalogs () {
    for (( catalog=1; catalog <= $catalogs; catalog++ ))
    do
        if [ $(($catalog % 2)) -gt 0 ]
        then
            continue
        fi
        
        if [ -d $catalog ]
        then
            rm -r $catalog
        fi
        
        mkdir $catalog
        
        for (( subcatalog_first=1; subcatalog_first <= $subcatalogs_first; subcatalog_first++ ))
        do
            if [ $(($subcatalog_first % 2)) -gt 0 ]
            then
                continue
            fi
            
            cd $catalog
            mkdir $subcatalog_first
            for (( subcatalog_second=1; subcatalog_second <= $subcatalogs_second; subcatalog_second++ ))
            do
                if [ $(($subcatalog_second % 2)) -gt 0 ]
                then
                    continue
                fi
                
                cd $subcatalog_first
                mkdir $subcatalog_second
                for (( file=0; file <= $files; file++ ))
                do
                    if [ $(($file % 2)) -eq 0 ]
                    then
                        continue
                    fi
                    
                    cd $subcatalog_second
                    touch $file
                done
                
                cd "../.."
            done
            
            cd ".."
        done
    done
}

create_catalogs