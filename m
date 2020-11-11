Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35CC2AE658
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgKKCWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39280 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MCEQ0027711, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MCEQ0027711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:12 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/11] rtw88: coex: update TDMA settings for different beacon interval
Date:   Wed, 11 Nov 2020 10:20:58 +0800
Message-ID: <20201111022108.9834-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201111022108.9834-1-pkshih@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw88/coex.c     | 24 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/mac80211.c |  7 ++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 61e91565cd7d..141aaa60c805 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -225,6 +225,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 para[2] = {0};
+	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
 	if (coex_stat->tdma_timer_base == type)
 		return;
@@ -233,10 +234,29 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 
 	para[0] = COEX_H2C69_TDMA_SLOT;
 
-	if (type == 3) /* 4-slot  */
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], tbtt_interval = %d\n",
+		tbtt_interval);
+
+	if (type == 3) {			  /* 4-slot  */
 		para[1] = PARA1_H2C69_TDMA_4SLOT; /* 4-slot */
-	else /* 2-slot  */
+	} else if (tbtt_interval < 80 && tbtt_interval > 0) {
+		para[1] = (100 / tbtt_interval);
+
+		if (100 % tbtt_interval != 0)
+			para[1] = para[1] + 1;
+
+		para[1] = para[1] & 0x3f;
+	} else if (tbtt_interval >= 180) {
+		para[1] = (tbtt_interval / 100);
+
+		if (tbtt_interval % 100 <= 80)
+			para[1] = para[1] - 1;
+
+		para[1] = para[1] & 0x3f;
+		para[1] = para[1] | 0x80;
+	} else {
 		para[1] = PARA1_H2C69_TDMA_2SLOT;
+	}
 
 	rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
 
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

