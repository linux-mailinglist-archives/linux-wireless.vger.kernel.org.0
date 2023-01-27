Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968DB67E7FF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jan 2023 15:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjA0OTE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Jan 2023 09:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjA0OTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Jan 2023 09:19:02 -0500
X-Greylist: delayed 1005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 06:19:01 PST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837747C739
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jan 2023 06:19:01 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 19B96101B3A96;
        Fri, 27 Jan 2023 15:19:00 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id DB9856029A9F;
        Fri, 27 Jan 2023 15:18:59 +0100 (CET)
X-Mailbox-Line: From 536b4f17a72ca460ad1b07045757043fb0778988 Mon Sep 17 00:00:00 2001
Message-Id: <536b4f17a72ca460ad1b07045757043fb0778988.1674827105.git.lukas@wunner.de>
In-Reply-To: <cover.1674827105.git.lukas@wunner.de>
References: <cover.1674827105.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 27 Jan 2023 15:02:00 +0100
Subject: [PATCH 2/3] wifi: mwifiex: Support SD8978 chipset
To:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Matt Ranostay <mranostay@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Marvell SD8978 (aka NXP IW416) uses identical registers as SD8987,
so reuse the existing mwifiex_reg_sd8987 definition.

Note that mwifiex_reg_sd8977 and mwifiex_reg_sd8997 are likewise
identical, save for the fw_dump_ctrl register:  They define it as 0xf0
whereas mwifiex_reg_sd8987 defines it as 0xf9.  I've verified that
0xf9 is the correct value on SD8978.  NXP's out-of-tree driver uses
0xf9 for all of them, so there's a chance that 0xf0 is not correct
in the mwifiex_reg_sd8977 and mwifiex_reg_sd8997 definitions.  I cannot
test that for lack of hardware, hence am leaving it as is.

NXP has only released a firmware which runs Bluetooth over UART.
Perhaps Bluetooth over SDIO is unsupported by this chipset.
Consequently, only an "sdiouart" firmware image is referenced, not an
alternative "sdsd" image.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .../bindings/net/wireless/marvell-8xxx.txt    |  4 ++-
 drivers/net/wireless/marvell/mwifiex/Kconfig  |  5 ++--
 drivers/net/wireless/marvell/mwifiex/sdio.c   | 25 +++++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/sdio.h   |  1 +
 include/linux/mmc/sdio_ids.h                  |  1 +
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
index 9bf9bbac16e2..cdc303caf5f4 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
@@ -1,4 +1,4 @@
-Marvell 8787/8897/8997 (sd8787/sd8897/sd8997/pcie8997) SDIO/PCIE devices
+Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
 ------
 
 This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
@@ -10,7 +10,9 @@ Required properties:
   - compatible : should be one of the following:
 	* "marvell,sd8787"
 	* "marvell,sd8897"
+	* "marvell,sd8978"
 	* "marvell,sd8997"
+	* "nxp,iw416"
 	* "pci11ab,2b42"
 	* "pci1b4b,2b42"
 
diff --git a/drivers/net/wireless/marvell/mwifiex/Kconfig b/drivers/net/wireless/marvell/mwifiex/Kconfig
index 2b4ff2b78a7e..b182f7155d66 100644
--- a/drivers/net/wireless/marvell/mwifiex/Kconfig
+++ b/drivers/net/wireless/marvell/mwifiex/Kconfig
@@ -10,13 +10,14 @@ config MWIFIEX
 	  mwifiex.
 
 config MWIFIEX_SDIO
-	tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8987/SD8997"
+	tristate "Marvell WiFi-Ex Driver for SD8786/SD8787/SD8797/SD8887/SD8897/SD8977/SD8978/SD8987/SD8997"
 	depends on MWIFIEX && MMC
 	select FW_LOADER
 	select WANT_DEV_COREDUMP
 	help
 	  This adds support for wireless adapters based on Marvell
-	  8786/8787/8797/8887/8897/8977/8987/8997 chipsets with SDIO interface.
+	  8786/8787/8797/8887/8897/8977/8978/8987/8997 chipsets with
+	  SDIO interface. SD8978 is also known as NXP IW416.
 
 	  If you choose to build it as a module, it will be called
 	  mwifiex_sdio.
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 9f506efa5370..c64e24c10ea6 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -263,7 +263,7 @@ static const struct mwifiex_sdio_card_reg mwifiex_reg_sd8887 = {
 				 0x68, 0x69, 0x6a},
 };
 
-static const struct mwifiex_sdio_card_reg mwifiex_reg_sd8987 = {
+static const struct mwifiex_sdio_card_reg mwifiex_reg_sd89xx = {
 	.start_rd_port = 0,
 	.start_wr_port = 0,
 	.base_0_reg = 0xF8,
@@ -394,6 +394,22 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.can_ext_scan = true,
 };
 
+static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
+	.firmware_sdiouart = SD8978_SDIOUART_FW_NAME,
+	.reg = &mwifiex_reg_sd89xx,
+	.max_ports = 32,
+	.mp_agg_pkt_limit = 16,
+	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_4K,
+	.mp_tx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.mp_rx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.supports_sdio_new_mode = true,
+	.has_control_mask = false,
+	.can_dump_fw = true,
+	.fw_dump_enh = true,
+	.can_auto_tdls = false,
+	.can_ext_scan = true,
+};
+
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.firmware = SD8997_DEFAULT_FW_NAME,
 	.firmware_sdiouart = SD8997_SDIOUART_FW_NAME,
@@ -428,7 +444,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.firmware = SD8987_DEFAULT_FW_NAME,
-	.reg = &mwifiex_reg_sd8987,
+	.reg = &mwifiex_reg_sd89xx,
 	.max_ports = 32,
 	.mp_agg_pkt_limit = 16,
 	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_2K,
@@ -482,7 +498,9 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 static const struct of_device_id mwifiex_sdio_of_match_table[] = {
 	{ .compatible = "marvell,sd8787" },
 	{ .compatible = "marvell,sd8897" },
+	{ .compatible = "marvell,sd8978" },
 	{ .compatible = "marvell,sd8997" },
+	{ .compatible = "nxp,iw416" },
 	{ }
 };
 
@@ -920,6 +938,8 @@ static const struct sdio_device_id mwifiex_ids[] = {
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8801},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8977},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8978_WLAN),
+		.driver_data = (unsigned long)&mwifiex_sdio_sd8978},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8987},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_WLAN),
@@ -3164,6 +3184,7 @@ MODULE_FIRMWARE(SD8797_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8897_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8887_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8977_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
 MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index 3a24bb48b299..ae94c172310f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -25,6 +25,7 @@
 #define SD8887_DEFAULT_FW_NAME "mrvl/sd8887_uapsta.bin"
 #define SD8801_DEFAULT_FW_NAME "mrvl/sd8801_uapsta.bin"
 #define SD8977_DEFAULT_FW_NAME "mrvl/sdsd8977_combo_v2.bin"
+#define SD8978_SDIOUART_FW_NAME "mrvl/sdiouartiw416_combo_v0.bin"
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
 #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
 #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 74f9d9a6d330..0e4ef9c5127a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -102,6 +102,7 @@
 #define SDIO_DEVICE_ID_MARVELL_8977_BT		0x9146
 #define SDIO_DEVICE_ID_MARVELL_8987_WLAN	0x9149
 #define SDIO_DEVICE_ID_MARVELL_8987_BT		0x914a
+#define SDIO_DEVICE_ID_MARVELL_8978_WLAN	0x9159
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
-- 
2.39.1

