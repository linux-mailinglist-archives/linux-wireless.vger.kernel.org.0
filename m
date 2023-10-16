Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B77C9FF8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjJPGwE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJPGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88020E1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6pi2K32264229, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6pi2K32264229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 16 Oct 2023 14:51:45 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: phy: change naming related BT coexistence functions
Date:   Mon, 16 Oct 2023 14:51:11 +0800
Message-ID: <20231016065115.751662-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016065115.751662-1-pkshih@realtek.com>
References: <20231016065115.751662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsuan Hung <hsuan8331@realtek.com>

Change naming to disambiguate the functions because their names are common
and not clear about the purpose. Not change logic at all.

These functions are to control baseband AGC while BT coexists with WiFi.
Among these functions, ctrl_btg_bt_rx is used to control AGC related
settings, which is affected by BT RX, while BT shares the same path
with wifi; ctrl_nbtg_bt_tx is used to control AGC settings under
non-shared path condition, which is affected by BT TX.

Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 21 +++++++------
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 16 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 20 +++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 24 ++++++++-------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 30 +++++++++++--------
 6 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 207218cdf2c4..bdcc172639e4 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3837,7 +3837,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	if (mode == BTC_WLINK_25G_MCC)
 		return;
 
-	rtw89_ctrl_btg(rtwdev, is_btg);
+	rtw89_ctrl_btg_bt_rx(rtwdev, is_btg, RTW89_PHY_0);
 }
 
 struct rtw89_txtime_data {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d5272a82ff8b..ef63fc20db71 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3136,11 +3136,13 @@ struct rtw89_chip_ops {
 			       enum rtw89_phy_idx phy_idx);
 	int (*init_txpwr_unit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 	u8 (*get_thermal)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path);
-	void (*ctrl_btg)(struct rtw89_dev *rtwdev, bool btg);
+	void (*ctrl_btg_bt_rx)(struct rtw89_dev *rtwdev, bool en,
+			       enum rtw89_phy_idx phy_idx);
 	void (*query_ppdu)(struct rtw89_dev *rtwdev,
 			   struct rtw89_rx_phy_ppdu *phy_ppdu,
 			   struct ieee80211_rx_status *status);
-	void (*bb_ctrl_btc_preagc)(struct rtw89_dev *rtwdev, bool bt_en);
+	void (*ctrl_nbtg_bt_tx)(struct rtw89_dev *rtwdev, bool en,
+				enum rtw89_phy_idx phy_idx);
 	void (*cfg_txrx_path)(struct rtw89_dev *rtwdev);
 	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
@@ -5423,13 +5425,13 @@ static inline void rtw89_chip_query_ppdu(struct rtw89_dev *rtwdev,
 		chip->ops->query_ppdu(rtwdev, phy_ppdu, status);
 }
 
-static inline void rtw89_chip_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev,
-						 bool bt_en)
+static inline void rtw89_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+					 enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->ops->bb_ctrl_btc_preagc)
-		chip->ops->bb_ctrl_btc_preagc(rtwdev, bt_en);
+	if (chip->ops->ctrl_nbtg_bt_tx)
+		chip->ops->ctrl_nbtg_bt_tx(rtwdev, en, phy_idx);
 }
 
 static inline void rtw89_chip_cfg_txrx_path(struct rtw89_dev *rtwdev)
@@ -5467,12 +5469,13 @@ static inline u8 rtw89_regd_get(struct rtw89_dev *rtwdev, u8 band)
 	return regd->txpwr_regd[band];
 }
 
-static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+static inline void rtw89_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+					enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->ops->ctrl_btg)
-		chip->ops->ctrl_btg(rtwdev, btg);
+	if (chip->ops->ctrl_btg_bt_rx)
+		chip->ops->ctrl_btg_bt_rx(rtwdev, en, phy_idx);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ecaa86ccd49e..491980eb8e2e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1779,14 +1779,15 @@ rtw8851b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return 0;
 }
 
-static void rtw8851b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+static void rtw8851b_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
-	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8851b_btc_preagc_en_defs_tbl :
+	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8851b_btc_preagc_en_defs_tbl :
 						 &rtw8851b_btc_preagc_dis_defs_tbl);
 
