Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E0B7DB62D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjJ3JcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJ3JcX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 05:32:23 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6EBC4
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 02:32:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1215:0:640:367b:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id DAD7D60AED;
        Mon, 30 Oct 2023 12:32:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EWQQNA6DUSw0-BRe2DDJp;
        Mon, 30 Oct 2023 12:32:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698658337; bh=9U74dTZV9EOFKxU3Al8IIZSSCL/xRv+HZwoFW5t+dhc=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=E3lQ5ixJOhkAd67fzSsA9BqjJrPEQsCdHlni+tQhhTC36fofAOJhy0V1vT/lllPXZ
         Pn6tPN4Q3MKaFlORnFzCMEvbWIAi4ek6gcOEq1iBXBw6QGsBHUA0Dpi3wl3XTrtfFY
         tPdrhyCZVNOAetE1GkuSmG/lo7Y+LkKlJR7c+/xI=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtw88: simplify config_{tx_path,txrx_mode} of struct rtw_chip_ops
Date:   Mon, 30 Oct 2023 12:31:39 +0300
Message-ID: <20231030093144.82504-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030093144.82504-1-dmantipov@yandex.ru>
References: <20231030093144.82504-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 4th argument of '(*config_tx_path)()' and '(*config_txrx_mode)()'
from 'struct rtw_chip_ops' is a hardcoded false, drop it and adjust
chip-specific code for rtw8822b and rtw8822c (including renaming from
presumably misspelled 'rtwxxxx_config_trx_mode()' to more suitable
'rtwxxxx_config_txrx_mode()') accordingly.

Briefly tested on the following USB dongle:

usb 3-6: new high-speed USB device number 7 using xhci_hcd
usb 3-6: New USB device found, idVendor=0bda, idProduct=b812, bcdDevice=2.10
usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-6: Product: USB3.0 802.11ac 1200M Adapter
usb 3-6: Manufacturer: Realtek
usb 3-6: SerialNumber: 123456
rtw_8822bu 3-6:1.0: Firmware version 27.2.0, H2C version 13
usbcore: registered new interface driver rtw_8822bu

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/main.c     |  4 +--
 drivers/net/wireless/realtek/rtw88/main.h     |  5 ++-
 drivers/net/wireless/realtek/rtw88/phy.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 17 ++++------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 33 +++++++------------
 5 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4ea2f09709b0..4f837209e67d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1700,10 +1700,10 @@ void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool txrx_1ss)
 
 	rtwdev->hal.txrx_1ss = txrx_1ss;
 	if (txrx_1ss)
-		chip->ops->config_txrx_mode(rtwdev, BB_PATH_A, BB_PATH_A, false);
+		chip->ops->config_txrx_mode(rtwdev, BB_PATH_A, BB_PATH_A);
 	else
 		chip->ops->config_txrx_mode(rtwdev, hal->antenna_tx,
-					    hal->antenna_rx, false);
+					    hal->antenna_rx);
 	rtw_iterate_vifs_atomic(rtwdev, rtw_vif_smps_iter, rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 835898a170df..03f18653e636 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -879,10 +879,9 @@ struct rtw_chip_ops {
 	void (*cfo_track)(struct rtw_dev *rtwdev);
 	void (*config_tx_path)(struct rtw_dev *rtwdev, u8 tx_path,
 			       enum rtw_bb_path tx_path_1ss,
-			       enum rtw_bb_path tx_path_cck,
-			       bool is_tx2_path);
+			       enum rtw_bb_path tx_path_cck);
 	void (*config_txrx_mode)(struct rtw_dev *rtwdev, u8 tx_path,
-				 u8 rx_path, bool is_tx2_path);
+				 u8 rx_path);
 	/* for USB/SDIO only */
 	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
 				     struct rtw_tx_pkt_info *pkt_info,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 128e75a81bf3..49efc519e9a6 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2488,7 +2488,7 @@ static void rtw_phy_set_tx_path_by_reg(struct rtw_dev *rtwdev,
 	rtw_dbg(rtwdev, RTW_DBG_PATH_DIV, "Switch TX path=%s\n",
 		tx_path_sel_1ss == BB_PATH_A ? "A" : "B");
 	chip->ops->config_tx_path(rtwdev, rtwdev->hal.antenna_tx,
-				  tx_path_sel_1ss, tx_path_sel_cck, false);
+				  tx_path_sel_1ss, tx_path_sel_cck);
 }
 
 static void rtw_phy_tx_path_div_select(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3017a9760da8..8631b24e9123 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -17,8 +17,8 @@
 #include "bf.h"
 #include "regd.h"
 
-static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
-				     u8 rx_path, bool is_tx2_path);
+static void rtw8822b_config_txrx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+				      u8 rx_path);
 
 static void rtw8822be_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8822b_efuse *map)
@@ -152,7 +152,6 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 crystal_cap;
-	bool is_tx2_path;
 
 	/* power on BB/RF domain */
 	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN,
@@ -173,9 +172,7 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 	/* post init after header files config */
 	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
 
-	is_tx2_path = false;
-	rtw8822b_config_trx_mode(rtwdev, hal->antenna_tx, hal->antenna_rx,
-				 is_tx2_path);
+	rtw8822b_config_txrx_mode(rtwdev, hal->antenna_tx, hal->antenna_rx);
 	rtw_phy_init(rtwdev);
 
 	rtw8822b_phy_rfe_init(rtwdev);
@@ -734,8 +731,8 @@ static void rtw8822b_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	(*rfe_info->rtw_set_channel_rfe)(rtwdev, channel);
 }
 
