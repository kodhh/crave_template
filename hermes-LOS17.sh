if [ -d "device/xiaomi/hermes" ]; then
		pwdir=$(pwd)
		rm -rf external/chromium-webview/prebuilt/arm external/chromium-webview/prebuilt/arm64 external/chromium-webview/prebuilt/x86 external/chromium-webview/prebuilt/x86_64
		rm -rf out/target/product/hermes/obj/APPS/webview_intermediates
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86_64 external/chromium-webview/prebuilt/x86_64 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86 external/chromium-webview/prebuilt/x86 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm64 external/chromium-webview/prebuilt/arm64 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm external/chromium-webview/prebuilt/arm --depth=1
		rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
		rm -rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
		git clone --depth=1 -b lineage-17.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
		git clone --depth=1 -b lineage-17.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
        cd device/xiaomi/hermes
        git pull https://github.com/kodhh/android_device_tree_hermes.git lineage-17.1
        git reset f3b84a459b88a32d3daf690a3e70380f0956a57b --hard
		cd "$pwdir"
		timeout 120 bash -c "device/xiaomi/hermes/patches2/install.sh"
else
		repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --git-lfs --no-repo-verify
		rm -rf external/libmojo external/libchrome external/nos prebuilts/clang/host/darwin-x86 prebuilts/clang/host/linux-x86 prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 prebuilts/gcc/linux-x86/host/x86_64-w64-mingw32-4.8 prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9 prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
		rm -rf kernel/xiaomi/hermes device/xiaomi/hermes vendor/xiaomi/hermes 2>/dev/null
		rm -rf prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
		rm -rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9

		/opt/crave/resync.sh

		rm -rf external/chromium-webview/prebuilt/arm external/chromium-webview/prebuilt/arm64 external/chromium-webview/prebuilt/x86 external/chromium-webview/prebuilt/x86_64
		rm -rf out/target/product/hermes/obj/APPS/webview_intermediates
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86_64 external/chromium-webview/prebuilt/x86_64 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_x86 external/chromium-webview/prebuilt/x86 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm64 external/chromium-webview/prebuilt/arm64 --depth=1
		git clone https://github.com/LineageOS/android_external_chromium-webview_prebuilt_arm external/chromium-webview/prebuilt/arm --depth=1

		git clone https://github.com/kodhh/android_kernel_xiaomi_hermes.git -b lineage-16.0 --depth=1 kernel/xiaomi/hermes
		git clone https://github.com/kodhh/android_device_tree_hermes.git -b lineage-17.1 --depth=1 device/xiaomi/hermes
		git clone https://github.com/kodhh/android_vendor_hermes.git -b lineage-17.1 --depth=1 vendor/xiaomi/hermes
		git clone --depth=1 -b lineage-17.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
		git clone --depth=1 -b lineage-17.1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9

		timeout 120 bash -c "device/xiaomi/hermes/patches/install.sh"
		timeout 120 bash -c "device/xiaomi/hermes/patches2/install.sh"

fi

source build/envsetup.sh
breakfast hermes
make -j$(nproc) SHOW_COMMANDS=1 -k bacon
