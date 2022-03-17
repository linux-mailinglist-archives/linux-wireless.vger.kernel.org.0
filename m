Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B04DBF1F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiCQGSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCQGRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:17:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BB1D78A8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5uog17009822, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5uog17009822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 17 Mar 2022 13:56:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 09/12] rtw89: 8852c: add mac_ctrl_path and mac_cfg_gnt APIs
Date:   Thu, 17 Mar 2022 13:55:40 +0800
Message-ID: <20220317055543.40514-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317055543.40514-1-pkshih@realtek.com>
References: <20220317055543.40514-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

The BT-coexistence uses these function to control antenna and TDMA, so
implement the variant type to support all chips.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 24 +++----
 drivers/net/wireless/realtek/rtw89/core.h     | 19 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 70 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  3 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 25 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 7 files changed, 133 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 07f26718b66fb..7b4065724cd3e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1478,7 +1478,7 @@ static void _set_gnt_wl(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
 		}
 	}
 
-	rtw89_mac_cfg_gnt(rtwdev, &dm->gnt);
+	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
 }
 
 #define BTC_TDMA_WLROLE_MAX 2
@@ -2233,7 +2233,7 @@ static void _set_gnt_bt(struct rtw89_dev *rtwdev, u8 phy_map, u8 state)
 		}
 	}
 
-	rtw89_mac_cfg_gnt(rtwdev, &dm->gnt);
+	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
 }
 
 static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map,
@@ -2300,7 +2300,7 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 
 	switch (type) {
 	case BTC_ANT_WPOWERON:
-		rtw89_mac_cfg_ctrl_path(rtwdev, false);
+		rtw89_chip_cfg_ctrl_path(rtwdev, false);
 		break;
 	case BTC_ANT_WINIT:
 		if (bt->enable.now) {
@@ -2310,21 +2310,21 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 			_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
 			_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
 		}
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_BT, BTC_PLT_BT);
 		break;
 	case BTC_ANT_WONLY:
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_WOFF:
-		rtw89_mac_cfg_ctrl_path(rtwdev, false);
+		rtw89_chip_cfg_ctrl_path(rtwdev, false);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_W2G:
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		if (rtwdev->dbcc_en) {
 			for (i = 0; i < RTW89_PHY_MAX; i++) {
 				b2g = (wl_dinfo->real_band[i] == RTW89_BAND_2G);
@@ -2352,32 +2352,32 @@ static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
 		}
 		break;
 	case BTC_ANT_W5G:
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_HW);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_W25G:
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_HW);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_HW);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL,
 			     BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
 		break;
 	case BTC_ANT_FREERUN:
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_WRFK:
-		rtw89_mac_cfg_ctrl_path(rtwdev, true);
+		rtw89_chip_cfg_ctrl_path(rtwdev, true);
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_LO);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
 		break;
 	case BTC_ANT_BRFK:
-		rtw89_mac_cfg_ctrl_path(rtwdev, false);
+		rtw89_chip_cfg_ctrl_path(rtwdev, false);
 		_set_gnt_wl(rtwdev, phy_map, BTC_GNT_SW_LO);
 		_set_gnt_bt(rtwdev, phy_map, BTC_GNT_SW_HI);
 		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 95f105232e807..08416f005b508 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2068,6 +2068,9 @@ struct rtw89_chip_ops {
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
+	int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
+	int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
+			   const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
@@ -3467,6 +3470,22 @@ static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 		chip->ops->ctrl_btg(rtwdev, btg);
 }
 
+static inline
+void rtw89_chip_mac_cfg_gnt(struct rtw89_dev *rtwdev,
+			    const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->mac_cfg_gnt(rtwdev, gnt_cfg);
+}
+
+static inline void rtw89_chip_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->cfg_ctrl_path(rtwdev, wl);
+}
+
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 {
 	__le16 fc = hdr->frame_control;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e52b0e7b53829..d68eb3126d8ae 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3652,6 +3652,54 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw89_mac_cfg_gnt);