-	if (!bt_en) {
+	if (!en) {
 		if (chan->band_type == RTW89_BAND_2G) {
 			rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
 					       B_PATH0_G_LNA6_OP1DB_V1, 0x20);
@@ -1801,11 +1802,12 @@ static void rtw8851b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
 	}
 }
 
-static void rtw8851b_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+static void rtw8851b_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
-	if (btg) {
+	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
 				       B_PATH0_BT_SHARE_V1, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
@@ -2302,9 +2304,9 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.set_txpwr_ctrl		= rtw8851b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8851b_init_txpwr_unit,
 	.get_thermal		= rtw8851b_get_thermal,
-	.ctrl_btg		= rtw8851b_ctrl_btg,
+	.ctrl_btg_bt_rx		= rtw8851b_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8851b_query_ppdu,
-	.bb_ctrl_btc_preagc	= rtw8851b_bb_ctrl_btc_preagc,
+	.ctrl_nbtg_bt_tx	= rtw8851b_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index ec6ec3868d52..385655c061db 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1624,9 +1624,10 @@ void rtw8852a_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 0, idx);
 }
 
-static void rtw8852a_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+static void rtw8852a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
 {
-	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8852a_btc_preagc_en_defs_tbl :
+	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8852a_btc_preagc_en_defs_tbl :
 						 &rtw8852a_btc_preagc_dis_defs_tbl);
 }
 
@@ -1683,9 +1684,10 @@ void rtw8852a_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
 	rtw89_write_rf(rtwdev, path, RR_LUTWE, 0xfffff, 0x0);
 }
 
-static void rtw8852a_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+static void rtw8852a_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx)
 {
-	if (btg) {
+	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG, B_PATH0_BTG_SHEN, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_PATH1_BTG, B_PATH1_BTG_SHEN, 0x3);
 		rtw89_phy_write32_mask(rtwdev, R_PMAC_GNT, B_PMAC_GNT_P1, 0x0);
@@ -1966,15 +1968,15 @@ static void rtw8852a_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	switch (level) {
 	case 0: /* original */
 	default:
-		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852a_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
-		rtw8852a_bb_ctrl_btc_preagc(rtwdev, true);
+		rtw8852a_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
-		rtw8852a_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852a_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 1;
 		break;
 	}
@@ -2046,9 +2048,9 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852a_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852a_init_txpwr_unit,
 	.get_thermal		= rtw8852a_get_thermal,
-	.ctrl_btg		= rtw8852a_ctrl_btg,
+	.ctrl_btg_bt_rx		= rtw8852a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852a_query_ppdu,
-	.bb_ctrl_btc_preagc	= rtw8852a_bb_ctrl_btc_preagc,
+	.ctrl_nbtg_bt_tx	= rtw8852a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= NULL,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index e5bc459dbe79..93233217b57a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1929,15 +1929,17 @@ void rtw8852b_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
 	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, bak->tx_pwr, idx);
 }
 
-static void rtw8852b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+static void rtw8852b_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
 {
-	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8852b_btc_preagc_en_defs_tbl :
+	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8852b_btc_preagc_en_defs_tbl :
 						 &rtw8852b_btc_preagc_dis_defs_tbl);
 }
 
