
repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --git-lfs --depth=1 --no-repo-verify
/opt/crave/resync.sh 

rm -rf kernel/xiaomi/hermes device/xiaomi/hermes vendor/xiaomi/hermes 2>/dev/null
rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
rm -rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9

git clone https://github.com/kodhh/android_kernel_xiaomi_hermes.git -b lineage-16.0 --depth=1 kernel/xiaomi/hermes
git clone https://github.com/kodhh/android_device_tree_hermes.git -b lineage-17.1 --depth=1 device/xiaomi/hermes
git clone https://github.com/kodhh/android_vendor_hermes.git -b lineage-17.1 --depth=1 vendor/xiaomi/hermes

git clone --depth=1 -b lineage-19.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone --depth=1 -b lineage-19.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9

timeout 120 bash -c "device/xiaomi/hermes/patches/install.sh"

source build/envsetup.sh
breakfast hermes

make -j$(nproc) SIGN_IMAGE=1 SHOW_COMMANDS=1 -- -k 0

mka bacon
