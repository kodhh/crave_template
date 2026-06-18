/tmp/src/android

rm -rf kernel/yu/YUREKA2 device/yu/YUREKA2 vendor/yu/YUREKA2 2>/dev/null
rm -rf hardware/qcom-caf/msm8953/audio hardware/qcom-caf/msm8953/display hardware/qcom-caf/msm8953/media 2>/dev/null

git clone https://github.com/kodhh/android_kernel_YUREKA2-4.19.git -b lineageos-22.2 --depth=1 kernel/yu/YUREKA2
git clone https://github.com/kodhh/device-yureka2.git -b lineageos-22.2 --depth=1 device/yu/YUREKA2
git clone https://github.com/kodhh/vendor-yureka2.git -b lineageos-22.2 --depth=1 vendor/yu/YUREKA2
git clone https://github.com/kodhh/android_hardware_qcom_audio_mithorium.git -b master --depth=1 hardware/qcom-caf/msm8953/audio
git clone https://github.com/kodhh/android_hardware_qcom_display_mithorium.git -b master --depth=1 hardware/qcom-caf/msm8953/display
git clone https://github.com/kodhh/android_hardware_qcom_media_mithorium.git --depth=1 hardware/qcom-caf/msm8953/media


source build/envsetup.sh
breakfast YUREKA2 userdebug
mka bacon
