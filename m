Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754584D58A8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbiCKDFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbiCKDFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2A1A7D92
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:04:10 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B344tR4021573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B344tR4021573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:04:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Mar 2022 11:04:04 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:04:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 11/11] rtw89: implement stop and resume channels transmission v1
Date:   Fri, 11 Mar 2022 11:03:01 +0800
Message-ID: <20220311030301.33921-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
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

These function is used to stop transmitting when we are going to switch
channels or do some RF calibration. Before these operations, we need to
stop channel transmission and backup setting into parameter tx_en. After
operations are done, resume transmitting by backup parameter tx_en.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 20 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 84 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |  3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  7 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 16 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 7 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0ffb163c23f0f..771722132c53b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2071,6 +2071,9 @@ struct rtw89_chip_ops {
 	int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
 	int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
 			   const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
+	int (*stop_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx,
+			   u32 *tx_en, enum rtw89_sch_tx_sel sel);
+	int (*resume_sch_tx)(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
@@ -3486,6 +3489,23 @@ static inline void rtw89_chip_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl)
 	chip->ops->cfg_ctrl_path(rtwdev, wl);
 }
 
+static inline
+int rtw89_chip_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
+			   u32 *tx_en, enum rtw89_sch_tx_sel sel)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->stop_sch_tx(rtwdev, mac_idx, tx_en, sel);
+}
+
+static inline
+int rtw89_chip_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->resume_sch_tx(rtwdev, mac_idx, tx_en);
+}
+
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 {
 	__le16 fc = hdr->frame_control;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 793059853a6aa..fbc87b80e842a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2246,6 +2246,24 @@ static int rtw89_set_hw_sch_tx_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 	return 0;
 }
 
+static int rtw89_set_hw_sch_tx_en_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
+				     u32 tx_en, u32 tx_en_mask)
+{
+	u32 reg = rtw89_mac_reg_by_idx(R_AX_CTN_DRV_TXEN, mac_idx);
+	u32 val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	val = rtw89_read32(rtwdev, reg);
+	val = (val & ~tx_en_mask) | (tx_en & tx_en_mask);
+	rtw89_write32(rtwdev, reg, val);
+
+	return 0;
+}
+
 int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 			  u32 *tx_en, enum rtw89_sch_tx_sel sel)
 {
@@ -2256,7 +2274,8 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 
 	switch (sel) {
 	case RTW89_SCH_TX_SEL_ALL:
-		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0, 0xffff);
+		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0,
+					     B_AX_CTN_TXEN_ALL_MASK);
 		if (ret)
 			return ret;
 		break;
@@ -2273,7 +2292,8 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 			return ret;
 		break;
 	case RTW89_SCH_TX_SEL_MACID:
-		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0, 0xffff);
+		ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, 0,
+					     B_AX_CTN_TXEN_ALL_MASK);
 		if (ret)
 			return ret;
 		break;
@@ -2285,11 +2305,52 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 }
 EXPORT_SYMBOL(rtw89_mac_stop_sch_tx);
 
+int rtw89_mac_stop_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
+			     u32 *tx_en, enum rtw89_sch_tx_sel sel)
+{
+	int ret;
+
+	*tx_en = rtw89_read32(rtwdev,
+			      rtw89_mac_reg_by_idx(R_AX_CTN_DRV_TXEN, mac_idx));
+
+	switch (sel) {
+	case RTW89_SCH_TX_SEL_ALL:
+		ret = rtw89_set_hw_sch_tx_en_v1(rtwdev, mac_idx, 0,
+						B_AX_CTN_TXEN_ALL_MASK_V1);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_HIQ:
+		ret = rtw89_set_hw_sch_tx_en_v1(rtwdev, mac_idx,
+						0, B_AX_CTN_TXEN_HGQ);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_MG0:
+		ret = rtw89_set_hw_sch_tx_en_v1(rtwdev, mac_idx,
+						0, B_AX_CTN_TXEN_MGQ);
+		if (ret)
+			return ret;
+		break;
+	case RTW89_SCH_TX_SEL_MACID:
+		ret = rtw89_set_hw_sch_tx_en_v1(rtwdev, mac_idx, 0,
+						B_AX_CTN_TXEN_ALL_MASK_V1);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_stop_sch_tx_v1);
+
 int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 {
 	int ret;
 
-	ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, tx_en, 0xffff);
+	ret = rtw89_set_hw_sch_tx_en(rtwdev, mac_idx, tx_en, B_AX_CTN_TXEN_ALL_MASK);
 	if (ret)
 		return ret;
 
@@ -2297,6 +2358,19 @@ int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 }
 EXPORT_SYMBOL(rtw89_mac_resume_sch_tx);
 