-static void rtw8852b_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+static void rtw8852b_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx)
 {
-	if (btg) {
+	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
 				       B_PATH0_BT_SHARE_V1, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
@@ -2018,9 +2020,9 @@ void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
 
 	if (chan->band_type == RTW89_BAND_2G &&
 	    (rx_path == RF_B || rx_path == RF_AB))
-		rtw8852b_ctrl_btg(rtwdev, true);
+		rtw8852b_ctrl_btg_bt_rx(rtwdev, true, RTW89_PHY_0);
 	else
-		rtw8852b_ctrl_btg(rtwdev, false);
+		rtw8852b_ctrl_btg_bt_rx(rtwdev, false, RTW89_PHY_0);
 
 	rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
 	rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
@@ -2346,15 +2348,15 @@ static void rtw8852b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	switch (level) {
 	case 0: /* original */
 	default:
-		rtw8852b_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
-		rtw8852b_bb_ctrl_btc_preagc(rtwdev, true);
+		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
-		rtw8852b_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852b_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 1;
 		break;
 	}
@@ -2471,9 +2473,9 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
 	.get_thermal		= rtw8852b_get_thermal,
-	.ctrl_btg		= rtw8852b_ctrl_btg,
+	.ctrl_btg_bt_rx		= rtw8852b_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852b_query_ppdu,
-	.bb_ctrl_btc_preagc	= rtw8852b_bb_ctrl_btc_preagc,
+	.ctrl_nbtg_bt_tx	= rtw8852b_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index db289f1d7ae5..7f7057e74417 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -167,7 +167,9 @@ static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
-static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg);
+static void rtw8852c_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx);
+
 static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 				       enum rtw89_mac_idx mac_idx);
 
@@ -1651,7 +1653,8 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 	}
 
 	rtw8852c_spur_elimination(rtwdev, chan, pri_ch_idx, phy_idx);
-	rtw8852c_ctrl_btg(rtwdev, chan->band_type == RTW89_BAND_2G);
+	rtw8852c_ctrl_btg_bt_rx(rtwdev, chan->band_type == RTW89_BAND_2G,
+				RTW89_PHY_0);
 	rtw8852c_5m_mask(rtwdev, chan, phy_idx);
 
 	if (chan->band_width == RTW89_CHANNEL_WIDTH_160 &&
@@ -2150,7 +2153,8 @@ static void rtw8852c_bb_cfg_rx_path(struct rtw89_dev *rtwdev, u8 rx_path)
 					       1);
 			rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS,
 					       1);
-			rtw8852c_ctrl_btg(rtwdev, band == RTW89_BAND_2G);
+			rtw8852c_ctrl_btg_bt_rx(rtwdev, band == RTW89_BAND_2G,
+						RTW89_PHY_0);
 			rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
 					       rst_mask0, 1);
 			rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
@@ -2226,9 +2230,10 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 	}
 }
 
-static void rtw8852c_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+static void rtw8852c_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
+				     enum rtw89_phy_idx phy_idx)
 {
-	if (bt_en) {
+	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_FRC_FIR_TYPE_V1,
 				       B_PATH0_FRC_FIR_TYPE_MSK_V1, 0x3);
 		rtw89_phy_write32_mask(rtwdev, R_PATH1_FRC_FIR_TYPE_V1,
@@ -2346,9 +2351,10 @@ static void rtw8852c_btc_set_rfe(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
+static void rtw8852c_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
+				    enum rtw89_phy_idx phy_idx)
 {
-	if (btg) {
+	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
 				       B_PATH0_BT_SHARE_V1, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BTG_PATH_V1,
@@ -2658,15 +2664,15 @@ static void rtw8852c_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	switch (level) {
 	case 0: /* original */
 	default:
-		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852c_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 1: /* for FDD free-run */
-		rtw8852c_bb_ctrl_btc_preagc(rtwdev, true);
+		rtw8852c_ctrl_nbtg_bt_tx(rtwdev, true, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 0;
 		break;
 	case 2: /* for BTG Co-Rx*/
-		rtw8852c_bb_ctrl_btc_preagc(rtwdev, false);
+		rtw8852c_ctrl_nbtg_bt_tx(rtwdev, false, RTW89_PHY_0);
 		btc->dm.wl_lna2 = 1;
 		break;
 	}
@@ -2788,9 +2794,9 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852c_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852c_init_txpwr_unit,
 	.get_thermal		= rtw8852c_get_thermal,
-	.ctrl_btg		= rtw8852c_ctrl_btg,
+	.ctrl_btg_bt_rx		= rtw8852c_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852c_query_ppdu,
-	.bb_ctrl_btc_preagc	= rtw8852c_bb_ctrl_btc_preagc,
+	.ctrl_nbtg_bt_tx	= rtw8852c_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
-- 
2.25.1

