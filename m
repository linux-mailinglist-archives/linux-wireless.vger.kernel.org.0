Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4125F8B64
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJIMy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiJIMyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F48C11
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299Cs1kmD029532, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299Cs1kmD029532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:54:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:54:29 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/9] wifi: rtw89: 8852b: add chip_ops to configure TX/RX path
Date:   Sun, 9 Oct 2022 20:54:01 +0800
Message-ID: <20221009125403.19662-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009125403.19662-1-pkshih@realtek.com>
References: <20221009125403.19662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.215]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/09/2022 12:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzkgpFekyCAwOTowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To support variant models, such as 1x1 or 1T2R, we need this chip_ops to
change the path accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 112 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |   3 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 570fb1aee80c3..5482e32a72d55 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3666,6 +3666,8 @@
 #define B_P0_RFMODE_MUX GENMASK(11, 4)
 #define R_P0_RFMODE_ORI_RX 0x12AC
 #define B_P0_RFMODE_ORI_RX_ALL GENMASK(23, 12)
+#define R_P0_RFMODE_FTM_RX 0x12B0
+#define B_P0_RFMODE_FTM_RX GENMASK(11, 0)
 #define R_P0_NRBW 0x12B8
 #define B_P0_NRBW_DBG BIT(30)
 #define R_S0_RXDC 0x12D4
@@ -3779,6 +3781,8 @@
 #define B_P1_RFMODE_MUX GENMASK(11, 4)
 #define R_P1_RFMODE_ORI_RX 0x32AC
 #define B_P1_RFMODE_ORI_RX_ALL GENMASK(23, 12)
+#define R_P1_RFMODE_FTM_RX 0x32B0
+#define B_P1_RFMODE_FTM_RX GENMASK(11, 0)
 #define R_P1_DBGMOD 0x32B8
 #define B_P1_DBGMOD_ON BIT(30)
 #define R_S1_RXDC 0x32D4
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index abb35553a2b04..a5156d7aca5b8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1484,6 +1484,117 @@ static void rtw8852b_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 	}
 }
 
+void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
+			      enum rtw89_rf_path_bit rx_path)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u32 rst_mask0;
+	u32 rst_mask1;
+
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else if (rx_path == RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 2);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 2);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 2);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else if (rx_path == RF_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, 3);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG0, 3);
+		rtw89_phy_write32_mask(rtwdev, R_FC0_BW_V1, B_ANT_RX_1RCCA_SEG1, 3);
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_USER_MAX, 4);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
+	}
+
+	rtw8852b_set_gain_offset(rtwdev, chan->subband_type, RTW89_PHY_0);
+
+	if (chan->band_type == RTW89_BAND_2G &&
+	    (rx_path == RF_B || rx_path == RF_AB))
+		rtw8852b_ctrl_btg(rtwdev, true);
+	else
+		rtw8852b_ctrl_btg(rtwdev, false);
+
+	rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
+	rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB, rst_mask0, 3);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 1);
+		rtw89_phy_write32_mask(rtwdev, R_P1_TXPW_RSTB, rst_mask1, 3);
+	}
+}
+
+static void rtw8852b_bb_ctrl_rf_mode_rx_path(struct rtw89_dev *rtwdev,
+					     enum rtw89_rf_path_bit rx_path)
+{
+	if (rx_path == RF_A) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x333);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x111);
+	} else if (rx_path == RF_B) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1111111);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x111);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x333);
+	} else if (rx_path == RF_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE,
+				       B_P0_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P0_RFMODE_FTM_RX,
+				       B_P0_RFMODE_FTM_RX, 0x333);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE,
+				       B_P1_RFMODE_ORI_TXRX_FTM_TX, 0x1233312);
+		rtw89_phy_write32_mask(rtwdev, R_P1_RFMODE_FTM_RX,
+				       B_P1_RFMODE_FTM_RX, 0x333);
+	}
+}
+
+static void rtw8852b_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	enum rtw89_rf_path_bit rx_path = hal->antenna_rx ? hal->antenna_rx : RF_AB;
+
+	rtw8852b_bb_ctrl_rx_path(rtwdev, rx_path);
+	rtw8852b_bb_ctrl_rf_mode_rx_path(rtwdev, rx_path);
+
+	if (rtwdev->hal.rx_nss == 1) {
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 0);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_RXHT_MCS_LIMIT, B_RXHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXVHT_MCS_LIMIT, B_RXVHT_MCS_LIMIT, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHE_MAX_NSS, 1);
+		rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS, 1);
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0x0, RTW89_PHY_0);
+}
+
 static u8 rtw8852b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 {
 	if (rtwdev->is_tssi_mode[rf_path]) {
@@ -1808,6 +1919,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.ctrl_btg		= rtw8852b_ctrl_btg,
 	.query_ppdu		= rtw8852b_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8852b_bb_ctrl_btc_preagc,
+	.cfg_txrx_path		= rtw8852b_bb_cfg_txrx_path,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
index bc0a383c4a390..33f621014e497 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -87,4 +87,7 @@ struct rtw8852b_efuse {
 
 extern const struct rtw89_chip_info rtw8852b_chip_info;
 
+void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
+			      enum rtw89_rf_path_bit rx_path);
+
 #endif
-- 
2.25.1

