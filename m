Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199E954F38E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381317AbiFQIum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381316AbiFQIul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 04:50:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2669B56
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 01:50:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25H8oXLa9020825, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25H8oXLa9020825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 16:50:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 17 Jun 2022 16:50:33 +0800
Received: from localhost (172.16.16.131) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 17 Jun
 2022 16:50:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 01/13] rtw89: rewrite decision on channel by entity state
Date:   Fri, 17 Jun 2022 16:49:42 +0800
Message-ID: <20220617084954.61261-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617084954.61261-1-pkshih@realtek.com>
References: <20220617084954.61261-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.131]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/17/2022 08:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTcgpFekyCAwNjozNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We need to invoke the callback of the changed band at the first
set_channel() after every power-off. Originally, we forced the
channel to be 0 when doing power-off, and then determined things
by comparing channel with 0.

However, deciding on such things by channel might be confusing.
It's also confusing to use this kind of decision when we consider
multiple channels in the follow-up patches. So, another flag,
entity_active, is added ahead to HAL to deal with this.

Besides, we also need to check if entity is active when we set
TX power.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.h | 24 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.c | 26 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h | 15 +++----------
 drivers/net/wireless/realtek/rtw89/mac.c  |  4 ++--
 drivers/net/wireless/realtek/rtw89/regd.c |  2 +-
 drivers/net/wireless/realtek/rtw89/sar.c  |  2 +-
 6 files changed, 53 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.h

diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
new file mode 100644
index 0000000000000..bcaeb98670f17
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+ * Copyright(c) 2020-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_CHAN_H__
+#define __RTW89_CHAN_H__
+
+#include "core.h"
+
+static inline bool rtw89_get_entity_state(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	return READ_ONCE(hal->entity_active);
+}
+
+static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	WRITE_ONCE(hal->entity_active, active);
+}
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d2f2a3d65ef6f..019641658ff20 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5,6 +5,7 @@
 #include <linux/udp.h>
 
 #include "cam.h"
+#include "chan.h"
 #include "coex.h"
 #include "core.h"
 #include "efuse.h"
@@ -351,6 +352,19 @@ static void rtw89_get_channel_params(struct cfg80211_chan_def *chandef,
 	chan_param->subband_type = subband;
 }
 
+void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool entity_active;
+
+	entity_active = rtw89_get_entity_state(rtwdev);
+	if (!entity_active)
+		return;
+
+	if (chip->ops->set_txpwr)
+		chip->ops->set_txpwr(rtwdev);
+}
+
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
@@ -360,6 +374,9 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	struct rtw89_channel_help_params bak;
 	u8 center_chan, bandwidth;
 	bool band_changed;
+	bool entity_active;
+
+	entity_active = rtw89_get_entity_state(rtwdev);
 
 	rtw89_get_channel_params(&hw->conf.chandef, &ch_param);
 	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
@@ -367,8 +384,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	center_chan = ch_param.center_chan;
 	bandwidth = ch_param.bandwidth;
-	band_changed = hal->current_band_type != ch_param.band_type ||
-		       hal->current_channel == 0;
+	band_changed = hal->current_band_type != ch_param.band_type;
 
 	hal->current_band_width = bandwidth;
 	hal->current_channel = center_chan;
@@ -379,15 +395,17 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	hal->current_band_type = ch_param.band_type;
 	hal->current_subband = ch_param.subband_type;
 
+	rtw89_set_entity_state(rtwdev, true);
+
 	rtw89_chip_set_channel_prepare(rtwdev, &bak);
 
 	chip->ops->set_channel(rtwdev, &ch_param);
 
-	rtw89_chip_set_txpwr(rtwdev);
+	rtw89_core_set_chip_txpwr(rtwdev);
 
 	rtw89_chip_set_channel_done(rtwdev, &bak);
 
-	if (band_changed) {
+	if (!entity_active || band_changed) {
 		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, hal->current_band_type);
 		rtw89_chip_rfk_band_changed(rtwdev);
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 239d47d0ec6d6..55f5b79475e91 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2614,6 +2614,8 @@ struct rtw89_hal {
 	u8 rx_nss;
 	bool support_cckpd;
 	bool support_igi;
+
+	bool entity_active;
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
@@ -3641,18 +3643,6 @@ static inline void rtw89_chip_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
 		chip->ops->set_txpwr_ctrl(rtwdev);
 }
 
-static inline void rtw89_chip_set_txpwr(struct rtw89_dev *rtwdev)
-{
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 ch = rtwdev->hal.current_channel;
-
-	if (!ch)
-		return;
-
-	if (chip->ops->set_txpwr)
-		chip->ops->set_txpwr(rtwdev);
-}
-
 static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -3883,6 +3873,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
+void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 93124b815825f..85e333e995d2a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3,6 +3,7 @@
  */
 
 #include "cam.h"
+#include "chan.h"
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
@@ -1081,7 +1082,6 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
 	int (*cfg_func)(struct rtw89_dev *rtwdev);
-	struct rtw89_hal *hal = &rtwdev->hal;
 	int ret;
 	u8 val;
 
@@ -1113,7 +1113,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
-		hal->current_channel = 0;
+		rtw89_set_entity_state(rtwdev, false);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 20c7afd3e70fe..6e5a740b128f0 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -346,7 +346,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	rtw89_debug_regd(rtwdev, rtwdev->regd, "get from initiator %d, alpha2",
 			 request->initiator);
 
-	rtw89_chip_set_txpwr(rtwdev);
+	rtw89_core_set_chip_txpwr(rtwdev);
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index eb2d3ec28775f..41cd619f4e980 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -228,7 +228,7 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 	}
 
 	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_COMMON, cfg_common, sar);
-	rtw89_chip_set_txpwr(rtwdev);
+	rtw89_core_set_chip_txpwr(rtwdev);
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
-- 
2.25.1

