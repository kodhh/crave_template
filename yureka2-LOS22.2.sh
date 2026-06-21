repo init -u https://github.com/LineageOS/android.git -b lineage-22.2 --depth=1 --git-lfs

rm -rf .repo/local_manifests/* kernel/yu/YUREKA2 device/yu/YUREKA2 vendor/yu/YUREKA2 hardware/qcom-caf/msm8953/audio hardware/qcom-caf/msm8953/display hardware/qcom-caf/msm8953/media 2>/dev/null

mkdir -p .repo/local_manifests

curl -sL https://raw.githubusercontent.com/kodhh/crave_template/refs/heads/master/yureka2_roomservice.xml -o .repo/local_manifests/roomservice.xml

/opt/crave/resync.sh

source build/envsetup.sh
breakfast YUREKA2 userdebug
mka bacon
