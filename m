Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B722AFEC2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgKLFiq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38671 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FUYZ0025856, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FUYZ0025856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:30 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 01/11] rtw88: coex: update TDMA settings for different beacon interval
Date:   Thu, 12 Nov 2020 11:14:20 +0800
Message-ID: <20201112031430.4846-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Add considering for different WLAN beacon interval in coexistence
mechanism.
Because the WLAN beacon period may be not 100 ms, so it's necessary
to consider any beacon period and set timer according to the interval.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: give proper name and use suggested macros
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 27 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/coex.h     |  5 ++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  7 +++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 61e91565cd7d..50df2e1b4842 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -225,6 +225,8 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 para[2] = {0};
+	u8 times;
+	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
 	if (coex_stat->tdma_timer_base == type)
 		return;
@@ -233,10 +235,27 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 
 	para[0] = COEX_H2C69_TDMA_SLOT;
 
-	if (type == 3) /* 4-slot  */
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], tbtt_interval = %d\n",
+		tbtt_interval);
+
+	if (type == TDMA_TIMER_TYPE_4SLOT) {
 		para[1] = PARA1_H2C69_TDMA_4SLOT; /* 4-slot */
-	else /* 2-slot  */
+	} else if (tbtt_interval < 80 && tbtt_interval > 0) {
+		times = 100 / tbtt_interval;
+		if (100 % tbtt_interval != 0)
+			times++;
+
+		para[1] = FIELD_PREP(PARA1_H2C69_TBTT_TIMES, times);
+	} else if (tbtt_interval >= 180) {
+		times = tbtt_interval / 100;
+		if (tbtt_interval % 100 <= 80)
+			times--;
+
+		para[1] = FIELD_PREP(PARA1_H2C69_TBTT_TIMES, times) |
+			  FIELD_PREP(PARA1_H2C69_TBTT_DIV100, 1);
+	} else {
 		para[1] = PARA1_H2C69_TDMA_2SLOT;
+	}
 
 	rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 
@@ -973,9 +992,9 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	bool wl_busy = false;
 
 	if (tcase & TDMA_4SLOT)/* 4-slot (50ms) mode */
-		rtw_coex_tdma_timer_base(rtwdev, 3);
+		rtw_coex_tdma_timer_base(rtwdev, TDMA_TIMER_TYPE_4SLOT);
 	else
-		rtw_coex_tdma_timer_base(rtwdev, 0);
+		rtw_coex_tdma_timer_base(rtwdev, TDMA_TIMER_TYPE_2SLOT);
 
 	type = (u8)(tcase & 0xff);
 
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 9b305fc6c984..73f1bbc68490 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -21,9 +21,14 @@
 #define COEX_H2C69_TDMA_SLOT	0xb
 #define PARA1_H2C69_TDMA_4SLOT	0xc1
 #define PARA1_H2C69_TDMA_2SLOT	0x1
+#define PARA1_H2C69_TBTT_TIMES	GENMASK(5, 0)
+#define PARA1_H2C69_TBTT_DIV100	BIT(7)
 
 #define TDMA_4SLOT	BIT(8)
 
+#define TDMA_TIMER_TYPE_2SLOT 0
+#define TDMA_TIMER_TYPE_4SLOT 3
+
 #define COEX_RSSI_STEP		4
 
 #define COEX_RSSI_HIGH(rssi) \
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index c69397719fdf..1f1b639cd124 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -351,6 +351,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u32 config = 0;
 
 	mutex_lock(&rtwdev->mutex);
@@ -381,6 +383,11 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 		config |= PORT_SET_BSSID;
 	}
 
+	if (changed & BSS_CHANGED_BEACON_INT) {
+		if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION)
+			coex_stat->wl_beacon_interval = conf->beacon_int;
+	}
+
 	if (changed & BSS_CHANGED_BEACON)
 		rtw_fw_download_rsvd_page(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index a3a687a63734..3941aea51f9c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1354,6 +1354,7 @@ struct rtw_coex_stat {
 	u8 bt_a2dp_bitpool;
 	u8 bt_iqk_state;
 
+	u16 wl_beacon_interval;
 	u8 wl_noisy_level;
 	u8 wl_fw_dbg_info[10];
 	u8 wl_fw_dbg_info_pre[10];
-- 
2.21.0