+
+int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
+{
+	u32 val = 0;
+
+	if (gnt_cfg->band[0].gnt_bt)
+		val |= B_AX_GNT_BT_RFC_S0_VAL | B_AX_GNT_BT_RX_VAL |
+		       B_AX_GNT_BT_TX_VAL;
+	else
+		val |= B_AX_WL_ACT_VAL;
+
+	if (gnt_cfg->band[0].gnt_bt_sw_en)
+		val |= B_AX_GNT_BT_RFC_S0_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
+		       B_AX_GNT_BT_TX_SWCTRL | B_AX_WL_ACT_SWCTRL;
+
+	if (gnt_cfg->band[0].gnt_wl)
+		val |= B_AX_GNT_WL_RFC_S0_VAL | B_AX_GNT_WL_RX_VAL |
+		       B_AX_GNT_WL_TX_VAL | B_AX_GNT_WL_BB_VAL;
+
+	if (gnt_cfg->band[0].gnt_wl_sw_en)
+		val |= B_AX_GNT_WL_RFC_S0_SWCTRL | B_AX_GNT_WL_RX_SWCTRL |
+		       B_AX_GNT_WL_TX_SWCTRL | B_AX_GNT_WL_BB_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_bt)
+		val |= B_AX_GNT_BT_RFC_S1_VAL | B_AX_GNT_BT_RX_VAL |
+		       B_AX_GNT_BT_TX_VAL;
+	else
+		val |= B_AX_WL_ACT_VAL;
+
+	if (gnt_cfg->band[1].gnt_bt_sw_en)
+		val |= B_AX_GNT_BT_RFC_S1_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
+		       B_AX_GNT_BT_TX_SWCTRL | B_AX_WL_ACT_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_wl)
+		val |= B_AX_GNT_WL_RFC_S1_VAL | B_AX_GNT_WL_RX_VAL |
+		       B_AX_GNT_WL_TX_VAL | B_AX_GNT_WL_BB_VAL;
+
+	if (gnt_cfg->band[1].gnt_wl_sw_en)
+		val |= B_AX_GNT_WL_RFC_S1_SWCTRL | B_AX_GNT_WL_RX_SWCTRL |
+		       B_AX_GNT_WL_TX_SWCTRL | B_AX_GNT_WL_BB_SWCTRL;
+
+	rtw89_write32(rtwdev, R_AX_GNT_SW_CTRL, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v1);
 
 int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
 {
@@ -3711,6 +3759,28 @@ int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl)
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path);
+
+int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	int i;
+
+	if (wl)
+		return 0;
+
+	for (i = 0; i < RTW89_PHY_MAX; i++) {
+		g[i].gnt_bt_sw_en = 1;
+		g[i].gnt_bt = 1;
+		g[i].gnt_wl_sw_en = 1;
+		g[i].gnt_wl = 0;
+	}
+
+	return rtw89_mac_cfg_gnt_v1(rtwdev, &dm->gnt);
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path_v1);
 
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 680b0eea31746..0fb09d6e176d1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -799,12 +799,15 @@ void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
 int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
+int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
 u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band);
 void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val);
 u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
 int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl);
+int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl);
 bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
 			    enum rtw89_phy_idx phy_idx,
 			    u32 reg_base, u32 *cr);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5c11c5d81c8bc..b37270e213649 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1620,6 +1620,31 @@
 #define B_AX_STATIS_BT_LO_TX_1_MASK GENMASK(15, 0)
 #define B_AX_STATIS_BT_LO_RX_1_MASK GENMASK(31, 16)
 
+#define R_AX_GNT_SW_CTRL 0xDA48
+#define R_AX_GNT_SW_CTRL_C1 0xFA48
+#define B_AX_WL_ACT2_VAL BIT(21)
+#define B_AX_WL_ACT2_SWCTRL BIT(20)
+#define B_AX_WL_ACT_VAL BIT(19)
+#define B_AX_WL_ACT_SWCTRL BIT(18)
+#define B_AX_GNT_BT_RX_VAL BIT(17)
+#define B_AX_GNT_BT_RX_SWCTRL BIT(16)
+#define B_AX_GNT_BT_TX_VAL BIT(15)
+#define B_AX_GNT_BT_TX_SWCTRL BIT(14)
+#define B_AX_GNT_WL_RX_VAL BIT(13)
+#define B_AX_GNT_WL_RX_SWCTRL BIT(12)
+#define B_AX_GNT_WL_TX_VAL BIT(11)
+#define B_AX_GNT_WL_TX_SWCTRL BIT(10)
+#define B_AX_GNT_BT_RFC_S1_VAL BIT(9)
+#define B_AX_GNT_BT_RFC_S1_SWCTRL BIT(8)
+#define B_AX_GNT_WL_RFC_S1_VAL BIT(7)
+#define B_AX_GNT_WL_RFC_S1_SWCTRL BIT(6)
+#define B_AX_GNT_BT_RFC_S0_VAL BIT(5)
+#define B_AX_GNT_BT_RFC_S0_SWCTRL BIT(4)
+#define B_AX_GNT_WL_RFC_S0_VAL BIT(3)
+#define B_AX_GNT_WL_RFC_S0_SWCTRL BIT(2)
+#define B_AX_GNT_WL_BB_VAL BIT(1)
+#define B_AX_GNT_WL_BB_SWCTRL BIT(0)
+
 #define R_AX_TDMA_MODE 0xDA4C
 #define R_AX_TDMA_MODE_C1 0xFA4C
 #define B_AX_R_BT_CMD_RPT_MASK GENMASK(31, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c6986c6498138..51e904ef85253 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2019,6 +2019,8 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 173008b14c4d6..2ea9d5422ed76 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -490,6 +490,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
-- 
2.25.1

