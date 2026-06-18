cd /tmp/src/android
rm -r /tmp/src/android/.repo
repo init -u https://github.com/LineageOS-Revived/android.git -b lineage-17.1 --git-lfs
repo sync

rm -rf kernel/xiaomi/hermes device/xiaomi/hermes vendor/xiaomi/hermes 2>/dev/null

git clone https://github.com/kodhh/android_kernel_xiaomi_hermes.git -b lineage-16.0 --depth=1 kernel/xiaomi/hermes
git clone https://github.com/kodhh/android_device_tree_hermes.git -b lineage-17.1 --depth=1 device/xiaomi/hermes
git clone https://github.com/kodhh/android_vendor_hermes.git -b lineage-17.1 --depth=1 vendor/xiaomi/hermes

# Apply device tree patches (MTK HAL, bionic, etc.)
device/xiaomi/hermes/patches/install.sh

cd frameworks/base
curl -sLo q.patch https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/android_frameworks_base-Q.patch
patch -p1 -N -r - < q.patch || echo "q.patch already applied"
curl -sLo ub.patch https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/android_frameworks_base-user_build.patch
patch -p1 -N -r - < ub.patch || echo "ub.patch already applied"
rm -f *.patch
cd ../..

source build/envsetup.sh
breakfast hermes userdebug
mka bacon
