#!/usr/bin/env bash

set -o errexit
set -o xtrace

echo "# Auto-generated" >cz_images.txt
grep -F k8s.gcr.io images.txt >>cz_images.txt

additionals='
k8s.gcr.io/cluster-proportional-autoscaler-amd64
'

for additional in $additionals; do
	if ! grep -q -m 1 "$additional" cz_images.txt; then
		echo "$additional" >>cz_images.txt
	fi
done

python3 sync_images.py \
	--registry registry.cn-beijing.aliyuncs.com \
	--namespace cz_google_containers \
	--days 7 \
	--file cz_images.txt \