-static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
-				     u8 rx_path, bool is_tx2_path)
+static void rtw8822b_config_txrx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+				      u8 rx_path)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	const struct rtw8822b_rfe_info *rfe_info;
@@ -780,7 +777,7 @@ static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 	rtw_write32_mask(rtwdev, REG_TXPSEL, MASKBYTE0, tx_path_sel);
 
 	if (tx_path != BB_PATH_A && tx_path != BB_PATH_B) {
-		if (is_tx2_path || rtwdev->mp_mode) {
+		if (rtwdev->mp_mode) {
 			rtw_write32_mask(rtwdev, REG_CDDTXP, 0xfff00000, 0x043);
 			rtw_write32_mask(rtwdev, REG_ADCINI, 0xf0000000, 0xc);
 		}
@@ -1042,7 +1039,7 @@ static int rtw8822b_set_antenna(struct rtw_dev *rtwdev,
 	hal->antenna_tx = antenna_tx;
 	hal->antenna_rx = antenna_rx;
 
-	rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+	rtw8822b_config_txrx_mode(rtwdev, antenna_tx, antenna_rx);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cd965edc29ce..a5586e8991d4 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -20,8 +20,8 @@
 
 #define IQK_DONE_8822C 0xaa
 
-static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
-				     u8 rx_path, bool is_tx2_path);
+static void rtw8822c_config_txrx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+				      u8 rx_path);
 
 static void rtw8822ce_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8822c_efuse *map)
@@ -1868,7 +1868,6 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 	u8 cck_gi_u_bnd_lsb = 0;
 	u8 cck_gi_l_bnd_msb = 0;
 	u8 cck_gi_l_bnd_lsb = 0;
-	bool is_tx2_path;
 
 	/* power on BB/RF domain */
 	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN,
@@ -1892,9 +1891,7 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 	/* post init after header files config */
 	rtw8822c_header_file_init(rtwdev, false);
 
-	is_tx2_path = false;
-	rtw8822c_config_trx_mode(rtwdev, hal->antenna_tx, hal->antenna_rx,
-				 is_tx2_path);
+	rtw8822c_config_txrx_mode(rtwdev, hal->antenna_tx, hal->antenna_rx);
 	rtw_phy_init(rtwdev);
 
 	cck_gi_u_bnd_msb = (u8)rtw_read32_mask(rtwdev, 0x1a98, 0xc000);
@@ -2475,18 +2472,14 @@ static void rtw8822c_config_rx_path(struct rtw_dev *rtwdev, u8 rx_path)
 	rtw8822c_config_ofdm_rx_path(rtwdev, rx_path);
 }
 
-static void rtw8822c_config_cck_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
-					bool is_tx2_path)
+static void rtw8822c_config_cck_tx_path(struct rtw_dev *rtwdev, u8 tx_path)
 {
 	if (tx_path == BB_PATH_A) {
 		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
 	} else if (tx_path == BB_PATH_B) {
 		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x4);
 	} else {
-		if (is_tx2_path)
-			rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0xc);
-		else
-			rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
+		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
 	}
 	rtw8822c_bb_reset(rtwdev);
 }
@@ -2517,16 +2510,15 @@ static void rtw8822c_config_ofdm_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
 
 static void rtw8822c_config_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
 				    enum rtw_bb_path tx_path_sel_1ss,
-				    enum rtw_bb_path tx_path_cck,
-				    bool is_tx2_path)
+				    enum rtw_bb_path tx_path_cck)
 {
-	rtw8822c_config_cck_tx_path(rtwdev, tx_path_cck, is_tx2_path);
+	rtw8822c_config_cck_tx_path(rtwdev, tx_path_cck);
 	rtw8822c_config_ofdm_tx_path(rtwdev, tx_path, tx_path_sel_1ss);
 	rtw8822c_bb_reset(rtwdev);
 }
 
-static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
-				     u8 rx_path, bool is_tx2_path)
+static void rtw8822c_config_txrx_mode(struct rtw_dev *rtwdev, u8 tx_path,
+				      u8 rx_path)
 {
 	if ((tx_path | rx_path) & BB_PATH_A)
 		rtw_write32_mask(rtwdev, REG_ORITXCODE, MASK20BITS, 0x33312);
@@ -2538,8 +2530,7 @@ static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 		rtw_write32_mask(rtwdev, REG_ORITXCODE2, MASK20BITS, 0x11111);
 
 	rtw8822c_config_rx_path(rtwdev, rx_path);
-	rtw8822c_config_tx_path(rtwdev, tx_path, BB_PATH_A, BB_PATH_A,
-				is_tx2_path);
+	rtw8822c_config_tx_path(rtwdev, tx_path, BB_PATH_A, BB_PATH_A);
 
 	rtw8822c_toggle_igi(rtwdev);
 }
@@ -2833,7 +2824,7 @@ static int rtw8822c_set_antenna(struct rtw_dev *rtwdev,
 	hal->antenna_tx = antenna_tx;
 	hal->antenna_rx = antenna_rx;
 
-	rtw8822c_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+	rtw8822c_config_txrx_mode(rtwdev, antenna_tx, antenna_rx);
 
 	return 0;
 }
@@ -5009,7 +5000,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.cfo_init		= rtw8822c_cfo_init,
 	.cfo_track		= rtw8822c_cfo_track,
 	.config_tx_path		= rtw8822c_config_tx_path,
-	.config_txrx_mode	= rtw8822c_config_trx_mode,
+	.config_txrx_mode	= rtw8822c_config_txrx_mode,
 	.fill_txdesc_checksum	= rtw8822c_fill_txdesc_checksum,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
-- 
2.41.0

