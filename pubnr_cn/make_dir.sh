#!/bin/bash

# 基础路径
base_path='/home/asuka/mxy_homeworks/A10/pubnr_cn/test_dir'

# 每个文件夹中的文件数量
files_per_folder=100

# 每个上级目录中的文件夹数量
folders_per_directory=100

# 读取专利号文件
mapfile -t patent_numbers < pubnr_cn.txt

# 计算总文件数
total_files=${#patent_numbers[@]}

# 计算总文件夹数
total_folders=$(( (total_files + files_per_folder - 1) / files_per_folder ))

# 计算总上级目录数
total_directories=$(( (total_folders + folders_per_directory - 1) / folders_per_directory ))

# 创建文件夹和文件
file_index=0
for (( directory_index=0; directory_index<total_directories; directory_index++ )); do
    directory_path="${base_path}/directory_${directory_index}"
    mkdir -p "${directory_path}"

    for (( folder_index=0; folder_index<folders_per_directory; folder_index++ )); do
        folder_path="${directory_path}/folder_$(printf "%03d" $((directory_index*folders_per_directory+folder_index)))"
        mkdir -p "${folder_path}"

        for (( file_count=0; file_count<files_per_folder; file_count++ )); do
            if (( file_index < total_files )); then
                patent_number=${patent_numbers[file_index]}
                file_name="${folder_path}/patent_${patent_number}.txt"
                echo "${patent_number}" > "${file_name}"
                file_index=$((file_index + 1))
            fi
        done
    done
done

