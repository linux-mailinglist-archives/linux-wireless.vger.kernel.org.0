Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C06AE235
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGOZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 09:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCGOZG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 09:25:06 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449392273
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 06:20:35 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 327EJfiI6004284, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 327EJfiI6004284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 7 Mar 2023 22:19:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 7 Mar 2023 22:19:38 +0800
Received: from localhost (172.16.16.178) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 7 Mar 2023
 22:19:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: release RX standby timer of beamformee CSI to save power
Date:   Tue, 7 Mar 2023 22:18:48 +0800
Message-ID: <20230307141848.26403-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.178]
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

Originally, we keep RX standby timer to handle beamformee CSI, but this
spends power and causes system not entering power save mode. To improve
power consumption, release the timer if throughput becomes low.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 35 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h  |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b1a886898c5a0..9073f526b5a3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3168,6 +3168,7 @@ enum rtw89_flags {
 	RTW89_FLAG_RUNNING,
 	RTW89_FLAG_BFEE_MON,
 	RTW89_FLAG_BFEE_EN,
+	RTW89_FLAG_BFEE_TIMER_KEEP,
 	RTW89_FLAG_NAPI_RUNNING,
 	RTW89_FLAG_LEISURE_PS,
 	RTW89_FLAG_LOW_POWER_MODE,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3d1e4ffef1b16..7866fe925d248 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4931,6 +4931,24 @@ u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band)
 	return cnt;
 }
 
+static void rtw89_mac_bfee_standby_timer(struct rtw89_dev *rtwdev, u8 mac_idx,
+					 bool keep)
+{
+	u32 reg;
+
+	rtw89_debug(rtwdev, RTW89_DBG_BF, "set bfee standby_timer to %d\n", keep);
+	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
+	if (keep) {
+		set_bit(RTW89_FLAG_BFEE_TIMER_KEEP, rtwdev->flags);
+		rtw89_write32_mask(rtwdev, reg, B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK,
+				   BFRP_RX_STANDBY_TIMER_KEEP);
+	} else {
+		clear_bit(RTW89_FLAG_BFEE_TIMER_KEEP, rtwdev->flags);
+		rtw89_write32_mask(rtwdev, reg, B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK,
+				   BFRP_RX_STANDBY_TIMER_RELEASE);
+	}
+}
+
 static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
 	u32 reg;
@@ -4967,9 +4985,9 @@ static int rtw89_mac_init_bfee(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32(rtwdev, reg, CSI_RRSC_BMAP);
 
 	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
-	val32 = FIELD_PREP(B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK, BFRP_RX_STANDBY_TIMER);
-	val32 |= FIELD_PREP(B_AX_BFMEE_NDP_RX_STANDBY_TIMER_MASK, NDP_RX_STANDBY_TIMER);
+	val32 = FIELD_PREP(B_AX_BFMEE_NDP_RX_STANDBY_TIMER_MASK, NDP_RX_STANDBY_TIMER);
 	rtw89_write32(rtwdev, reg, val32);
+	rtw89_mac_bfee_standby_timer(rtwdev, mac_idx, true);
 	rtw89_mac_bfee_ctrl(rtwdev, mac_idx, true);
 
 	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
@@ -5181,6 +5199,19 @@ void _rtw89_mac_bf_monitor_track(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif;
 	bool en = stats->tx_tfc_lv <= stats->rx_tfc_lv;
 	bool old = test_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
+	bool keep_timer = true;
+	bool old_keep_timer;
+
+	old_keep_timer = test_bit(RTW89_FLAG_BFEE_TIMER_KEEP, rtwdev->flags);
+
+	if (stats->tx_tfc_lv <= RTW89_TFC_LOW && stats->rx_tfc_lv <= RTW89_TFC_LOW)
+		keep_timer = false;
+
+	if (keep_timer != old_keep_timer) {
+		rtw89_for_each_rtwvif(rtwdev, rtwvif)
+			rtw89_mac_bfee_standby_timer(rtwdev, rtwvif->mac_idx,
+						     keep_timer);
+	}
 
 	if (en == old)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 600257909df27..e5c0ab43ab7a0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3056,6 +3056,8 @@
 #define R_AX_BFMEE_RESP_OPTION_C1 0xED80
 #define B_AX_BFMEE_NDP_RX_STANDBY_TIMER_MASK GENMASK(31, 24)
 #define B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK GENMASK(23, 20)
+#define BFRP_RX_STANDBY_TIMER_KEEP 0x0
+#define BFRP_RX_STANDBY_TIMER_RELEASE 0x1
 #define B_AX_MU_BFRPTSEG_SEL_MASK GENMASK(18, 17)
 #define B_AX_BFMEE_NDP_RXSTDBY_SEL BIT(16)
 #define BFRP_RX_STANDBY_TIMER		0x0
-- 
2.25.1

