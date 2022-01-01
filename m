Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A0748286B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jan 2022 21:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiAAU1e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jan 2022 15:27:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiAAU1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jan 2022 15:27:33 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MK3mS-1mq4fg1juI-00LTZn; Sat, 01 Jan 2022 21:27:18 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 3/4] ARM: dts: Add Raspberry Pi Zero 2 W
Date:   Sat,  1 Jan 2022 21:26:51 +0100
Message-Id: <1641068812-5851-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
References: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:Ugrnq3amehdAgqqPE2x4fooxljBnrwEoKjV2c9w9SvlkLmFrD6e
 KxgeYJ+EcN+8ZGBaHFFFL/dxKt5/k/IVfZuvll5uHNREtKEEnxVcQLuLcDcljb1EiKDCXV+
 sN6nA4Cmw+0y7cLS6Urs6VkvdxeLyxB5AYtxGLXxdIqra4cSTkpxdieVhq7aPeW59l5j8HD
 5eWYHkk22/qqlB65KFWkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GftqFuhLOA=:CmWLUwUBkzm4jDzmS7HfDx
 zD+7dbhGIbefbiotjdiE4fcLXzdb/dSLDGFC6fHkl+iuYIEQE48xU/ECZLVCxQ74cmZOioMs/
 tG+KdKh+9TGPpWPTdBwqgNfZZ/YbsRmHq3bq8xZqea4Ogpy4G4GycfmblkWMAGXrFLWrG+Wb9
 Eamf1eoQZKCRmXzNXnoD0OMuJVqQXcfqwq1zH4hwbsZ/5u6j+lM228xxmUNLvFMEmEHbQcnpj
 mDSbnvT5/FmM7bJfFZvmVBAe/jXG40bhFqAL0YVGJokHRwyPYjyZDFMVHw6EIxyr1Zx0pGReI
 vUuJJr8TdROUtAUhqNPdpl1pEH1A7idihAQOuIlSuuH98Kr0n5DWYkdg4OHp2sApYJQbHc1sJ
 5Z6WoQaOKVoJ3XGIw9cqg7xE40qucQ1CqJdY/JaIalYEzaFuO0cw8FrHQitZwaO9hjJnG7l5T
 ThGa45iSdkjHmjIVUXML1m449i3SSJod3IN6gzr0Eh6o7byCA+u3JLMTKeoP3epGkEb6YW8FW
 +5UWNo+LTUqudxFdJtFxotdfZ9nHihG5kCbi8cNnkhd/voxe6m2deCZVfdhKBBQgX1XKUCNCi
 cFBVUm+KRewBlQtVTtbritCiZEGysnHJVeOoiFrScSEUmz6JxiuCJ3ZwO59jCGwEy5Kv/mVJx
 dvI5a565RO1J6hY9VqtBbL9qNbUB85uBDC4BRDCRRAbMFJ+sJqogDufb4FLKk78TMaKkpBiCf
 fSiNGwbC3C9ECP0P
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Raspberry Pi Zero 2 W mostly bases on the Raspberry Pi Zero W with
the following differences:
* Broadcom BCM2710A1, quad-core 64-bit SoC @ 1 GHz
* Synaptics BCM43436, 2.4GHz IEEE 802.11b/g/n wireless LAN

Contrary to the Raspberry Pi 3 boards there is no GPIO expander.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts | 136 +++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e41eca7..3d5785a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -93,6 +93,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2837-rpi-3-b.dtb \
 	bcm2837-rpi-3-b-plus.dtb \
 	bcm2837-rpi-cm3-io3.dtb \
+	bcm2837-rpi-zero-2-w.dtb \
 	bcm2711-rpi-400.dtb \
 	bcm2711-rpi-4-b.dtb \
 	bcm2711-rpi-cm4-io.dtb \
diff --git a/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts b/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
new file mode 100644
index 0000000..60e6880
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Stefan Wahren <stefan.wahren@i2se.com>
+ */
+
+/dts-v1/;
+#include "bcm2837.dtsi"
+#include "bcm2836-rpi.dtsi"
+#include "bcm283x-rpi-usb-otg.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
+
+/ {
+	compatible = "raspberrypi,model-zero-2-w", "brcm,bcm2837";
+	model = "Raspberry Pi Zero 2 W";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x20000000>;
+	};
+
+	chosen {
+		/* 8250 auxiliary UART instead of pl011 */
+		stdout-path = "serial1:115200n8";
+	};
+
+	leds {
+		led-act {
+			gpios = <&gpio 29 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&bt {
+	shutdown-gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
+};
+
+&gpio {
+	/*
+	 * This is based on the official GPU firmware DT blob.
+	 *
+	 * Legend:
+	 * "NC" = not connected (no rail from the SoC)
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
+			  "SDA1",
+			  "SCL1",
+			  "GPIO_GCLK",
+			  "GPIO5",
+			  "GPIO6",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "GPIO12",
+			  "GPIO13",
+			  /* Serial port */
+			  "TXD0",
+			  "RXD0",
+			  "GPIO16",
+			  "GPIO17",
+			  "GPIO18",
+			  "GPIO19",
+			  "GPIO20",
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "GPIO26",
+			  "GPIO27",
+			  "HDMI_HPD_N",
+			  "STATUS_LED_N",
+			  "NC", /* GPIO30 */
+			  "NC", /* GPIO31 */
+			  "NC", /* GPIO32 */
+			  "NC", /* GPIO33 */
+			  "NC", /* GPIO34 */
+			  "NC", /* GPIO35 */
+			  "NC", /* GPIO36 */
+			  "NC", /* GPIO37 */
+			  "NC", /* GPIO38 */
+			  "NC", /* GPIO39 */
+			  "CAM_GPIO0", /* GPIO40 */
+			  "WL_ON", /* GPIO41 */
+			  "BT_ON", /* GPIO42 */
+			  "WIFI_CLK", /* GPIO43 */
+			  "SDA0", /* GPIO44 */
+			  "SCL0", /* GPIO45 */
+			  "SMPS_SCL",
+			  "SMPS_SDA",
+			  /* Used by SD Card */
+			  "SD_CLK_R",
+			  "SD_CMD_R",
+			  "SD_DATA0_R",
+			  "SD_DATA1_R",
+			  "SD_DATA2_R",
+			  "SD_DATA3_R";
+
+	pinctrl-0 = <&gpioout &alt0>;
+};
+
+&hdmi {
+	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
+};
+
+&sdhci {
+	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
+};
+
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_gpio14>;
+	status = "okay";
+};
+
+&wifi_pwrseq {
+	reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4

