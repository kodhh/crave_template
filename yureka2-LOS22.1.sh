crave_repo_sync
rm -rf kernel/yu/YUREKA2 device/yu/YUREKA2 vendor/yu/YUREKA2 2>/dev/null
rm -rf hardware/qcom-caf/msm8953/audio hardware/qcom-caf/msm8953/display hardware/qcom-caf/msm8953/media 2>/dev/null

git clone https://github.com/kodhh/android_kernel_YUREKA2-4.19.git --depth=1 kernel/yu/YUREKA2
git clone https://github.com/kodhh/device-yureka2.git --depth=1 device/yu/YUREKA2
git clone https://github.com/kodhh/vendor-yureka2.git --depth=1 vendor/yu/YUREKA2
git clone https://github.com/kodhh/android_hardware_qcom_audio_mithorium.git --depth=1 hardware/qcom-caf/msm8953/audio
git clone https://github.com/kodhh/android_hardware_qcom_display_mithorium.git --depth=1 hardware/qcom-caf/msm8953/display
git clone https://github.com/kodhh/android_hardware_qcom_media_mithorium.git --depth=1 hardware/qcom-caf/msm8953/media

cd frameworks/base
curl -sLo fw.patch https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/android_frameworks_base-Android14.patch
patch -p1 -N -r - < fw.patch || echo "fw.patch already applied"
curl -sLo ub.patch https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/android_frameworks_base-user_build.patch
patch -p1 -N -r - < ub.patch || echo "ub.patch already applied"
rm -f *.patch
cd ../..

cd packages/modules/Permission
curl -sLo perm.patch https://raw.githubusercontent.com/lineageos4microg/docker-lineage-cicd/master/src/signature_spoofing_patches/packages_modules_Permission-Android14.patch
patch -p1 -N -r - < perm.patch || echo "perm.patch already applied"
rm -f *.patch
cd ../../..

export WITH_GMS=true
source build/envsetup.sh
breakfast YUREKA2 userdebug
mka bacon
