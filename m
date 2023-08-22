Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA678416A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjHVM73 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjHVM72 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEC3BCD0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwt8S3022590, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwt8S3022590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 20:59:17 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: mac: define register address of rx_filter to generalize code
Date:   Tue, 22 Aug 2023 20:58:20 +0800
Message-ID: <20230822125822.23817-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822125822.23817-1-pkshih@realtek.com>
References: <20230822125822.23817-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rx_filter is used to decide which kind of packets are received to driver,
or just dropped by MAC layer to reduce bus traffic.

The bit definitions of old and new chips are the sames, but only address
is changed, so define a field to generalize usage.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  6 ++++--
 drivers/net/wireless/realtek/rtw89/fw.c       |  6 ++++--
 drivers/net/wireless/realtek/rtw89/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  5 +++--
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.c      |  3 ++-
 8 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2f6db0658a73..818fb8cf465a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2451,6 +2451,7 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 
 void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_roc *roc = &rtwvif->roc;
 	struct cfg80211_chan_def roc_chan;
@@ -2478,7 +2479,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, &roc_chan);
 	rtw89_set_channel(rtwdev);
 	rtw89_write32_clr(rtwdev,
-			  rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			  rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
@@ -2486,6 +2487,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_roc *roc = &rtwvif->roc;
 	struct rtw89_vif *tmp;
@@ -2499,7 +2501,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_lps(rtwdev);
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c8b47b6fbafa..752dba4d5a10 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3851,6 +3851,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			 struct ieee80211_scan_request *scan_req)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct cfg80211_scan_request *req = &scan_req->req;
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
@@ -3873,7 +3874,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rx_fltr &= ~B_AX_A_BC;
 	rx_fltr &= ~B_AX_A_A1_MATCH;
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rx_fltr);
 }
@@ -3881,6 +3882,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool aborted)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
@@ -3891,7 +3893,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		return;
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e0925a21a096..fab9f5004a75 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5689,5 +5689,6 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.filter_model_addr = R_AX_FILTER_MODEL_ADDR,
 	.indir_access_addr = R_AX_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
+	.rx_fltr = R_AX_RX_FLTR_OPT,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7c7940093480..7cf34137c0bc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -857,6 +857,7 @@ struct rtw89_mac_gen_def {
 	u32 filter_model_addr;
 	u32 indir_access_addr;
 	const u32 *mem_base_addrs;
+	u32 rx_fltr;
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index c5c714a3de44..33af7add2d4e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -224,6 +224,7 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 				       u64 multicast)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -271,13 +272,13 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 	}
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 	if (!rtwdev->dbcc_en)
 		goto out;
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_1),
+			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_1),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ec920978195e..9a63fb35e867 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -33,5 +33,6 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
 	.indir_access_addr = R_BE_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
+	.rx_fltr = R_BE_RX_FLTR_OPT,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index cab07cc993f0..eab26039242a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3627,6 +3627,25 @@
 
 #define R_BE_FILTER_MODEL_ADDR 0x0C04
 
+#define R_BE_RX_FLTR_OPT 0x11420
+#define R_BE_RX_FLTR_OPT_C1 0x15420
+#define B_BE_UID_FILTER_MASK GENMASK(31, 24)
+#define B_BE_UNSPT_TYPE BIT(22)
+#define B_BE_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
+#define B_BE_A_FTM_REQ BIT(14)
+#define B_BE_A_ERR_PKT BIT(13)
+#define B_BE_A_UNSUP_PKT BIT(12)
+#define B_BE_A_CRC32_ERR BIT(11)
+#define B_BE_A_BCN_CHK_RULE_MASK GENMASK(9, 8)
+#define B_BE_A_BCN_CHK_EN BIT(7)
+#define B_BE_A_MC_LIST_CAM_MATCH BIT(6)
+#define B_BE_A_BC_CAM_MATCH BIT(5)
+#define B_BE_A_UC_CAM_MATCH BIT(4)
+#define B_BE_A_MC BIT(3)
+#define B_BE_A_BC BIT(2)
+#define B_BE_A_A1_MATCH BIT(1)
+#define B_BE_SNIFFER_MODE BIT(0)
+
 #define RR_MOD 0x00
 #define RR_MOD_V1 0x10000
 #define RR_MOD_IQK GENMASK(19, 4)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 364e54622150..aa9efca04025 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -40,6 +40,7 @@ static void rtw89_wow_leave_lps(struct rtw89_dev *rtwdev)
 
 static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
 	if (enable_wow) {
@@ -49,7 +50,7 @@ static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
 			return ret;
 		}
 		rtw89_write32_set(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
-		rtw89_write32_clr(rtwdev, R_AX_RX_FLTR_OPT, B_AX_SNIFFER_MODE);
+		rtw89_write32_clr(rtwdev, mac->rx_fltr, B_AX_SNIFFER_MODE);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
 		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, 0);
 		rtw89_write32(rtwdev, R_AX_ACTION_FWD1, 0);
-- 
2.25.1