+int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
+{
+	int ret;
+
+	ret = rtw89_set_hw_sch_tx_en_v1(rtwdev, mac_idx, tx_en,
+					B_AX_CTN_TXEN_ALL_MASK_V1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v1);
+
 static u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len,
 				 bool wd)
 {
@@ -2461,7 +2535,7 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 	u32 pause_bak[4] = {0};
 	u32 tx_en;
 
-	ret = rtw89_mac_stop_sch_tx(rtwdev, 0, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	ret = rtw89_chip_stop_sch_tx(rtwdev, 0, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]stop sch tx %d\n", ret);
 		return ret;
@@ -2491,7 +2565,7 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 		rtw89_write32(rtwdev, R_AX_SS_MACID_PAUSE_0 + i * 4, pause_bak[i]);
 	}
 
-	ret = rtw89_mac_resume_sch_tx(rtwdev, 0, tx_en);
+	ret = rtw89_chip_resume_sch_tx(rtwdev, 0, tx_en);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC1 resume sch tx %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 07a8c7c816a35..b797667c78c6f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -792,7 +792,10 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev);
 int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 			  u32 *tx_en, enum rtw89_sch_tx_sel sel);
+int rtw89_mac_stop_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
+			     u32 *tx_en, enum rtw89_sch_tx_sel sel);
 int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
+int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_ids, bool enable);
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b37270e213649..25b1067881188 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -893,6 +893,7 @@
 #define B_AX_CTN_TXEN_VI_0 BIT(2)
 #define B_AX_CTN_TXEN_BK_0 BIT(1)
 #define B_AX_CTN_TXEN_BE_0 BIT(0)
+#define B_AX_CTN_TXEN_ALL_MASK GENMASK(15, 0)
 
 #define R_AX_MUEDCA_BE_PARAM_0 0xC350
 #define R_AX_MUEDCA_BE_PARAM_0_C1 0xE350
@@ -939,6 +940,12 @@
 #define B_AX_CTN_CHK_CCA_S20 BIT(1)
 #define B_AX_CTN_CHK_CCA_P20 BIT(0)
 
+#define R_AX_CTN_DRV_TXEN 0xC398
+#define R_AX_CTN_DRV_TXEN_C1 0xE398
+#define B_AX_CTN_TXEN_TWT_3 BIT(17)
+#define B_AX_CTN_TXEN_TWT_2 BIT(16)
+#define B_AX_CTN_TXEN_ALL_MASK_V1 GENMASK(17, 0)
+
 #define R_AX_SCHEDULE_ERR_IMR 0xC3E8
 #define R_AX_SCHEDULE_ERR_IMR_C1 0xE3E8
 #define B_AX_SORT_NON_IDLE_ERR_INT_EN BIT(1)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 51e904ef85253..41fc8db311ecf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1167,7 +1167,7 @@ static void rtw8852a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	u8 phy_idx = RTW89_PHY_0;
 
 	if (enter) {
-		rtw89_mac_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
+		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
 		rtw8852a_dfs_en(rtwdev, false);
 		rtw8852a_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
@@ -1180,7 +1180,7 @@ static void rtw8852a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 		rtw8852a_dfs_en(rtwdev, true);
 		rtw8852a_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
 		rtw8852a_bb_reset_en(rtwdev, phy_idx, true);
-		rtw89_mac_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
+		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
 	}
 }
 
@@ -2021,6 +2021,8 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.pwr_off_func		= NULL,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 4b29dc9a5c078..ad272854c442f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -3554,7 +3554,7 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 		    __func__, phy, power, xdbm);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
-	rtw89_mac_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	rtw89_chip_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy));
 	tx_counter = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 
@@ -3600,7 +3600,7 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 
 	rtw8852a_bb_tx_mode_switch(rtwdev, phy, 0);
 
-	rtw89_mac_resume_sch_tx(rtwdev, phy, tx_en);
+	rtw89_chip_resume_sch_tx(rtwdev, phy, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
 }
 
@@ -3627,7 +3627,7 @@ void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
-	rtw89_mac_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_iqk_init(rtwdev);
@@ -3636,7 +3636,7 @@ void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	else
 		_iqk(rtwdev, phy_idx, false);
 
-	rtw89_mac_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
@@ -3652,12 +3652,12 @@ void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
-	rtw89_mac_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_rx_dck(rtwdev, phy_idx, is_afe);
 
-	rtw89_mac_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
@@ -3667,14 +3667,14 @@ void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
-	rtw89_mac_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	rtwdev->dpk.is_dpk_enable = true;
 	rtwdev->dpk.is_dpk_reload_en = false;
 	_dpk(rtwdev, phy_idx, false);
 
-	rtw89_mac_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 2ea9d5422ed76..58920e91765e8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -492,6 +492,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 };
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
-- 
2.25.1

