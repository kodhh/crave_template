rm -rf .repo/local_manifests

repo init -u https://github.com/LineageOS/android.git -b lineage-22.2 --git-lfs --depth=1 --no-repo-verify

mkdir -p .repo/local_manifests

curl -sL https://raw.githubusercontent.com/kodhh/crave_template/refs/heads/master/yureka2_roomservice.xml -o .repo/local_manifests/roomservice.xml

# Sync the repositories
if [ -f /usr/bin/resync ]
 then
  /usr/bin/resync # For compatibility with Omansh's Docker image 
else
  /opt/crave/resync.sh
fi

source build/envsetup.sh

breakfast YUREKA2 userdebug

mka bacon
